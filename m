Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5A6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:28:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC27A20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iu8oIe3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC27A20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vp0x4aomSwGaU/lr9rFq8dKuSCnume5X2rUNmxnyM9M=; b=iu8oIe3WCIZZYb
	d0oVxKt+xur2UdwehirDdTwT3ZsH73rpSViFjF6Qv5QGIWYZp89ZlROVP72pUqfzp++jgNfbOgZ0n
	AEpnWI5lIhP+u09GejOvEwQsgxGTGfv/FRk4tSrBGAYc9ASpA2qa60NdAMdqNRd4Qe7KtEv3JuwZp
	YOXT+rkRU/e4GB0fmv9knUtRXNwrFgZ39OPblws+9uqV/O8HeSkA1X0YCx978J/sD2xxJYzZbBOSU
	MkXbS+1JInUPKobAy7QddUApWoUvbTkruqEqoSosOxn7VgT/wD7xMB4AUi7Vz4osXlAW1Zt958jBs
	jrFFtnZBXg2UiDNHqUkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwke3-00049D-6F; Thu, 21 Feb 2019 09:27:55 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwkdz-00047r-Cr; Thu, 21 Feb 2019 09:27:53 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C156040011;
 Thu, 21 Feb 2019 09:27:41 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [PATCH 2/6] mtd: nand: Clarify Kconfig entry for software BCH ECC
 algorithm
Date: Thu, 21 Feb 2019 10:27:29 +0100
Message-Id: <20190221092734.21634-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221092734.21634-1-miquel.raynal@bootlin.com>
References: <20190221092734.21634-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_012751_742312_29F554AA 
X-CRM114-Status: GOOD (  14.37  )
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
 Julien Su <juliensu@mxic.com.tw>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mason Yang <masonccyang@mxic.com.tw>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There is no point in having two distinct entries, merge them and
rename the symbol for more clarity: MTD_NAND_ECC_SW_BCH

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm/configs/omap2plus_defconfig            | 2 +-
 arch/arm/configs/pxa_defconfig                  | 2 +-
 arch/mips/configs/db1xxx_defconfig              | 2 +-
 arch/mips/configs/generic/board-ni169445.config | 2 +-
 drivers/mtd/devices/Kconfig                     | 2 +-
 drivers/mtd/nand/raw/Kconfig                    | 9 ++-------
 drivers/mtd/nand/raw/Makefile                   | 2 +-
 drivers/mtd/nand/raw/nand_base.c                | 2 +-
 drivers/mtd/nand/raw/omap2.c                    | 4 ++--
 include/linux/mtd/nand_bch.h                    | 6 +++---
 10 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 9c6f436d1b12..bb4b3975f7df 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -133,7 +133,7 @@ CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_M25P80=m
 CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_ECC_BCH=y
+CONFIG_MTD_NAND_ECC_SW_BCH=y
 CONFIG_MTD_NAND_OMAP2=y
 CONFIG_MTD_NAND_OMAP_BCH=y
 CONFIG_MTD_ONENAND=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 6bb506edb1f5..76e535b14fd8 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -189,7 +189,7 @@ CONFIG_MTD_M25P80=m
 CONFIG_MTD_BLOCK2MTD=y
 CONFIG_MTD_DOCG3=m
 CONFIG_MTD_NAND=m
-CONFIG_MTD_NAND_ECC_BCH=y
+CONFIG_MTD_NAND_ECC_SW_BCH=y
 CONFIG_MTD_NAND_GPIO=m
 CONFIG_MTD_NAND_DISKONCHIP=m
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
diff --git a/arch/mips/configs/db1xxx_defconfig b/arch/mips/configs/db1xxx_defconfig
index 34633b7611cb..c5a2c6f234d4 100644
--- a/arch/mips/configs/db1xxx_defconfig
+++ b/arch/mips/configs/db1xxx_defconfig
@@ -96,7 +96,7 @@ CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_SST25L=y
 CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_ECC_BCH=y
+CONFIG_MTD_NAND_ECC_SW_BCH=y
 CONFIG_MTD_NAND_AU1550=y
 CONFIG_MTD_NAND_PLATFORM=y
 CONFIG_MTD_SPI_NOR=y
diff --git a/arch/mips/configs/generic/board-ni169445.config b/arch/mips/configs/generic/board-ni169445.config
index f72223b366ca..01f6ab0d47d5 100644
--- a/arch/mips/configs/generic/board-ni169445.config
+++ b/arch/mips/configs/generic/board-ni169445.config
@@ -16,7 +16,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CMDLINE_PARTS=y
 
 CONFIG_MTD_NAND_ECC=y
-CONFIG_MTD_NAND_ECC_BCH=y
+CONFIG_MTD_NAND_ECC_SW_BCH=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_GPIO=y
 CONFIG_MTD_NAND_IDS=y
diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index aa983422aa97..7fcdaf6c279d 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -207,7 +207,7 @@ comment "Disk-On-Chip Device Drivers"
 config MTD_DOCG3
 	tristate "M-Systems Disk-On-Chip G3"
 	select BCH
-	select BCH_CONST_PARAMS if !MTD_NAND_BCH
+	select BCH_CONST_PARAMS if !CONFIG_MTD_NAND_ECC_SW_BCH
 	select BITREVERSE
 	help
 	  This provides an MTD device driver for the M-Systems DiskOnChip
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 8c38f2c116a2..849748278aed 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -22,14 +22,9 @@ menuconfig MTD_NAND
 
 if MTD_NAND
 
-config MTD_NAND_BCH
-	tristate
-	select BCH
-	depends on MTD_NAND_ECC_BCH
-	default MTD_NAND
-
-config MTD_NAND_ECC_BCH
+config MTD_NAND_ECC_SW_BCH
 	bool "Support software BCH ECC"
+	select BCH
 	default n
 	help
 	  This enables support for software BCH error correction. Binary BCH
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 57159b349054..7f4ae08f4c18 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -2,7 +2,7 @@
 
 obj-$(CONFIG_MTD_NAND)			+= nand.o
 obj-$(CONFIG_MTD_NAND_ECC)		+= nand_ecc.o
-obj-$(CONFIG_MTD_NAND_BCH)		+= nand_bch.o
+obj-$(CONFIG_MTD_NAND_ECC_SW_BCH)	+= nand_bch.o
 obj-$(CONFIG_MTD_SM_COMMON) 		+= sm_common.o
 
 obj-$(CONFIG_MTD_NAND_CAFE)		+= cafe_nand.o
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 3bd077ca58bb..eb42a8941a46 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5126,7 +5126,7 @@ static int nand_set_ecc_soft_ops(struct nand_chip *chip)
 		return 0;
 	case NAND_ECC_BCH:
 		if (!mtd_nand_has_bch()) {
-			WARN(1, "CONFIG_MTD_NAND_ECC_BCH not enabled\n");
+			WARN(1, "CONFIG_MTD_NAND_ECC_SW_BCH not enabled\n");
 			return -EINVAL;
 		}
 		ecc->calculate = nand_bch_calculate_ecc;
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 68e8b9f7f372..eaf14813a3ab 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -1728,9 +1728,9 @@ static bool omap2_nand_ecc_check(struct omap_nand_info *info)
 		break;
 	}
 
-	if (ecc_needs_bch && !IS_ENABLED(CONFIG_MTD_NAND_ECC_BCH)) {
+	if (ecc_needs_bch && !IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_BCH)) {
 		dev_err(&info->pdev->dev,
-			"CONFIG_MTD_NAND_ECC_BCH not enabled\n");
+			"CONFIG_MTD_NAND_ECC_SW_BCH not enabled\n");
 		return false;
 	}
 	if (ecc_needs_omap_bch && !IS_ENABLED(CONFIG_MTD_NAND_OMAP_BCH)) {
diff --git a/include/linux/mtd/nand_bch.h b/include/linux/mtd/nand_bch.h
index b8106651f807..06ce2b655c13 100644
--- a/include/linux/mtd/nand_bch.h
+++ b/include/linux/mtd/nand_bch.h
@@ -15,7 +15,7 @@ struct mtd_info;
 struct nand_chip;
 struct nand_bch_control;
 
-#if defined(CONFIG_MTD_NAND_ECC_BCH)
+#if defined(CONFIG_MTD_NAND_ECC_SW_BCH)
 
 static inline int mtd_nand_has_bch(void) { return 1; }
 
@@ -39,7 +39,7 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd);
  */
 void nand_bch_free(struct nand_bch_control *nbc);
 
-#else /* !CONFIG_MTD_NAND_ECC_BCH */
+#else /* !CONFIG_MTD_NAND_ECC_SW_BCH */
 
 static inline int mtd_nand_has_bch(void) { return 0; }
 
@@ -64,6 +64,6 @@ static inline struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 
 static inline void nand_bch_free(struct nand_bch_control *nbc) {}
 
-#endif /* CONFIG_MTD_NAND_ECC_BCH */
+#endif /* CONFIG_MTD_NAND_ECC_SW_BCH */
 
 #endif /* __MTD_NAND_BCH_H__ */
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
