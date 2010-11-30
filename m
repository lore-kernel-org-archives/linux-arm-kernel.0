From: jekhor@gmail.com (Yauhen Kharuzhy)
Date: Tue, 30 Nov 2010 10:27:20 +0200
Subject: [PATCH 06/10] ARM S3C24XX: Compile NAND device definition for
	SMDK boards
In-Reply-To: <001f01cb9062$9ffd3f40$dff7bdc0$%kim@samsung.com>
References: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
	<1290969027-10178-6-git-send-email-jekhor@gmail.com>
	<001f01cb9062$9ffd3f40$dff7bdc0$%kim@samsung.com>
Message-ID: <20101130082720.GB19722@jeknote.loshitsa1.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 04:45:53PM +0900, Kukjin Kim wrote:
> Yauhen Kharuzhy wrote:
> > 
> Hi,
> 
> > From: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> > 
> > Common SMDK code uses s3c_device_nand, but doesn't select it in Kconfig.
> > 
> Yeah, you're right. The common-smdk.c uses "s3c_device_nand" of
> "plat-samsung/dev-nand.c".
> But now the CONFIG_S3C_DEV_NAND already selected in CONFIG_PLAT_S3C24XX...
> 
> So I think this is useless...however, we need to sort dependencies of
> Kconfig for S3C24XX out.
OK. It was my rebased old patch and I didn't check necessity of it.

> 
> > Signed-off-by: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> > ---
> >  arch/arm/plat-s3c24xx/Kconfig |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
> > index 5a27b1b..f3e22f9 100644
> > --- a/arch/arm/plat-s3c24xx/Kconfig
> > +++ b/arch/arm/plat-s3c24xx/Kconfig
> > @@ -155,6 +155,7 @@ config S3C2412_IOTIMING
> > 
> >  config MACH_SMDK
> >  	bool
> > +	select S3C_DEV_NAND
> >  	help
> >  	  Common machine code for SMDK2410 and SMDK2440
> > 
> > --
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> 
> 

-- 
Yauhen Kharuzhy		jekhor _at_ gmail.com
			JID: jek at jabber.ru

A: No
Q: Should I quote below my post?
