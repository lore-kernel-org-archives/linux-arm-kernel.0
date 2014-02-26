From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 26 Feb 2014 09:29:52 +0100
Subject: [PATCH v3 15/20] ARM: shmobile: marzen-reference: Instantiate
 clkdevs for SCIF and TMU
In-Reply-To: <1393400016-23433-16-git-send-email-horms+renesas@verge.net.au>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-16-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdU1OJ8mMfe0-EJJizVXX0V=3YkELcTjfce8bk6qn9jhzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 8:33 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Now that the common clock framework is supported, the clock lookup
> entries in clock-r8a7779.c are not registered anymore. Devices must
> instead reference their clocks in the device tree. However, SCIF and CMT
> devices are still instantiated through platform code, and thus need a
> clock lookup entry.
>
> Retrieve the SCIF and CMT clock entries by name and register clkdevs for
> the corresponding devices. This will be removed when the SCIF and CMT
> devices will be instantiated from the device tree.
>
> Based on work for the Koelsch board by Laurent Pinchart.

Would be nice to do this on top of Magnu's shmobile_clk_workaround().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
