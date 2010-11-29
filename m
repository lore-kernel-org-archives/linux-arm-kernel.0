From: jekhor@gmail.com (Yauhen Kharuzhy)
Date: Mon, 29 Nov 2010 13:22:28 +0200
Subject: [PATCH 01/10] SMDK2416: Select MACH_SMDK, S3C_DEV_NAND,
	S3C_DEV_USB_HOST
In-Reply-To: <000e01cb8fb3$73666740$5a3335c0$%kim@samsung.com>
References: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
	<000e01cb8fb3$73666740$5a3335c0$%kim@samsung.com>
Message-ID: <20101129112228.GB7033@jeknote.loshitsa1.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 07:51:56PM +0900, Kukjin Kim wrote:
> Yauhen Kharuzhy wrote:
> > 
> > Enable compilation of platform devices and initialization code used in
> > SMDK2416 board file.
> > 
> > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > ---
> >  arch/arm/mach-s3c2416/Kconfig |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
> > index 87b9c9f..27b3e7c 100644
> > --- a/arch/arm/mach-s3c2416/Kconfig
> > +++ b/arch/arm/mach-s3c2416/Kconfig
> > @@ -35,9 +35,12 @@ menu "S3C2416 Machines"
> >  config MACH_SMDK2416
> >  	bool "SMDK2416"
> >  	select CPU_S3C2416
> > +	select MACH_SMDK
> 
> No need to add this here.

SMDK2416 board code uses generic SMDK code, so it should be compiled
also.

> According to mach-s3c2416/Kconfig, CPU_S3C2416 depends on ARCH_S3C2410.
> Actually only selected it when selected ARCH_S3C24XX...

Can you clarify this?

> 
> But I think need to sort out selection for S3C24XX in Kconfig.

> >  	select S3C_DEV_FB
> >  	select S3C_DEV_HSMMC
> >  	select S3C_DEV_HSMMC1
> > +	select S3C_DEV_NAND
> > +	select S3C_DEV_USB_HOST
> 
> Probably, did you test NAND and USB_HOST on board?
Yes, but one year ago. I don't have access to SMDK2416 anymore and usually
test my patches on another S3C2416 board (e-book reader prototype).

Without selection of S3C_DEV_NAND & S3C_DEV_USB_HOST mach-smdk2416.c
doesn't compile, so we should either enable this platform devices
definitions, either remove this devices from board file.

> 
> >  	select S3C2416_PM if PM
> >  	help
> >  	  Say Y here if you are using an SMDK2416
> > --
 

-- 
Yauhen Kharuzhy		jekhor _at_ gmail.com
			JID: jek at jabber.ru

A: No
Q: Should I quote below my post?
