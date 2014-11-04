From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 4 Nov 2014 09:20:44 +0100
Subject: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
In-Reply-To: <2024276.CFr3nVUAlA@vostro.rjw.lan>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <5370046.DXkB0EA6xC@vostro.rjw.lan>
 <CAPDyKFo_sxW8bE=C29fyfsqOO0tk_=eYFRkCVFRWc2kUx_bQHA@mail.gmail.com>
 <2024276.CFr3nVUAlA@vostro.rjw.lan>
Message-ID: <CAMuHMdVjzRJUL4EL1VbbYdys35f9Jz67_QSPriYnccSOnm1tQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 4, 2014 at 2:43 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> That is quite simple to address, though.  You can register a bus type
> notifier that will power up the domain on BUS_NOTIFY_ADD_DEVICE events
> (where the target device belongs to the domain), and do that only for
> CONFIG_PM_RUNTIME unset (otherwise runtime PM should take care of this).

Registering a bus type notifier (that will be a platform bus notifier,
right?) will affect
all platform devices, not only the on-SoC devices.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
