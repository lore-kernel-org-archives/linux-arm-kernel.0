Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3B6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:00:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD4520880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nPf+M23h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD4520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nghAOFFPCNWrOazF/8i/H8E3nNNkDMfPfVEI1HHnMPw=; b=nPf+M23h5f/+Zw
	wFuK2VArZdG3RKpal6WJU9JK/rzYAxXFrdBygiTgp6mcyYFIChWp6H5ut2QlFz++JjcV7KnSV5ku+
	EoCdqE1mr/oQOgcAkrv3ILZCCn9EscWNNr5o4qhwG0cAXGEEnDmGt5fmrJ//ZyQJfXPyTmyauDXX0
	sbjAoBw8/zz81AiZLUEuKDcuODHfoZblwZv262NMKJwTzzfkNCn1e12UnIOHNq30aEr2rYg0V+59p
	47vJj+MIL3/HFZThXD7LtTzD69ilrbIiZWovWcaj9M2Ju3pUVopsbHwZ9t9vymiyOCFiYpUoNA4cH
	u5Fi4xYG0dIqo8zNaEEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnxb-0006He-4l; Thu, 21 Feb 2019 13:00:19 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnvo-0002ru-BD; Thu, 21 Feb 2019 12:58:30 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 103BAC0011;
 Thu, 21 Feb 2019 12:58:20 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [RFC PATCH 15/27] mtd: nand: Remove useless include about software
 Hamming ECC
Date: Thu, 21 Feb 2019 13:57:54 +0100
Message-Id: <20190221125806.28875-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221125806.28875-1-miquel.raynal@bootlin.com>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_045828_689106_0106F2F1 
X-CRM114-Status: GOOD (  10.10  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@microchip.com>,
 Julien Su <juliensu@mxic.com.tw>,
 Schrempf Frieder <frieder.schrempf@kontron.de>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mason Yang <masonccyang@mxic.com.tw>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Most of the includes are simply useless, drop them.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm/mach-s3c24xx/common-smdk.c    | 1 -
 arch/arm/mach-s3c24xx/mach-anubis.c    | 1 -
 arch/arm/mach-s3c24xx/mach-at2440evb.c | 1 -
 arch/arm/mach-s3c24xx/mach-bast.c      | 1 -
 arch/arm/mach-s3c24xx/mach-gta02.c     | 1 -
 arch/arm/mach-s3c24xx/mach-jive.c      | 1 -
 arch/arm/mach-s3c24xx/mach-mini2440.c  | 1 -
 arch/arm/mach-s3c24xx/mach-osiris.c    | 1 -
 arch/arm/mach-s3c24xx/mach-qt2410.c    | 1 -
 arch/arm/mach-s3c24xx/mach-rx3715.c    | 1 -
 arch/arm/mach-s3c24xx/mach-vstms.c     | 1 -
 drivers/mtd/nand/raw/fsl_elbc_nand.c   | 1 -
 drivers/mtd/nand/raw/fsl_ifc_nand.c    | 1 -
 drivers/mtd/nand/raw/fsl_upm.c         | 1 -
 drivers/mtd/nand/raw/fsmc_nand.c       | 1 -
 drivers/mtd/nand/raw/lpc32xx_mlc.c     | 1 -
 drivers/mtd/nand/raw/lpc32xx_slc.c     | 1 -
 drivers/mtd/nand/raw/pasemi_nand.c     | 1 -
 drivers/mtd/nand/raw/s3c2410.c         | 1 -
 drivers/mtd/nand/raw/sharpsl.c         | 1 -
 drivers/mtd/nand/raw/tmio_nand.c       | 1 -
 drivers/mtd/nand/raw/txx9ndfmc.c       | 1 -
 include/linux/mtd/sharpsl.h            | 1 -
 23 files changed, 23 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/common-smdk.c b/arch/arm/mach-s3c24xx/common-smdk.c
index 8fe2e62ef730..7cab64bea951 100644
--- a/arch/arm/mach-s3c24xx/common-smdk.c
+++ b/arch/arm/mach-s3c24xx/common-smdk.c
@@ -19,7 +19,6 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index 8f1c505185b4..8e4410d1bfa1 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -36,7 +36,6 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 
 #include <net/ax88796.h>
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
index 94057a8b8778..35dc86805dce 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
@@ -37,7 +37,6 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index 08d88540becf..3f8e2e7a2dff 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -24,7 +24,6 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 
 #include <linux/platform_data/asoc-s3c24xx_simtec.h>
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index 5882b370cbcf..b63f5c2aeac7 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -36,7 +36,6 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index 658be0b24fcb..d9b920ad444e 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -40,7 +40,6 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 
 #include <plat/gpio-cfg.h>
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index abbdc44dfb8f..cdc305bbb74f 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -46,7 +46,6 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 
 #include <plat/gpio-cfg.h>
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index c00ec4d851b7..025a7678b5cc 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -33,7 +33,6 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index 9d6e92b51e60..a1835139a6a6 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -21,7 +21,6 @@
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-s3c24xx/mach-rx3715.c b/arch/arm/mach-s3c24xx/mach-rx3715.c
index f9668f4634dc..13c73f6063bb 100644
--- a/arch/arm/mach-s3c24xx/mach-rx3715.c
+++ b/arch/arm/mach-s3c24xx/mach-rx3715.c
@@ -22,7 +22,6 @@
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-s3c24xx/mach-vstms.c b/arch/arm/mach-s3c24xx/mach-vstms.c
index 94f6d5ce0246..c1db572d2513 100644
--- a/arch/arm/mach-s3c24xx/mach-vstms.c
+++ b/arch/arm/mach-s3c24xx/mach-vstms.c
@@ -16,7 +16,6 @@
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 #include <linux/memblock.h>
 
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index 3aa88346d7cc..ed84b25e8e6e 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -35,7 +35,6 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 
 #include <asm/io.h>
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 3815487bcddd..ac85e9dd1318 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -28,7 +28,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/fsl_ifc.h>
 #include <linux/iopoll.h>
 
diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index c60bd00d9f2b..224ba9449fc2 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -15,7 +15,6 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/mtd.h>
 #include <linux/of_address.h>
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 91e813fe7dd8..797028037f78 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -26,7 +26,6 @@
 #include <linux/types.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/mtd/partitions.h>
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index b821dc083542..af75eabddc6f 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -41,7 +41,6 @@
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 
 #define DRV_NAME "lpc32xx_mlc"
 
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index f2924ea8e126..5629ef7750aa 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -32,7 +32,6 @@
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
diff --git a/drivers/mtd/nand/raw/pasemi_nand.c b/drivers/mtd/nand/raw/pasemi_nand.c
index 3944dc653609..3b6f51a31e7d 100644
--- a/drivers/mtd/nand/raw/pasemi_nand.c
+++ b/drivers/mtd/nand/raw/pasemi_nand.c
@@ -26,7 +26,6 @@
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index 8d79813e83d5..b8462b9b4276 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -43,7 +43,6 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 
 #include <linux/platform_data/mtd-nand-s3c2410.h>
diff --git a/drivers/mtd/nand/raw/sharpsl.c b/drivers/mtd/nand/raw/sharpsl.c
index 35baff68993f..df542d77b1db 100644
--- a/drivers/mtd/nand/raw/sharpsl.c
+++ b/drivers/mtd/nand/raw/sharpsl.c
@@ -16,7 +16,6 @@
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/sharpsl.h>
 #include <linux/interrupt.h>
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index 7eeef6634c0c..6fac98df3a92 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -35,7 +35,6 @@
 #include <linux/ioport.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 #include <linux/slab.h>
 
diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index 85019684dee7..afdb947253bf 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -17,7 +17,6 @@
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
 #include <linux/platform_data/txx9/ndfmc.h>
diff --git a/include/linux/mtd/sharpsl.h b/include/linux/mtd/sharpsl.h
index 77528c2e0a80..3375a9958cfe 100644
--- a/include/linux/mtd/sharpsl.h
+++ b/include/linux/mtd/sharpsl.h
@@ -9,7 +9,6 @@
  */
 
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 
 struct sharpsl_nand_platform_data {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
