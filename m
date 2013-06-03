From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 03 Jun 2013 14:49:28 +0200
Subject: [PATCH 0/6] Samsung watchdog support clean-up
In-Reply-To: <51A9ADF4.8010102@gmail.com>
References: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
 <51A9ADF4.8010102@gmail.com>
Message-ID: <1850418.EOBZxN7PB0@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester, Kukjin,

On Saturday 01 of June 2013 10:16:52 Sylwester Nawrocki wrote:
> Hi Tomasz,
> 
> On 05/19/2013 12:37 AM, Tomasz Figa wrote:
> > This series is aiming at cleaning up a bit watchdog support on Samsung
> > SoCs. The patches tweak a bit all the watchdog handling code here and
> > there, with the goal of making it DT- and multiplatform-friendly.
> > 
> > See particular patches for more detailed descriptions.
> > 
> > On S3C6410-based Tiny6410 board (Mini6410-compatible):
> > 
> > Tested-by: Tomasz Figa<tomasz.figa@gmail.com>
> 
> I've tested this series on a s3c2440 based board. The system restart
> works fine.
> 
> Tested-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>

Thank you Sylwester for testing this series.

Kukjin, since it has been already tested on s3c24xx and s3c64xx and nobody 
seems to care about s5p64x0 and s5pc100 (although I don't see a reason why 
these patches should break them), could we have this series applied?

Best regards,
-- 
Tomasz Figa
Linux Kernel Developer
Samsung R&D Institute Poland
Samsung Electronics

> > Depends on:
> >   - [PATCH] ARM: s5p64x0: Use common uncompress.h part for plat-samsung
> > 
> > Tomasz Figa (6):
> >    watchdog: s3c2410_wdt: Use local register definitions
> >    ARM: SAMSUNG: uncompress: Use local definitions of watchdog registers
> >    ARM: SAMSUNG: Add watchdog reset driver
> >    ARM: SAMSUNG: Let platforms use the new watchdog reset driver
> >    ARM: SAMSUNG: Remove legacy watchdog reset code
> >    ARM: SAMSUNG: Remove unused plat/regs-watchdog.h header
> >   
> >   arch/arm/Kconfig                                   |  3 +
> >   arch/arm/mach-s3c24xx/Kconfig                      |  2 +
> >   arch/arm/mach-s3c24xx/s3c2410.c                    |  3 +-
> >   arch/arm/mach-s3c24xx/s3c244x.c                    |  3 +-
> >   arch/arm/mach-s3c64xx/common.c                     |  8 +-
> >   arch/arm/mach-s5p64x0/common.c                     |  4 +-
> >   arch/arm/mach-s5pc100/common.c                     |  3 +-
> >   arch/arm/plat-samsung/Kconfig                      |  6 ++
> >   arch/arm/plat-samsung/Makefile                     |  1 +
> >   arch/arm/plat-samsung/include/plat/regs-watchdog.h | 41 ---------
> >   arch/arm/plat-samsung/include/plat/uncompress.h    | 15 +++-
> >   .../arm/plat-samsung/include/plat/watchdog-reset.h | 38 ++-------
> >   arch/arm/plat-samsung/watchdog-reset.c             | 97
> >   ++++++++++++++++++++++ drivers/watchdog/s3c2410_wdt.c                  
> >     | 17 +++-
> >   14 files changed, 156 insertions(+), 85 deletions(-)
> >   delete mode 100644 arch/arm/plat-samsung/include/plat/regs-watchdog.h
> >   create mode 100644 arch/arm/plat-samsung/watchdog-reset.c>
> 
> --
> Regards,
> Sylwester
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
