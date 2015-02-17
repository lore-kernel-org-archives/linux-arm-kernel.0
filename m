From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 17 Feb 2015 16:31:37 +0100
Subject: [PATCH v3 0/2] ARM: shmobile: sh73a0: Enable DT PM domain support
Message-ID: <1424187099-5628-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series contains the missing pieces to enable DT PM domain
support on the Renesas SH-Mobile AG5 (sh73a0) SoC. As a bonus, it also
allows the use of the R-Mobile Reset driver to restart the system.

root at kzm9g:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
    domain                      status         slaves
           /device                                      runtime status
----------------------------------------------------------------------
a2sl                            on
a3sm                            on               a2sl
a3sg                            off
a3sp                            on
    /devices/platform/e6820000.i2c                      suspended
    /devices/platform/e6822000.i2c                      suspended
    /devices/platform/e6826000.i2c                      suspended
    /devices/platform/e6c80000.serial                   active
    /devices/platform/ee100000.sd                       active
    /devices/platform/ee140000.sd                       active
    /devices/platform/e6bd0000.mmc                      active
a4s                             on               a3sp, a3sg, a3sm
    /devices/platform/e6900000.irqpin                   active
    /devices/platform/e6900004.irqpin                   active
    /devices/platform/e6900008.irqpin                   active
    /devices/platform/e690000c.irqpin                   active
    /devices/platform/fec10000.bus                      active
a2rv                            off
a3r                             off              a2rv
a4rm                            off              a3r
a3vc                            off
a3mp                            off
a4mp                            off              a3mp, a3vc
    /devices/platform/ec230000.sound                    suspended
a4lc1                           off
a4lc0                           off
a4bc1                           on
a4bc0                           on
d4                              off
c4                              off
c5                              on               c4, d4, a4bc0, a4bc1, a4lc0, a4lc1, a4mp, a4rm, a4s
    /devices/platform/e6050000.pfc                      unsupported
    /devices/platform/e6138000.timer                    active
root at kzm9g:~#

This depends on the series "[PATCH v4 0/5] ARM: shmobile: sh73a0/kzm9g:
Complete multiplatform support".

Thanks for applying!

Geert Uytterhoeven (2):
  ARM: shmobile: sh73a0 dtsi: Add PM domain support
  drivers: sh: Disable PM runtime for multi-platform sh73a0 with genpd

 arch/arm/boot/dts/sh73a0.dtsi | 144 +++++++++++++++++++++++++++++++++++++++++-
 drivers/sh/pm_runtime.c       |   4 +-
 2 files changed, 144 insertions(+), 4 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
