From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 26 Oct 2015 09:18:57 +0100
Subject: Possible Regression due to c074fef5d36e ("of/platform: Defer
 probes of registered devices").
In-Reply-To: <20151026032039.GA1950@verge.net.au>
References: <20151026032039.GA1950@verge.net.au>
Message-ID: <CAMuHMdVGQ5w+Rr=wcWhgkpSVWLG_1U6sw2BXYyw9AA=SOzz+ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Oct 26, 2015 at 4:20 AM, Simon Horman <horms@verge.net.au> wrote:
> I have observed a possible regression in next-20151022
> due to c074fef5d36e ("of/platform: Defer probes of registered devices").
>
> The problem manifests on the r8a7791 based koelsch board.
> With the above patch present booting the board using the shmobile_defconfig
> results in no console output. While after reverting the above patch
> the boot proceeds all the way to user-space.
>
> With DEBUG_LL and EARLY_PRINTK enabled I was able to capture some console
> output. I have included both that boot log, and a log of boot all the way to
> userspace with the patch in question reverted.
>
> The problem does not seem to manifiest on other boards for other
> Renesas ARM  SoCs that I have access too. In particular the
> r8a7790 based lager board; the r8a7790 and r8a7791 are both members
> of the R-Car Gen2 family of SoCs.

> bootconsole [earlycon0] disabled

Please append "keep_bootcon" to the kernel command line, so you get to
see the rest of the boot up logs, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
