Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AF7C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:03:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65FF20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WlcuCMW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65FF20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1A3GwIDzGjOsm8pM8y2KdyotyAHe7RZ5are4SqTbTJM=; b=WlcuCMW8nO66LU
	p1f5nCF2UDs3eP2igmQSpnHYH9/FDQCUPWV+jcZskE9jnBBowg3HSe8Q4FXnwZNltb3edkkyRGVUG
	VChhByCCzaDLHqX9K2z7lP1AVu0sOfcPLezMXfenoSktfJsEKB8ySEDwrE/eeuGr/49UiD9+b2ASC
	HjxDdXA0wWwwzBkTHRw0VmVPM+rk7s7rT0A3kzkz9WG/tdQbfinApjYhJcwgR/N4rwQl3s82PiBw5
	j2282GRuHcn6fnjJzDa+vvm4Ee8R84BHynlO2h+NW4lJwloq1SKbNKC2huTZxIQm0L7Cs51fBw46u
	cERkeyswdQimfowGbGdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwlBx-0007k8-Tz; Thu, 21 Feb 2019 10:02:57 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwlBa-0007Je-Gj; Thu, 21 Feb 2019 10:02:36 +0000
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 8CC53100013;
 Thu, 21 Feb 2019 10:02:27 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [RFC PATCH 02/27] mtd: nand: Compile in the NAND core by default
Date: Thu, 21 Feb 2019 11:01:51 +0100
Message-Id: <20190221100216.25255-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221100216.25255-1-miquel.raynal@bootlin.com>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_020234_706152_0C740A4B 
X-CRM114-Status: GOOD (  11.81  )
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

Force the NAND core be compiled-in when using any kind of NAND.

Also remove the redundant dependencies on MTD which is enforced by the
game of the if/endif blocs.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/Kconfig         | 12 ++++++++++--
 drivers/mtd/nand/onenand/Kconfig |  1 -
 drivers/mtd/nand/raw/Kconfig     |  1 -
 drivers/mtd/nand/spi/Kconfig     |  1 -
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 495751ed3fd7..e8d26a715922 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -1,6 +1,14 @@
-config MTD_NAND_CORE
-	tristate
+menuconfig MTD_NAND_CORE
+	tristate "NAND"
+	default y
+	help
+	  Embed the NAND core. This is the generic part between raw
+	  NAND, SPI NAND and Onenand.
+
+if MTD_NAND_CORE
 
 source "drivers/mtd/nand/onenand/Kconfig"
 source "drivers/mtd/nand/raw/Kconfig"
 source "drivers/mtd/nand/spi/Kconfig"
+
+endif
diff --git a/drivers/mtd/nand/onenand/Kconfig b/drivers/mtd/nand/onenand/Kconfig
index 9dc15748947b..c168f3b4b296 100644
--- a/drivers/mtd/nand/onenand/Kconfig
+++ b/drivers/mtd/nand/onenand/Kconfig
@@ -1,6 +1,5 @@
 menuconfig MTD_ONENAND
 	tristate "OneNAND Device Support"
-	depends on MTD
 	depends on HAS_IOMEM
 	help
 	  This enables support for accessing all type of OneNAND flash
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 510a6b32820d..ebb8a3da9fa5 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -11,7 +11,6 @@ config MTD_NAND_ECC_SW_HAMMING_SMC
 
 menuconfig MTD_RAW_NAND
 	tristate "Raw/Parallel NAND Device Support"
-	depends on MTD
 	select MTD_NAND_ECC_SW_HAMMING
 	help
 	  This enables support for accessing all type of raw/parallel
diff --git a/drivers/mtd/nand/spi/Kconfig b/drivers/mtd/nand/spi/Kconfig
index 7c37d2929b68..7631050610ab 100644
--- a/drivers/mtd/nand/spi/Kconfig
+++ b/drivers/mtd/nand/spi/Kconfig
@@ -1,6 +1,5 @@
 menuconfig MTD_SPI_NAND
 	tristate "SPI NAND device Support"
-	select MTD_NAND_CORE
 	depends on SPI_MASTER
 	select SPI_MEM
 	help
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
