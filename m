Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA8BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:21:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96CA20873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sH+QUXvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96CA20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mT5PiWwJnZSbzdyfwourXV3IibllhN2zPaIz+4VUmRw=; b=sH+QUXvI88eYZK
	rNuhZ/rxwG+cdYT4BUDedYqmeC96B0XsEV8wzPR6N2N5cRGJ+k6KDU/SFRmubYm/H7kEDBS8l5TGb
	4241AM3vbnQto/xZcUu48dZYcPd2slt5B7j3e5EorLmJ4gMVxV813GSDmQaKR3sOV5LPOSAzcFj25
	ChA6xSwUhUhOlxiVSfR4HpZYAw8Ml6x9sx8pBKa3GaHjIZICOJEPhC55MGalnTfBPLFgNEZEFBZRh
	9slOAVIDJ+zb9z0xnnQI8Ox/hXDLMWp7eaYyv168pNTzTkYK2MM0RPVTi2Of5S45cP1YOX2WPzbCk
	fJC5nxaMdODOVjoJVlhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjapX-0007Ht-Us; Wed, 16 Jan 2019 02:21:23 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjagw-0003Aq-Sr; Wed, 16 Jan 2019 02:12:32 +0000
X-UUID: a0989456972d44d793f29c747907e80c-20190115
X-UUID: a0989456972d44d793f29c747907e80c-20190115
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 2071105648; Tue, 15 Jan 2019 18:12:16 -0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 15 Jan 2019 18:12:15 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Jan 2019 10:12:07 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 16 Jan 2019 10:12:07 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Marek Vasut <marek.vasut@gmail.com>, Brian Norris
 <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 3/3] mtd: spi-nor: mtk-quadspi: rename config to a common
 one
Date: Wed, 16 Jan 2019 10:12:05 +0800
Message-ID: <761c9a0a482795dbc48949e982ab46987b737e08.1547538621.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <74d710ed89fd505a49bce53b51f6cb489e313dbb.1547538621.git.ryder.lee@mediatek.com>
References: <74d710ed89fd505a49bce53b51f6cb489e313dbb.1547538621.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_181230_953956_07BE7251 
X-CRM114-Status: GOOD (  12.96  )
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
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The quadspi is a generic communication interface which could be shared
with other MediaTek SoCs. Hence rename it to a common one.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
Changes since v2:
-rebase to v5.0-rc1.
-sort the config in an alphabetical order.

Changes since v1: none. 
---
 drivers/mtd/spi-nor/Kconfig  | 16 ++++++++--------
 drivers/mtd/spi-nor/Makefile |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index 44fe801..414e887 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -7,14 +7,6 @@ menuconfig MTD_SPI_NOR
 
 if MTD_SPI_NOR
 
-config MTD_MT81xx_NOR
-	tristate "Mediatek MT81xx SPI NOR flash controller"
-	depends on HAS_IOMEM
-	help
-	  This enables access to SPI NOR flash, using MT81xx SPI NOR flash
-	  controller. This controller does not support generic SPI BUS, it only
-	  supports SPI NOR Flash.
-
 config MTD_SPI_NOR_USE_4K_SECTORS
 	bool "Use small 4096 B erase sectors"
 	default y
@@ -66,6 +58,14 @@ config SPI_HISI_SFC
 	help
 	  This enables support for hisilicon SPI-NOR flash controller.
 
+config SPI_MTK_QUADSPI
+	tristate "MediaTek Quad SPI controller"
+	depends on HAS_IOMEM
+	help
+	  This enables support for the Quad SPI controller in master mode.
+	  This controller does not support generic SPI. It only supports
+	  SPI NOR.
+
 config SPI_NXP_SPIFI
 	tristate "NXP SPI Flash Interface (SPIFI)"
 	depends on OF && (ARCH_LPC18XX || COMPILE_TEST)
diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index a552efd..4e4d400 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_SPI_ASPEED_SMC)	+= aspeed-smc.o
 obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+= cadence-quadspi.o
 obj-$(CONFIG_SPI_FSL_QUADSPI)	+= fsl-quadspi.o
 obj-$(CONFIG_SPI_HISI_SFC)	+= hisi-sfc.o
-obj-$(CONFIG_MTD_MT81xx_NOR)    += mtk-quadspi.o
+obj-$(CONFIG_SPI_MTK_QUADSPI)    += mtk-quadspi.o
 obj-$(CONFIG_SPI_NXP_SPIFI)	+= nxp-spifi.o
 obj-$(CONFIG_SPI_INTEL_SPI)	+= intel-spi.o
 obj-$(CONFIG_SPI_INTEL_SPI_PCI)	+= intel-spi-pci.o
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
