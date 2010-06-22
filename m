From: jekhor@gmail.com (Yauhen Kharuzhy)
Date: Tue, 22 Jun 2010 17:05:37 +0300
Subject: [PATCH 4/4] ARM: S3C2416: Add platform helpers for setup SDHCI
In-Reply-To: <4C20B860.80308@gmail.com>
References: <1277212585-25605-1-git-send-email-jekhor@gmail.com>
	<1277212585-25605-2-git-send-email-jekhor@gmail.com>
	<1277212585-25605-3-git-send-email-jekhor@gmail.com>
	<1277212585-25605-4-git-send-email-jekhor@gmail.com>
	<1277212585-25605-5-git-send-email-jekhor@gmail.com>
	<4C20B860.80308@gmail.com>
Message-ID: <20100622140537.GA3669@jeknote.loshitsa1.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 22, 2010 at 03:19:28PM +0200, Maurus Cuelenaere wrote:
> Op 22-06-10 15:16, Yauhen Kharuzhy schreef:
> > Samsung S3C2416 has two SDHCI controllers compatible with other
> > Samsung's SoCs (S3C64XX, S5PC100 etc...).
> >
> > Add required platform setup code that the devices can be used with
> > sdhci-s3c driver.
> >
> > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > ---
> >  arch/arm/mach-s3c2416/Kconfig              |   23 ++++++++++
> >  arch/arm/mach-s3c2416/Makefile             |    5 ++
> >  arch/arm/mach-s3c2416/s3c2416.c            |    5 ++
> >  arch/arm/mach-s3c2416/setup-sdhci-gpio.c   |   60 +++++++++++++++++++++++++++
> >  arch/arm/mach-s3c2416/setup-sdhci.c        |   62 ++++++++++++++++++++++++++++
> >  arch/arm/plat-samsung/include/plat/sdhci.h |   34 +++++++++++++++
> >  6 files changed, 189 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-s3c2416/setup-sdhci-gpio.c
> >  create mode 100644 arch/arm/mach-s3c2416/setup-sdhci.c
> >
> > diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
> > index eafb0ed..e055c7f 100644
> > --- a/arch/arm/mach-s3c2416/Kconfig
> > +++ b/arch/arm/mach-s3c2416/Kconfig
> > @@ -25,6 +25,17 @@ config S3C2416_DMA
> >  	help
> >  	  Internal config node for S3C2416 DMA support
> >  
> > +config S3C2416_SETUP_SDHCI
> > +	bool
> > +	select S3C2416_SETUP_SDHCI_GPIO
> > +	help
> > +	  Internal helper functions for S3C2416 based SDHCI systems
> > +
> > +config S3C2416_SETUP_SDHCI_GPIO
> > +	bool
> > +	help
> > +	  Common setup code for SDHCI gpio.
> > +
> >  menu "S3C2416 Machines"
> >  
> >  config MACH_SMDK2416
> > @@ -36,7 +47,19 @@ config MACH_SMDK2416
> >  	select S3C_DEV_HSMMC1
> >  	select S3C_DEV_NAND
> >  	select S3C_DEV_USB_HOST
> > +	select S3C2416_SETUP_SDHCI
> >  	help
> >  	  Say Y here if you are using an SMDK2416
> >  
> > +config MACH_HANLIN_V3C
> > +	bool "Hanlin eReader V3C"
> > +	select CPU_S3C2416
> > +	select S3C_DEV_HSMMC
> > +	select S3C_DEV_HSMMC1
> > +	select S3C_DEV_NAND
> > +	select S3C_DEV_USB_HOST
> > +	select S3C2416_SETUP_SDHCI
> > +	help
> > +	  Say Y here if you are using an Jinke's Hanlin V3C eReader
> > +
> >   
> 
> This seems to be unrelated to the patch?
I am sorry, will resend.
> 
> >  endmenu

-- 
Yauhen Kharuzhy		jekhor _at_ gmail.com
			JID: jek at jabber.ru

A: No
Q: Should I quote below my post?
