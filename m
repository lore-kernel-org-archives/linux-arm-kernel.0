From: horms@verge.net.au (Simon Horman)
Date: Wed, 18 Feb 2015 16:21:07 -0500
Subject: [PATCH v3 0/2] ARM: shmobile: sh73a0: Enable DT PM domain support
In-Reply-To: <1424187099-5628-1-git-send-email-geert+renesas@glider.be>
References: <1424187099-5628-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150218212106.GF12754@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 17, 2015 at 04:31:37PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series contains the missing pieces to enable DT PM domain
> support on the Renesas SH-Mobile AG5 (sh73a0) SoC. As a bonus, it also
> allows the use of the R-Mobile Reset driver to restart the system.
> 
> root at kzm9g:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
>     domain                      status         slaves
>            /device                                      runtime status
> ----------------------------------------------------------------------
> a2sl                            on
> a3sm                            on               a2sl
> a3sg                            off
> a3sp                            on
>     /devices/platform/e6820000.i2c                      suspended
>     /devices/platform/e6822000.i2c                      suspended
>     /devices/platform/e6826000.i2c                      suspended
>     /devices/platform/e6c80000.serial                   active
>     /devices/platform/ee100000.sd                       active
>     /devices/platform/ee140000.sd                       active
>     /devices/platform/e6bd0000.mmc                      active
> a4s                             on               a3sp, a3sg, a3sm
>     /devices/platform/e6900000.irqpin                   active
>     /devices/platform/e6900004.irqpin                   active
>     /devices/platform/e6900008.irqpin                   active
>     /devices/platform/e690000c.irqpin                   active
>     /devices/platform/fec10000.bus                      active
> a2rv                            off
> a3r                             off              a2rv
> a4rm                            off              a3r
> a3vc                            off
> a3mp                            off
> a4mp                            off              a3mp, a3vc
>     /devices/platform/ec230000.sound                    suspended
> a4lc1                           off
> a4lc0                           off
> a4bc1                           on
> a4bc0                           on
> d4                              off
> c4                              off
> c5                              on               c4, d4, a4bc0, a4bc1, a4lc0, a4lc1, a4mp, a4rm, a4s
>     /devices/platform/e6050000.pfc                      unsupported
>     /devices/platform/e6138000.timer                    active
> root at kzm9g:~#
> 
> This depends on the series "[PATCH v4 0/5] ARM: shmobile: sh73a0/kzm9g:
> Complete multiplatform support".
> 
> Thanks for applying!

Thanks, done.
