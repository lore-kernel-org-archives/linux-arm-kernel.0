From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 20 Sep 2011 17:52:08 -0600
Subject: [PATCH 1/7 (RE-SEND)] gpio/s3c24xx: move gpio driver into
	drivers/gpio/
In-Reply-To: <001f01cc76bd$1ebad900$5c308b00$%kim@samsung.com>
References: <1314707249-12241-1-git-send-email-kgene.kim@samsung.com>
	<1314707249-12241-2-git-send-email-kgene.kim@samsung.com>
	<001f01cc76bd$1ebad900$5c308b00$%kim@samsung.com>
Message-ID: <20110920235208.GW7781@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 08:13:12PM +0900, Kukjin Kim wrote:
> Kukjin Kim wrote:
> >
> 
> (snip)...
> 
> Hi Grant,
> 
> I didn't get any comments on this series, gpio-samsung patches for
> consolidation of Samsung gpiolib. Please let me know whether this is ok to
> you or not. And I think, if you're ok, this should be sent to upstream via
> both gpio tree and arm(samsung) tree to avoid conflicts...
> 
> As a note, following is its status...
> 
> Kukjin Kim (9):
>       ARM: SAMSUNG: Move map header file into plat-samsung
>       gpio/s3c24xx: move gpio driver into drivers/gpio/
>       gpio/s3c64xx: move gpio driver into drivers/gpio/
>       gpio/s5p64x0: move gpio driver into drivers/gpio/
>       gpio/samsung: Remove useless old Samsung related GPIO drivers
>       gpio/samsung: Added gpio-samsung.c to support Samsung GPIOs
>       ARM: SAMSUNG: Update the name of regarding Samsung GPIO
>       ARM: SAMSUNG: Remove useless Samsung GPIO related CONFIGs
>       Merge branch 'next/topic-plat-samsung-1' into next/topic-gpio-samsung

Actually, even though I said I would pick it up, you've already got it
in a tree, so you can go ahead and merge it with my ack.  I don't see
any major risk of conflicts for the next merge window, so there is no
need to merge it in the gpio tree also.

g.

> 
>  arch/arm/Kconfig                                   |    3 -
>  arch/arm/mach-exynos4/include/mach/pm-core.h       |    2 +-
>  arch/arm/mach-s3c2410/Kconfig                      |    7 -
>  arch/arm/mach-s3c2410/Makefile                     |    1 -
>  arch/arm/mach-s3c2410/include/mach/gpio-fns.h      |   99 +-
>  arch/arm/mach-s3c2410/include/mach/gpio-track.h    |    6 +-
>  arch/arm/mach-s3c2410/include/mach/map.h           |   52 +-
>  arch/arm/mach-s3c2410/include/mach/pm-core.h       |    2 +-
>  arch/arm/mach-s3c2410/s3c2410.c                    |    4 +-
>  arch/arm/mach-s3c2412/Kconfig                      |    1 -
>  arch/arm/mach-s3c2412/Makefile                     |    1 -
>  arch/arm/mach-s3c2412/gpio.c                       |    2 +-
>  arch/arm/mach-s3c2416/Kconfig                      |    1 -
>  arch/arm/mach-s3c2416/s3c2416.c                    |    4 +-
>  arch/arm/mach-s3c2440/Kconfig                      |    4 -
>  arch/arm/mach-s3c2440/s3c2440.c                    |    4 +-
>  arch/arm/mach-s3c2440/s3c2442.c                    |    4 +-
>  arch/arm/mach-s3c2443/Kconfig                      |    1 -
>  arch/arm/mach-s3c2443/s3c2443.c                    |    4 +-
>  arch/arm/mach-s3c64xx/Makefile                     |    1 -
>  arch/arm/mach-s3c64xx/gpiolib.c                    |  290 ---
>  arch/arm/mach-s3c64xx/include/mach/map.h           |    9 +-
>  arch/arm/mach-s3c64xx/include/mach/pm-core.h       |    2 +-
>  arch/arm/mach-s5p64x0/Makefile                     |    2 +-
>  arch/arm/mach-s5p64x0/gpiolib.c                    |  511 ----
>  arch/arm/mach-s5pv210/include/mach/pm-core.h       |    2 +-
>  arch/arm/plat-s3c24xx/Kconfig                      |    1 -
>  arch/arm/plat-s3c24xx/Makefile                     |    2 -
>  arch/arm/plat-s3c24xx/gpio.c                       |   96 -
>  arch/arm/plat-s3c24xx/gpiolib.c                    |  229 --
>  arch/arm/plat-s3c24xx/include/plat/map.h           |  100 -
>  arch/arm/plat-s5p/Kconfig                          |    3 -
>  arch/arm/plat-s5p/irq-gpioint.c                    |   10 +-
>  arch/arm/plat-samsung/Kconfig                      |   27 -
>  arch/arm/plat-samsung/Makefile                     |    2 -
>  arch/arm/plat-samsung/gpio-config.c                |  431 ----
>  arch/arm/plat-samsung/gpio.c                       |  167 --
>  .../plat-samsung/include/plat/gpio-cfg-helpers.h   |  172 +-
>  arch/arm/plat-samsung/include/plat/gpio-cfg.h      |   34 +-
>  arch/arm/plat-samsung/include/plat/gpio-core.h     |   97 +-
>  arch/arm/plat-samsung/include/plat/gpio-fns.h      |   98 +
>  arch/arm/plat-samsung/include/plat/map-s3c.h       |   84 +
>  .../include/plat/map-s5p.h                         |    6 +-
>  arch/arm/plat-samsung/include/plat/pm.h            |   10 +-
>  arch/arm/plat-samsung/pm-gpio.c                    |   72 +-
>  arch/arm/plat-samsung/pm.c                         |    6 +-
>  drivers/gpio/Kconfig                               |   16 -
>  drivers/gpio/Makefile                              |    7 +-
>  drivers/gpio/gpio-exynos4.c                        |  385 ---
>  drivers/gpio/gpio-plat-samsung.c                   |  205 --
>  drivers/gpio/gpio-s5pc100.c                        |  354 ---
>  drivers/gpio/gpio-s5pv210.c                        |  287 ---
>  drivers/gpio/gpio-samsung.c                        | 2686
> ++++++++++++++++++++
>  53 files changed, 3072 insertions(+), 3534 deletions(-)
>  delete mode 100644 arch/arm/mach-s3c64xx/gpiolib.c
>  delete mode 100644 arch/arm/mach-s5p64x0/gpiolib.c
>  delete mode 100644 arch/arm/plat-s3c24xx/gpio.c
>  delete mode 100644 arch/arm/plat-s3c24xx/gpiolib.c
>  delete mode 100644 arch/arm/plat-s3c24xx/include/plat/map.h
>  delete mode 100644 arch/arm/plat-samsung/gpio-config.c
>  delete mode 100644 arch/arm/plat-samsung/gpio.c
>  create mode 100644 arch/arm/plat-samsung/include/plat/gpio-fns.h
>  create mode 100644 arch/arm/plat-samsung/include/plat/map-s3c.h
>  rename arch/arm/{plat-s5p => plat-samsung}/include/plat/map-s5p.h (94%)
>  delete mode 100644 drivers/gpio/gpio-exynos4.c
>  delete mode 100644 drivers/gpio/gpio-plat-samsung.c
>  delete mode 100644 drivers/gpio/gpio-s5pc100.c
>  delete mode 100644 drivers/gpio/gpio-s5pv210.c
>  create mode 100644 drivers/gpio/gpio-samsung.c
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
