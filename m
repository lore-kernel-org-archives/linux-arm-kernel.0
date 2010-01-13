From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 13 Jan 2010 15:57:05 +0100
Subject: [PATCH] S3C: Remove unneeded __init symbols
In-Reply-To: <2accc2ff1001130639p2d33e95aj3d0730964c074bdf@mail.gmail.com>
References: <20100109100430.5258.8254.stgit@localhost>
	<20100109210339.GB10587@pengutronix.de>
	<2accc2ff1001130639p2d33e95aj3d0730964c074bdf@mail.gmail.com>
Message-ID: <20100113145705.GB1252@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jan 13, 2010 at 09:39:11AM -0500, Nelson Castillo wrote:
> 2010/1/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hi Nelson,
> >
> > On Sat, Jan 09, 2010 at 05:04:30AM -0500, Nelson Castillo wrote:
> >> Two functions defined with __init are also exported.
> >> Let's remove the __init symbols in order to avoid two warnings.
> > Can you quote the warnings please?
> 
> Done. Patch attached.
> 
> > And I thought you agreed that "unneeded" for __init isn't optimal.
> 
> I also changed the subject. I don't know if it's optimal but it's
> better now IMHO :-P

> From 0253f8900cba96ef1a5a8707ad1934f0a65f052a Mon Sep 17 00:00:00 2001
> From: Nelson Castillo <arhuaco@freaks-unidos.net>
> Date: Wed, 13 Jan 2010 09:33:59 -0500
> Subject: [PATCH] S3C: Fix two warnings caused by __init annotations
> 
> The symbols s3c24xx_ts_set_platdata and s3c_nand_set_platdata are
> exported and annotated __init. Let's remove the __init annotations
> to avoid the following warnings:
> 
>  WARNING: vmlinux.o(__ksymtab+0x428): Section mismatch in
>  reference from the variable __ksymtab_s3c24xx_ts_set_platdata
>  to the function .init.text:s3c24xx_ts_set_platdata()
>  The symbol  s3c24xx_ts_set_platdata is exported and annotated __init
>  Fix this by  removing the __init annotation of s3c24xx_ts_set_platdata
>  or drop the  export.
> 
>  WARNING: vmlinux.o(__ksymtab_gpl+0x40): Section mismatch in reference
>  from the variable __ksymtab_s3c_nand_set_platdata to the function
>  .init.text:s3c_nand_set_platdata()
>  The symbol s3c_nand_set_platdata  is exported and annotated __init
>  Fix this by removing the __init  annotation of s3c_nand_set_platdata
>  or drop the export.

	linux-2.6$ git grep -l -E 's3c(_nand|24xx_ts)_set_platdata'
	arch/arm/mach-s3c2410/include/mach/ts.h
	arch/arm/mach-s3c2410/mach-bast.c
	arch/arm/mach-s3c2410/mach-h1940.c
	arch/arm/mach-s3c2410/mach-qt2410.c
	arch/arm/mach-s3c2412/mach-jive.c
	arch/arm/mach-s3c2412/mach-vstms.c
	arch/arm/mach-s3c2440/mach-anubis.c
	arch/arm/mach-s3c2440/mach-at2440evb.c
	arch/arm/mach-s3c2440/mach-mini2440.c
	arch/arm/mach-s3c2440/mach-osiris.c
	arch/arm/mach-s3c2440/mach-rx3715.c
	arch/arm/mach-s3c2442/mach-gta02.c
	arch/arm/mach-s3c6410/mach-hmt.c
	arch/arm/plat-s3c/dev-nand.c
	arch/arm/plat-s3c/include/plat/nand.h
	arch/arm/plat-s3c24xx/common-smdk.c
	arch/arm/plat-s3c24xx/devs.c

This doesn't look to used in code that can be compiled as module.  So
isn't the more sensible fix to remove EXPORT_SYMBOL?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
