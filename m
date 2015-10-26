From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 26 Oct 2015 09:16:48 +0100
Subject: [PATCH v6 04/22] of: add function to allow probing a device from
 a OF node
In-Reply-To: <1442844182-27787-5-git-send-email-tomeu.vizoso@collabora.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-5-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAMuHMdW=sT9uLbZkwdYF9Yd3ENaAoQ0=qQLfr-Ow6pz11DiU0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 4:02 PM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> Walks the OF tree up and finds the closest ancestor that has a struct
> device associated with it, probing it if isn't bound to a driver yet.
>
> The above should ensure that the dependency represented by the passed OF
> node is available, because probing a device should cause its descendants
> to be probed as well (when they get registered).
>
> Subsystems can use this when looking up resources for drivers, to reduce
> the chances of deferred probes because of the probing order of devices.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Don't know to which response I should post this comment, so I'm responding
to the original email.

Some subsystems already do this.
If you call e.g. syscon_regmap_lookup_by_phandle(), it will call
of_syscon_register() if the syscon device pointed to hasn't been registered yet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
