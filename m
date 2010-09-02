From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 02 Sep 2010 17:25:38 +0900
Subject: [PATCH 02/13] ARM: S5P64X0: Update Kconfig and Makefile
In-Reply-To: <AANLkTin_aQvv_U9z7VxGM-3VWMj-iWdS928aB30sETWp@mail.gmail.com>
References: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
	<1283324960-21629-3-git-send-email-kgene.kim@samsung.com>
	<AANLkTin_aQvv_U9z7VxGM-3VWMj-iWdS928aB30sETWp@mail.gmail.com>
Message-ID: <004b01cb4a78$74552860$5cff7920$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Wed, Sep 1, 2010 at 4:09 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > This patch updates the Kconfig and Makefile for the S5P6440 and S5P6450
> > machines. It also updates arch/arm/ Kconfig and Makefile to include for
> > support ARCH_S5P64X0 with one kernel image.
> >
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? 16 +++---
> > ?arch/arm/Makefile ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +-
> > ?arch/arm/mach-s5p6440/Kconfig ? ? ? ? ? ? ? ? ? ? ?| ? 33 ------------
> > ?arch/arm/mach-s5p6440/Makefile ? ? ? ? ? ? ? ? ? ? | ? 25 ---------
> > ?arch/arm/mach-s5p64x0/Kconfig ? ? ? ? ? ? ? ? ? ? ?| ? 55
> ++++++++++++++++++++
> > ?arch/arm/mach-s5p64x0/Makefile ? ? ? ? ? ? ? ? ? ? | ? 30 +++++++++++
> > ?.../{mach-s5p6440 => mach-s5p64x0}/Makefile.boot ? | ? ?0
> > ?arch/arm/plat-s5p/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?4 +-
> > ?8 files changed, 95 insertions(+), 70 deletions(-)
> > ?delete mode 100644 arch/arm/mach-s5p6440/Kconfig
> > ?delete mode 100644 arch/arm/mach-s5p6440/Makefile
> > ?create mode 100644 arch/arm/mach-s5p64x0/Kconfig
> > ?create mode 100644 arch/arm/mach-s5p64x0/Makefile
> > ?rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/Makefile.boot (100%)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index a7ed21f..40e75b3 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -679,17 +679,15 @@ config ARCH_S3C64XX
> > ? ? ? ?help
> > ? ? ? ? ?Samsung S3C64XX series based systems
> >
> > -config ARCH_S5P6440
> > - ? ? ? bool "Samsung S5P6440"
> > +config ARCH_S5P64X0
> > + ? ? ? bool "Samsung S5P6440 S5P6450"
> > ? ? ? ?select CPU_V6
> > ? ? ? ?select GENERIC_GPIO
> > ? ? ? ?select HAVE_CLK
> > - ? ? ? select HAVE_S3C2410_WATCHDOG
> > ? ? ? ?select ARCH_USES_GETTIMEOFFSET
> > - ? ? ? select HAVE_S3C2410_I2C
> > - ? ? ? select HAVE_S3C_RTC
> 
> Why HAVE_* is deleted?
> 
Ok...will add it.

> > ? ? ? ?help
> > - ? ? ? ? Samsung S5P6440 CPU based systems
> > + ? ? ? ? Samsung S5P64X0 CPU based systems, such as the Samsung
> SMDK6440,
> > + ? ? ? ? SMDK6450.
> >

(snip)

> > +
> > +config MACH_SMDK6440
> > + ? ? ? bool "SMDK6440"
> > + ? ? ? select CPU_S5P6440
> > + ? ? ? select S3C_DEV_I2C1
> > + ? ? ? select S3C_DEV_RTC
> > + ? ? ? select S3C_DEV_WDT
> > + ? ? ? select SAMSUNG_DEV_ADC
> > + ? ? ? select SAMSUNG_DEV_TS
> > + ? ? ? select S5P64X0_SETUP_I2C1
> > + ? ? ? help
> > + ? ? ? ? Machine support for the Samsung SMDK6440
> > +
> > +config MACH_SMDK6450
> > + ? ? ? bool "SMDK6450"
> > + ? ? ? select CPU_S5P6450
> > + ? ? ? select S3C_DEV_I2C1
> > + ? ? ? select S3C_DEV_RTC
> > + ? ? ? select S3C_DEV_WDT
> > + ? ? ? select SAMSUNG_DEV_ADC
> > + ? ? ? select SAMSUNG_DEV_TS
> > + ? ? ? select S5P64X0_SETUP_I2C1
> > + ? ? ? help
> > + ? ? ? ? Machine support for the Samsung SMDK6450
> 
> In most case SMDK has almost same functionality. make a common select
> e.g., SMDK_COMMON and each board just select it.

If required, will sort out next time with other architectures.

(snip)

> > +
> > +obj-$(CONFIG_MACH_SMDK6440) ? ?+= mach-smdk6440.o
> > +obj-$(CONFIG_MACH_SMDK6450) ? ?+= mach-smdk6450.o
> Are there difference between smdk6440 and smdk6450 except the SOC?
> If no, how about to make a single file as pxa or omap does?
> 
Because each components on the board are different,
SMDK6440 and SMDK6450 need each machine file...

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
