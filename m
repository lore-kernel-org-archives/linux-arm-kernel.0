From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 03 Dec 2010 21:37:58 +0900
Subject: [PATCH 06/10] ARM S3C24XX: Compile NAND device definition for SMDK
	boards
In-Reply-To: <20101130082720.GB19722@jeknote.loshitsa1.net>
References: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
	<1290969027-10178-6-git-send-email-jekhor@gmail.com>
	<001f01cb9062$9ffd3f40$dff7bdc0$%kim@samsung.com>
	<20101130082720.GB19722@jeknote.loshitsa1.net>
Message-ID: <015d01cb92e6$ecdb4ec0$c691ec40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yauhen Kharuzhy wrote:
> 
> > > Common SMDK code uses s3c_device_nand, but doesn't select it in
Kconfig.
> > >
> > Yeah, you're right. The common-smdk.c uses "s3c_device_nand" of
> > "plat-samsung/dev-nand.c".
> > But now the CONFIG_S3C_DEV_NAND already selected in
CONFIG_PLAT_S3C24XX...
> >

Oh, it's typo :-(

commit 7f4145abcee3e48d9f01cca16baa0f21e4b55e21
Author: Kukjin Kim <kgene.kim@samsung.com>
Date:   Fri Dec 3 21:22:42 2010 +0900

    ARM: S3C24XX: Fix CONFIG_S3C_DEV_NAND Kconfig entry

    Should be CONFIG_S3C_DEV_NAND instead of CONFIG_S3C_DEVICE_NAND.

    Cc: Ben Dooks <ben-linux@fluff.org>
    Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index 5a27b1b..eb105e6 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -8,7 +8,7 @@ config PLAT_S3C24XX
        default y
        select NO_IOPORT
        select ARCH_REQUIRE_GPIOLIB
-       select S3C_DEVICE_NAND
+       select S3C_DEV_NAND
        select S3C_GPIO_CFG_S3C24XX
        help
          Base platform code for any Samsung S3C24XX device


> > So I think this is useless...however, we need to sort dependencies of
> > Kconfig for S3C24XX out.
> OK. It was my rebased old patch and I didn't check necessity of it.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
