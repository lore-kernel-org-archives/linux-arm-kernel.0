From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 23 Oct 2018 13:32:16 +0200
Subject: [RESEND PATCH v3 3/3] sh: add the sh_ prefix to early platform
 symbols
In-Reply-To: <8636swude1.wl-marc.zyngier@arm.com>
References: <20180827090651.25062-1-brgl@bgdev.pl>
 <20180827090651.25062-4-brgl@bgdev.pl>
 <8636swude1.wl-marc.zyngier@arm.com>
Message-ID: <CAMuHMdWPPr56j3z4-eamtavt7cZ2jkKyE3W5_XiK1HNim8qXBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Tue, Oct 23, 2018 at 1:11 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Mon, 27 Aug 2018 10:06:51 +0100,
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> As for the whole "early device" debate, my take is that we'd be much
> better off making the device model available early, rather than trying
> to architect something that is simply papering over the issue.

The device model itself can be made available earlier, but the big blocker
is mainly the use of everything related to the scheduler (threads, msleep()),
which depends on the "early" timer.

I think it can be made to work if msleep() and all thread-related functions
would return -EPROBE_DEFER, but that should be handled in every
single driver, which may be already the case for thread-related functions,
but not for e.g. msleep(), which currently returns void.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
