Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAB3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:29:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2307120880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O+KFBvEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2307120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kVdWqsw4OVtl1ZcbulydmCSLpRxL/zO+7qVm0KHdLaI=; b=O+KFBvEOj0k0eE
	stoPICf8G5O9KjD4iRBAH0phMofBspbg1PgEeC8YUVdjIaZXUJbrbi7Xv2AdDU93Hq76X4VCZddcb
	TJRYVldm39FQIpfpwPJzU8dden3pr2dM6DdAaT+Almr+zXkVFw5WOyudRJvrVZFmW23e2EJ9+Rrg1
	Qy77r6OSXQnd61AcqvxbFnPmmJgbxtEyx2+trVsl7l7bQ4mEpoRP6DXJl9ckdtNX7adEEAOofmGDz
	ZWBHiIIhxrnSq7hh+AWnh1Te20+edoLLqjMN1Vpf33peJH9zAs8k0wEHeni3J23l5TQPuaP4JVkbK
	jkgWTCbhJv0rnOGevItg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwkfB-0005iI-Hf; Thu, 21 Feb 2019 09:29:05 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwke1-00048h-Ed; Thu, 21 Feb 2019 09:28:01 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id CC8C240015;
 Thu, 21 Feb 2019 09:27:48 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [PATCH 5/6] mtd: rawnand: Clarify Kconfig entry MTD_NAND
Date: Thu, 21 Feb 2019 10:27:32 +0100
Message-Id: <20190221092734.21634-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221092734.21634-1-miquel.raynal@bootlin.com>
References: <20190221092734.21634-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_012753_958877_D2FA4785 
X-CRM114-Status: GOOD (  10.73  )
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

MTD_NAND is large and encloses much more than what the symbol is
actually used for: raw NAND. Clarify the symbol by naming it
MTD_RAW_NAND instead.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm/configs/at91_dt_defconfig              | 2 +-
 arch/arm/configs/clps711x_defconfig             | 2 +-
 arch/arm/configs/cm_x2xx_defconfig              | 2 +-
 arch/arm/configs/cm_x300_defconfig              | 2 +-
 arch/arm/configs/colibri_pxa270_defconfig       | 2 +-
 arch/arm/configs/corgi_defconfig                | 2 +-
 arch/arm/configs/davinci_all_defconfig          | 2 +-
 arch/arm/configs/em_x270_defconfig              | 2 +-
 arch/arm/configs/ep93xx_defconfig               | 2 +-
 arch/arm/configs/eseries_pxa_defconfig          | 2 +-
 arch/arm/configs/imx_v4_v5_defconfig            | 2 +-
 arch/arm/configs/imx_v6_v7_defconfig            | 2 +-
 arch/arm/configs/ixp4xx_defconfig               | 2 +-
 arch/arm/configs/keystone_defconfig             | 2 +-
 arch/arm/configs/lpc32xx_defconfig              | 2 +-
 arch/arm/configs/macronix_zynq_defconfig        | 2 +-
 arch/arm/configs/mini2440_defconfig             | 2 +-
 arch/arm/configs/mmp2_defconfig                 | 2 +-
 arch/arm/configs/multi_v4t_defconfig            | 2 +-
 arch/arm/configs/multi_v5_defconfig             | 2 +-
 arch/arm/configs/multi_v7_defconfig             | 2 +-
 arch/arm/configs/mv78xx0_defconfig              | 2 +-
 arch/arm/configs/mvebu_v5_defconfig             | 2 +-
 arch/arm/configs/mvebu_v7_defconfig             | 2 +-
 arch/arm/configs/mxs_defconfig                  | 2 +-
 arch/arm/configs/nhk8815_defconfig              | 2 +-
 arch/arm/configs/omap1_defconfig                | 2 +-
 arch/arm/configs/omap2plus_defconfig            | 2 +-
 arch/arm/configs/orion5x_defconfig              | 2 +-
 arch/arm/configs/oxnas_v6_defconfig             | 2 +-
 arch/arm/configs/pxa3xx_defconfig               | 2 +-
 arch/arm/configs/pxa_defconfig                  | 2 +-
 arch/arm/configs/qcom_defconfig                 | 2 +-
 arch/arm/configs/raumfeld_defconfig             | 2 +-
 arch/arm/configs/s3c2410_defconfig              | 2 +-
 arch/arm/configs/s3c6400_defconfig              | 2 +-
 arch/arm/configs/sama5_defconfig                | 2 +-
 arch/arm/configs/socfpga_defconfig              | 2 +-
 arch/arm/configs/spear13xx_defconfig            | 2 +-
 arch/arm/configs/spear3xx_defconfig             | 2 +-
 arch/arm/configs/spear6xx_defconfig             | 2 +-
 arch/arm/configs/spitz_defconfig                | 2 +-
 arch/arm/configs/tango4_defconfig               | 2 +-
 arch/arm/configs/trizeps4_defconfig             | 2 +-
 arch/arm/configs/u300_defconfig                 | 2 +-
 arch/arm64/configs/defconfig                    | 2 +-
 arch/mips/configs/bcm47xx_defconfig             | 2 +-
 arch/mips/configs/ci20_defconfig                | 2 +-
 arch/mips/configs/db1xxx_defconfig              | 2 +-
 arch/mips/configs/generic/board-ni169445.config | 2 +-
 arch/mips/configs/generic/board-ocelot.config   | 2 +-
 arch/mips/configs/loongson1b_defconfig          | 2 +-
 arch/mips/configs/loongson1c_defconfig          | 2 +-
 arch/mips/configs/qi_lb60_defconfig             | 2 +-
 arch/mips/configs/rb532_defconfig               | 2 +-
 arch/mips/configs/rbtx49xx_defconfig            | 2 +-
 arch/mips/configs/xway_defconfig                | 2 +-
 arch/powerpc/configs/40x/kilauea_defconfig      | 2 +-
 arch/powerpc/configs/40x/obs600_defconfig       | 2 +-
 arch/powerpc/configs/44x/canyonlands_defconfig  | 2 +-
 arch/powerpc/configs/44x/eiger_defconfig        | 2 +-
 arch/powerpc/configs/44x/sequoia_defconfig      | 2 +-
 arch/powerpc/configs/44x/warp_defconfig         | 2 +-
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig | 2 +-
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig | 2 +-
 arch/powerpc/configs/85xx-hw.config             | 2 +-
 arch/powerpc/configs/85xx/ge_imp3a_defconfig    | 2 +-
 arch/powerpc/configs/85xx/socrates_defconfig    | 2 +-
 arch/powerpc/configs/85xx/tqm8548_defconfig     | 2 +-
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig | 2 +-
 arch/powerpc/configs/86xx-hw.config             | 2 +-
 arch/powerpc/configs/mpc512x_defconfig          | 2 +-
 arch/powerpc/configs/mpc83xx_defconfig          | 2 +-
 arch/powerpc/configs/pasemi_defconfig           | 2 +-
 arch/powerpc/configs/ppc44x_defconfig           | 2 +-
 arch/sh/configs/ap325rxa_defconfig              | 2 +-
 arch/sh/configs/ecovec24_defconfig              | 2 +-
 arch/sh/configs/migor_defconfig                 | 2 +-
 arch/sh/configs/sdk7786_defconfig               | 2 +-
 arch/sh/configs/titan_defconfig                 | 2 +-
 drivers/mtd/nand/raw/Kconfig                    | 6 +++---
 drivers/mtd/nand/raw/Makefile                   | 2 +-
 drivers/mtd/tests/mtd_nandecctest.c             | 2 +-
 83 files changed, 85 insertions(+), 85 deletions(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index e4b1be66b3f5..50ef3eb0ab64 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -56,7 +56,7 @@ CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_DATAFLASH=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_GLUEBI=y
diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
index fc105c9178cc..7968d20673b9 100644
--- a/arch/arm/configs/clps711x_defconfig
+++ b/arch/arm/configs/clps711x_defconfig
@@ -36,7 +36,7 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PLATRAM=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_GPIO=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_CADENCE is not set
diff --git a/arch/arm/configs/cm_x2xx_defconfig b/arch/arm/configs/cm_x2xx_defconfig
index fb45b4983d3c..5344434df652 100644
--- a/arch/arm/configs/cm_x2xx_defconfig
+++ b/arch/arm/configs/cm_x2xx_defconfig
@@ -58,7 +58,7 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PXA2XX=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_GPIO=m
 CONFIG_MTD_NAND_CM_X270=y
 CONFIG_MTD_NAND_PLATFORM=y
diff --git a/arch/arm/configs/cm_x300_defconfig b/arch/arm/configs/cm_x300_defconfig
index 5e349c625b71..3707a014cbc4 100644
--- a/arch/arm/configs/cm_x300_defconfig
+++ b/arch/arm/configs/cm_x300_defconfig
@@ -48,7 +48,7 @@ CONFIG_LIB80211=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_MARVELL=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
diff --git a/arch/arm/configs/colibri_pxa270_defconfig b/arch/arm/configs/colibri_pxa270_defconfig
index 8995695fc118..8d484e4d51cc 100644
--- a/arch/arm/configs/colibri_pxa270_defconfig
+++ b/arch/arm/configs/colibri_pxa270_defconfig
@@ -64,7 +64,7 @@ CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PXA2XX=y
 CONFIG_MTD_BLOCK2MTD=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DISKONCHIP=y
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0x4000000
diff --git a/arch/arm/configs/corgi_defconfig b/arch/arm/configs/corgi_defconfig
index 09e1672777c9..d99725984947 100644
--- a/arch/arm/configs/corgi_defconfig
+++ b/arch/arm/configs/corgi_defconfig
@@ -87,7 +87,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_ROM=y
 CONFIG_MTD_COMPLEX_MAPPINGS=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_SHARPSL=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 207962a656a2..4a8cad4d3707 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -74,7 +74,7 @@ CONFIG_MTD_CFI_INTELEXT=m
 CONFIG_MTD_CFI_AMDSTD=m
 CONFIG_MTD_PHYSMAP=m
 CONFIG_MTD_M25P80=m
-CONFIG_MTD_NAND=m
+CONFIG_MTD_RAW_NAND=m
 CONFIG_MTD_NAND_DAVINCI=m
 CONFIG_MTD_SPI_NOR=m
 CONFIG_MTD_UBI=m
diff --git a/arch/arm/configs/em_x270_defconfig b/arch/arm/configs/em_x270_defconfig
index 30a67523f860..61228a25ba8d 100644
--- a/arch/arm/configs/em_x270_defconfig
+++ b/arch/arm/configs/em_x270_defconfig
@@ -54,7 +54,7 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PXA2XX=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_PLATFORM=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index 78cd73d1c795..14889a785f07 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -63,7 +63,7 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_ROM=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_BLK_DEV_NBD=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_SCSI=y
diff --git a/arch/arm/configs/eseries_pxa_defconfig b/arch/arm/configs/eseries_pxa_defconfig
index cd27d651463c..03b0220a59b1 100644
--- a/arch/arm/configs/eseries_pxa_defconfig
+++ b/arch/arm/configs/eseries_pxa_defconfig
@@ -43,7 +43,7 @@ CONFIG_MAC80211_RC_PID=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_STANDALONE is not set
 CONFIG_MTD=m
-CONFIG_MTD_NAND=m
+CONFIG_MTD_RAW_NAND=m
 CONFIG_MTD_NAND_TMIO=m
 CONFIG_BLK_DEV_LOOP=m
 # CONFIG_SCSI_PROC_FS is not set
diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 8661dd9b064a..ffdcfc3edc25 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -61,7 +61,7 @@ CONFIG_MTD_CFI_GEOMETRY=y
 # CONFIG_MTD_CFI_I2 is not set
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_MXC=y
 CONFIG_MTD_UBI=y
 CONFIG_EEPROM_AT24=y
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 5586a5074a96..07b796c2f0ee 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -110,7 +110,7 @@ CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_DATAFLASH=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_SST25L=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_MTD_NAND_VF610_NFC=y
 CONFIG_MTD_NAND_MXC=y
diff --git a/arch/arm/configs/ixp4xx_defconfig b/arch/arm/configs/ixp4xx_defconfig
index 8c3c99cd6de9..39ebcce3bc2f 100644
--- a/arch/arm/configs/ixp4xx_defconfig
+++ b/arch/arm/configs/ixp4xx_defconfig
@@ -112,7 +112,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_IXP4XX=y
-CONFIG_MTD_NAND=m
+CONFIG_MTD_RAW_NAND=m
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 3ded35a07f45..72fee57aad2f 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -124,7 +124,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_PLATRAM=y
 CONFIG_MTD_M25P80=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 0b54b4024e51..b4b7aac97051 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -47,7 +47,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_SLC_LPC32XX=y
 CONFIG_MTD_NAND_MLC_LPC32XX=y
 CONFIG_MTD_UBI=y
diff --git a/arch/arm/configs/macronix_zynq_defconfig b/arch/arm/configs/macronix_zynq_defconfig
index 23e37cd66fe2..1276ae284575 100644
--- a/arch/arm/configs/macronix_zynq_defconfig
+++ b/arch/arm/configs/macronix_zynq_defconfig
@@ -76,7 +76,7 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_M25P80=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2440_defconfig
index 88ea02e7ba19..820213930664 100644
--- a/arch/arm/configs/mini2440_defconfig
+++ b/arch/arm/configs/mini2440_defconfig
@@ -92,7 +92,7 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_RAM=y
 CONFIG_MTD_ROM=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_S3C2410=y
 CONFIG_MTD_NAND_PLATFORM=y
 CONFIG_MTD_LPDDR=y
diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
index 1eeee7f11d91..94deb0ed0541 100644
--- a/arch/arm/configs/mmp2_defconfig
+++ b/arch/arm/configs/mmp2_defconfig
@@ -28,7 +28,7 @@ CONFIG_IP_PNP=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_GENERIC=y
 # CONFIG_BLK_DEV is not set
diff --git a/arch/arm/configs/multi_v4t_defconfig b/arch/arm/configs/multi_v4t_defconfig
index 9a6390c172d6..14f3a4a65d01 100644
--- a/arch/arm/configs/multi_v4t_defconfig
+++ b/arch/arm/configs/multi_v4t_defconfig
@@ -39,7 +39,7 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PLATRAM=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_GPIO=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 318b76fa26d1..63b5a8824f0f 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -87,7 +87,7 @@ CONFIG_MTD_CFI_GEOMETRY=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
 CONFIG_MTD_NAND_ORION=y
 CONFIG_MTD_SPI_NOR=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5bee34a7ff2e..3589adc76628 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -181,7 +181,7 @@ CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_NAND_OMAP2=y
 CONFIG_MTD_NAND_OMAP_BCH=y
diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index 0448bd8075ac..e9567513f068 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -47,7 +47,7 @@ CONFIG_MTD_CFI_GEOMETRY=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ORION=y
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_SCSI_PROC_FS is not set
diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index 4b598da0d086..0e5577a31851 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -77,7 +77,7 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_M25P80=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ORION=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index 55140219ab11..48f7b4277b8d 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -52,7 +52,7 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_M25P80=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_MARVELL=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 38480596c449..ed570a0d1f2a 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -50,7 +50,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_DATAFLASH=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_SST25L=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index 413c65b4c7e6..6f33138d66ca 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -50,7 +50,7 @@ CONFIG_MTD_TESTS=m
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_FSMC=y
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_VERIFY_WRITE=y
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index cfc00b0961ec..40fdf890a292 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -90,7 +90,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=2
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index bb4b3975f7df..7f7faf5f5d4a 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -132,7 +132,7 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_M25P80=m
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ECC_SW_BCH=y
 CONFIG_MTD_NAND_OMAP2=y
 CONFIG_MTD_NAND_OMAP_BCH=y
diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index bf9046331f6e..077e0fde1ff9 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -70,7 +70,7 @@ CONFIG_MTD_CFI_GEOMETRY=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_PLATFORM=y
 CONFIG_MTD_NAND_ORION=y
 CONFIG_BLK_DEV_LOOP=y
diff --git a/arch/arm/configs/oxnas_v6_defconfig b/arch/arm/configs/oxnas_v6_defconfig
index f6ba32c9d173..cae0db6b4eaf 100644
--- a/arch/arm/configs/oxnas_v6_defconfig
+++ b/arch/arm/configs/oxnas_v6_defconfig
@@ -50,7 +50,7 @@ CONFIG_SIMPLE_PM_BUS=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_OXNAS=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
diff --git a/arch/arm/configs/pxa3xx_defconfig b/arch/arm/configs/pxa3xx_defconfig
index 3e0de035ab77..7681eea60127 100644
--- a/arch/arm/configs/pxa3xx_defconfig
+++ b/arch/arm/configs/pxa3xx_defconfig
@@ -31,7 +31,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_MARVELL=y
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_VERIFY_WRITE=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 76e535b14fd8..4913be26d898 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -188,7 +188,7 @@ CONFIG_MTD_PXA2XX=m
 CONFIG_MTD_M25P80=m
 CONFIG_MTD_BLOCK2MTD=y
 CONFIG_MTD_DOCG3=m
-CONFIG_MTD_NAND=m
+CONFIG_MTD_RAW_NAND=m
 CONFIG_MTD_NAND_ECC_SW_BCH=y
 CONFIG_MTD_NAND_GPIO=m
 CONFIG_MTD_NAND_DISKONCHIP=m
diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index bd6440f23493..4c50b5337cf6 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -57,7 +57,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_QCOM=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_LOOP=y
diff --git a/arch/arm/configs/raumfeld_defconfig b/arch/arm/configs/raumfeld_defconfig
index 2dd56e9a484e..e68094330d6d 100644
--- a/arch/arm/configs/raumfeld_defconfig
+++ b/arch/arm/configs/raumfeld_defconfig
@@ -32,7 +32,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_NFTL=y
 CONFIG_NFTL_RW=y
 CONFIG_MTD_BLOCK2MTD=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_MARVELL=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index 2afb359f3168..39c648594d93 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -192,7 +192,7 @@ CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_ROM=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_S3C2410=y
 CONFIG_PARPORT=y
 CONFIG_PARPORT_PC=m
diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
index 507d7ad7523a..6e2656567da6 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -23,7 +23,7 @@ CONFIG_CMDLINE="console=ttySAC0,115200 root=/dev/ram init=/linuxrc initrd=0x5100
 CONFIG_VFP=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_S3C2410=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index b0026f73083d..515cb37eeab6 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -66,7 +66,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_M25P80=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 371fca4e1ab7..fe316675f6b7 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -54,7 +54,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_SPI_NOR=y
 # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index 7b36eeb928bb..8ee3679ca8b2 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -32,7 +32,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
 CONFIG_MTD_OF_PARTS=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_FSMC=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index 2c5e8df33191..188449db6178 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -17,7 +17,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
 CONFIG_MTD_OF_PARTS=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_FSMC=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
index 124c244d8df1..5b410f0a365b 100644
--- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -14,7 +14,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
 CONFIG_MTD_OF_PARTS=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_FSMC=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index 9ea82c118661..f6d2f674517c 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -84,7 +84,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_ROM=y
 CONFIG_MTD_COMPLEX_MAPPINGS=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_SHARPSL=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_SD=y
diff --git a/arch/arm/configs/tango4_defconfig b/arch/arm/configs/tango4_defconfig
index 68725d4eae45..68eb16e583ac 100644
--- a/arch/arm/configs/tango4_defconfig
+++ b/arch/arm/configs/tango4_defconfig
@@ -39,7 +39,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_TESTS=m
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_TANGO=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_SCSI=y
diff --git a/arch/arm/configs/trizeps4_defconfig b/arch/arm/configs/trizeps4_defconfig
index 2b5a224d2da1..ecad22501b48 100644
--- a/arch/arm/configs/trizeps4_defconfig
+++ b/arch/arm/configs/trizeps4_defconfig
@@ -76,7 +76,7 @@ CONFIG_MTD_DOC2001PLUS=y
 CONFIG_MTD_DOCPROBE_ADVANCED=y
 CONFIG_MTD_DOCPROBE_ADDRESS=0x4000000
 CONFIG_MTD_DOCPROBE_HIGH=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DISKONCHIP=y
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
 CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0x4000000
diff --git a/arch/arm/configs/u300_defconfig b/arch/arm/configs/u300_defconfig
index 36d77406e31b..cfd3622e2c8a 100644
--- a/arch/arm/configs/u300_defconfig
+++ b/arch/arm/configs/u300_defconfig
@@ -27,7 +27,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_FSMC=y
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3ef443cfbab6..22e30f66f986 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -203,7 +203,7 @@ CONFIG_SIMPLE_PM_BUS=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_NAND_MARVELL=y
 CONFIG_MTD_NAND_QCOM=y
diff --git a/arch/mips/configs/bcm47xx_defconfig b/arch/mips/configs/bcm47xx_defconfig
index 249f5285e343..91ce75edbfb4 100644
--- a/arch/mips/configs/bcm47xx_defconfig
+++ b/arch/mips/configs/bcm47xx_defconfig
@@ -41,7 +41,7 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_BCM47XXSFLASH=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_BCM47XXNFLASH=y
 CONFIG_NETDEVICES=y
 CONFIG_B44=y
diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index 412800d5d7e0..50bebce28500 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -51,7 +51,7 @@ CONFIG_DEVTMPFS=y
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_MTD=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_JZ4780=y
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_FASTMAP=y
diff --git a/arch/mips/configs/db1xxx_defconfig b/arch/mips/configs/db1xxx_defconfig
index c5a2c6f234d4..bc9b6ae046b2 100644
--- a/arch/mips/configs/db1xxx_defconfig
+++ b/arch/mips/configs/db1xxx_defconfig
@@ -95,7 +95,7 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_SST25L=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ECC_SW_BCH=y
 CONFIG_MTD_NAND_AU1550=y
 CONFIG_MTD_NAND_PLATFORM=y
diff --git a/arch/mips/configs/generic/board-ni169445.config b/arch/mips/configs/generic/board-ni169445.config
index e68da2e9dc7c..1ed0d3e8715e 100644
--- a/arch/mips/configs/generic/board-ni169445.config
+++ b/arch/mips/configs/generic/board-ni169445.config
@@ -17,7 +17,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
 
 CONFIG_MTD_NAND_ECC_SW_HAMMING=y
 CONFIG_MTD_NAND_ECC_SW_BCH=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_GPIO=y
 CONFIG_MTD_NAND_IDS=y
 
diff --git a/arch/mips/configs/generic/board-ocelot.config b/arch/mips/configs/generic/board-ocelot.config
index f607888d2483..2621630f9850 100644
--- a/arch/mips/configs/generic/board-ocelot.config
+++ b/arch/mips/configs/generic/board-ocelot.config
@@ -6,7 +6,7 @@ CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_PLATFORM=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
diff --git a/arch/mips/configs/loongson1b_defconfig b/arch/mips/configs/loongson1b_defconfig
index b064d68a5424..1628e6fcc405 100644
--- a/arch/mips/configs/loongson1b_defconfig
+++ b/arch/mips/configs/loongson1b_defconfig
@@ -42,7 +42,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_SCSI=m
diff --git a/arch/mips/configs/loongson1c_defconfig b/arch/mips/configs/loongson1c_defconfig
index 5d76559b56cd..7aa5527e50b1 100644
--- a/arch/mips/configs/loongson1c_defconfig
+++ b/arch/mips/configs/loongson1c_defconfig
@@ -43,7 +43,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_SCSI=m
diff --git a/arch/mips/configs/qi_lb60_defconfig b/arch/mips/configs/qi_lb60_defconfig
index 7671fe6a8042..1a0677d04982 100644
--- a/arch/mips/configs/qi_lb60_defconfig
+++ b/arch/mips/configs/qi_lb60_defconfig
@@ -44,7 +44,7 @@ CONFIG_TCP_CONG_WESTWOOD=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_JZ4740=y
 CONFIG_MTD_UBI=y
 CONFIG_NETDEVICES=y
diff --git a/arch/mips/configs/rb532_defconfig b/arch/mips/configs/rb532_defconfig
index 7befe05fd813..4cbcf015a7ed 100644
--- a/arch/mips/configs/rb532_defconfig
+++ b/arch/mips/configs/rb532_defconfig
@@ -110,7 +110,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_BLOCK2MTD=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_PLATFORM=y
 CONFIG_ATA=y
 # CONFIG_ATA_VERBOSE_ERROR is not set
diff --git a/arch/mips/configs/rbtx49xx_defconfig b/arch/mips/configs/rbtx49xx_defconfig
index 50a2c9ad583f..96114ca59016 100644
--- a/arch/mips/configs/rbtx49xx_defconfig
+++ b/arch/mips/configs/rbtx49xx_defconfig
@@ -40,7 +40,7 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_RBTX4939=y
-CONFIG_MTD_NAND=m
+CONFIG_MTD_RAW_NAND=m
 CONFIG_MTD_NAND_TXX9NDFMC=m
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/mips/configs/xway_defconfig b/arch/mips/configs/xway_defconfig
index c3cac29e8414..d943254a9ac9 100644
--- a/arch/mips/configs/xway_defconfig
+++ b/arch/mips/configs/xway_defconfig
@@ -82,7 +82,7 @@ CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_LANTIQ=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_XWAY=y
 CONFIG_EEPROM_93CX6=m
 CONFIG_SCSI=y
diff --git a/arch/powerpc/configs/40x/kilauea_defconfig b/arch/powerpc/configs/40x/kilauea_defconfig
index b5cc7426c21f..3da091f651d6 100644
--- a/arch/powerpc/configs/40x/kilauea_defconfig
+++ b/arch/powerpc/configs/40x/kilauea_defconfig
@@ -33,7 +33,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_NDFC=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=35000
diff --git a/arch/powerpc/configs/40x/obs600_defconfig b/arch/powerpc/configs/40x/obs600_defconfig
index aac06d2ad01a..38d3d7769a2f 100644
--- a/arch/powerpc/configs/40x/obs600_defconfig
+++ b/arch/powerpc/configs/40x/obs600_defconfig
@@ -33,7 +33,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_NDFC=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=35000
diff --git a/arch/powerpc/configs/44x/canyonlands_defconfig b/arch/powerpc/configs/44x/canyonlands_defconfig
index c8e6f048a122..d427cee027a6 100644
--- a/arch/powerpc/configs/44x/canyonlands_defconfig
+++ b/arch/powerpc/configs/44x/canyonlands_defconfig
@@ -32,7 +32,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_NDFC=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=35000
diff --git a/arch/powerpc/configs/44x/eiger_defconfig b/arch/powerpc/configs/44x/eiger_defconfig
index f6dc23fef683..f593258806ad 100644
--- a/arch/powerpc/configs/44x/eiger_defconfig
+++ b/arch/powerpc/configs/44x/eiger_defconfig
@@ -33,7 +33,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_NDFC=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=35000
diff --git a/arch/powerpc/configs/44x/sequoia_defconfig b/arch/powerpc/configs/44x/sequoia_defconfig
index 1e04122912f3..f34fee9464e5 100644
--- a/arch/powerpc/configs/44x/sequoia_defconfig
+++ b/arch/powerpc/configs/44x/sequoia_defconfig
@@ -33,7 +33,7 @@ CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_NDFC=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=35000
diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index 6c02f53271cd..6ae88d4879bf 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -34,7 +34,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_NDFC=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
index 1f69f4edf074..9dffb2e7f735 100644
--- a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
@@ -31,7 +31,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
index 797fc3ffddee..a42232732c6d 100644
--- a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
@@ -31,7 +31,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=32768
diff --git a/arch/powerpc/configs/85xx-hw.config b/arch/powerpc/configs/85xx-hw.config
index c03d0fb16665..9575a38c9155 100644
--- a/arch/powerpc/configs/85xx-hw.config
+++ b/arch/powerpc/configs/85xx-hw.config
@@ -71,7 +71,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_MTD_NAND_FSL_IFC=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PLATRAM=y
diff --git a/arch/powerpc/configs/85xx/ge_imp3a_defconfig b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
index dd98f43b2fb8..d70b60314dad 100644
--- a/arch/powerpc/configs/85xx/ge_imp3a_defconfig
+++ b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
@@ -73,7 +73,7 @@ CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_CRYPTOLOOP=m
diff --git a/arch/powerpc/configs/85xx/socrates_defconfig b/arch/powerpc/configs/85xx/socrates_defconfig
index 6106fadbbd8b..7037a6d8018c 100644
--- a/arch/powerpc/configs/85xx/socrates_defconfig
+++ b/arch/powerpc/configs/85xx/socrates_defconfig
@@ -31,7 +31,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_SOCRATES=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/powerpc/configs/85xx/tqm8548_defconfig b/arch/powerpc/configs/85xx/tqm8548_defconfig
index 464ce192bc14..1c63cbdc3211 100644
--- a/arch/powerpc/configs/85xx/tqm8548_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8548_defconfig
@@ -36,7 +36,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_FSL_UPM=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
index 6531139a8a8d..78f5beb2928c 100644
--- a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
+++ b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
@@ -65,7 +65,7 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_MTD_NAND_FSL_UPM=y
 CONFIG_BLK_DEV_LOOP=y
diff --git a/arch/powerpc/configs/86xx-hw.config b/arch/powerpc/configs/86xx-hw.config
index d3dd6b8865c0..151164cf8cb3 100644
--- a/arch/powerpc/configs/86xx-hw.config
+++ b/arch/powerpc/configs/86xx-hw.config
@@ -47,7 +47,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_NAND_FSL_ELBC=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_TULIP=y
diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index c2b1c4404683..5f81aa8723b7 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -46,7 +46,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_ROM=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_MPC5121_NFC=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index d1b82035d35f..005d00020fb9 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -46,7 +46,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index 6daa56f8895c..c0423b2cf7c0 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -51,7 +51,7 @@ CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_SLRAM=y
 CONFIG_MTD_PHRAM=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_PASEMI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/ppc44x_defconfig
index 66dd6bf45cde..db48039e0b11 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -44,7 +44,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND=m
+CONFIG_MTD_RAW_NAND=m
 CONFIG_MTD_NAND_NDFC=m
 CONFIG_MTD_UBI=m
 CONFIG_MTD_UBI_GLUEBI=m
diff --git a/arch/sh/configs/ap325rxa_defconfig b/arch/sh/configs/ap325rxa_defconfig
index 72b72e50a92e..0ef3f1f9de5c 100644
--- a/arch/sh/configs/ap325rxa_defconfig
+++ b/arch/sh/configs/ap325rxa_defconfig
@@ -35,7 +35,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_SH_FLCTL=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index 3568310c2c2f..ba67e3752938 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -38,7 +38,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=4
diff --git a/arch/sh/configs/migor_defconfig b/arch/sh/configs/migor_defconfig
index e04f21be0756..121a75d65fb4 100644
--- a/arch/sh/configs/migor_defconfig
+++ b/arch/sh/configs/migor_defconfig
@@ -34,7 +34,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_PLATFORM=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_SCSI=y
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index e9ee0c878ead..7d90421ac0f4 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -108,7 +108,7 @@ CONFIG_MTD_ROM=m
 CONFIG_MTD_ABSENT=m
 CONFIG_MTD_PLATRAM=y
 CONFIG_MTD_PHRAM=y
-CONFIG_MTD_NAND=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_PLATFORM=y
 CONFIG_MTD_NAND_SH_FLCTL=m
 CONFIG_MTD_UBI=y
diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
index ceb48e9b70f4..822fa9e96f74 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -155,7 +155,7 @@ CONFIG_INFTL=m
 CONFIG_RFD_FTL=m
 CONFIG_MTD_CFI=m
 CONFIG_MTD_JEDECPROBE=m
-CONFIG_MTD_NAND=m
+CONFIG_MTD_RAW_NAND=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_RAM=y
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index aa54f804ee40..510a6b32820d 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -9,7 +9,7 @@ config MTD_NAND_ECC_SW_HAMMING_SMC
 	  Software ECC according to the Smart Media Specification.
 	  The original Linux implementation had byte 0 and 1 swapped.
 
-menuconfig MTD_NAND
+menuconfig MTD_RAW_NAND
 	tristate "Raw/Parallel NAND Device Support"
 	depends on MTD
 	select MTD_NAND_ECC_SW_HAMMING
@@ -18,7 +18,7 @@ menuconfig MTD_NAND
 	  NAND flash devices. For further information see
 	  <http://www.linux-mtd.infradead.org/doc/nand.html>.
 
-if MTD_NAND
+if MTD_RAW_NAND
 
 config MTD_NAND_ECC_SW_BCH
 	bool "Support software BCH ECC"
@@ -539,4 +539,4 @@ config MTD_NAND_DISKONCHIP_BBTWRITE
 	  load time (assuming you build diskonchip as a module) with the module
 	  parameter "inftl_bbt_write=1".
 
-endif # MTD_NAND
+endif # MTD_RAW_NAND
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 60ec994808c5..ffe95b157131 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_MTD_NAND)			+= nand.o
+obj-$(CONFIG_MTD_RAW_NAND)		+= nand.o
 obj-$(CONFIG_MTD_NAND_ECC_SW_HAMMING)	+= nand_ecc.o
 obj-$(CONFIG_MTD_NAND_ECC_SW_BCH)	+= nand_bch.o
 obj-$(CONFIG_MTD_SM_COMMON) 		+= sm_common.o
diff --git a/drivers/mtd/tests/mtd_nandecctest.c b/drivers/mtd/tests/mtd_nandecctest.c
index 0c0091fb3708..73b06304c975 100644
--- a/drivers/mtd/tests/mtd_nandecctest.c
+++ b/drivers/mtd/tests/mtd_nandecctest.c
@@ -21,7 +21,7 @@
  * or detected.
  */
 
-#if IS_ENABLED(CONFIG_MTD_NAND)
+#if IS_ENABLED(CONFIG_MTD_RAW_NAND)
 
 struct nand_ecc_test {
 	const char *name;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
