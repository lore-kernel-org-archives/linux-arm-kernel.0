Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1E0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:46:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD5221908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y4ey0bO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD5221908
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IqiR3T5JbsyIkXrnJJYGBzjqKcuza6Wcj6P3/ZnXyi0=; b=Y4ey0bO8i4XssN
	s4RX85RST2kFQCbsu6elSnhQZXnSWQOpfImgpaE37LVCvfK1FZiTJ8yRhpIfI0aqMJ9o6IyTsvG67
	0MlKxECggbj2039CSijZeaqJiYwkhgU0JTY9xp+gmZF8l6nevV2+3L3+vsU+57C9Akh+bpGYRNmLR
	aSvaHvi7Eq0IX1movgYcyE5Wmv8IRhM3Xz3sJWnAbF4JTUND/RbXluaasYmuIZ99us4WhkfIM2nU6
	C6LDoaactr9uEDIuoLHM+pBJV7jZSEmukzIxD0hxApP77wR6qKsA7zfVqioUNbFv4RVUvgDgfvrt6
	+tbOntTwryT4ccXF2L7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaJG5-0005h0-IZ; Fri, 21 Dec 2018 11:46:25 +0000
Received: from mail-sh2.amlogic.com ([58.32.228.45])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaJFj-00059M-Go; Fri, 21 Dec 2018 11:46:07 +0000
Received: from localhost.localdomain (10.18.11.217) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Fri, 21 Dec 2018
 19:46:00 +0800
From: Jianxin Pan <jianxin.pan@amlogic.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>,
 <linux-mtd@lists.infradead.org>
Subject: [PATCH RESEND v8 1/2] dt-bindings: nand: meson: add Amlogic NAND
 controller driver
Date: Fri, 21 Dec 2018 19:45:23 +0800
Message-ID: <1545392724-6637-2-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545392724-6637-1-git-send-email-jianxin.pan@amlogic.com>
References: <1545392724-6637-1-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
X-Originating-IP: [10.18.11.217]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_034604_360971_92579351 
X-CRM114-Status: GOOD (  11.41  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Richard Weinberger <richard@nod.at>, Yixun Lan <yixun.lan@amlogic.com>,
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 devicetree@vger.kernel.org, Liang Yang <liang.yang@amlogic.com>,
 Jian Hu <jian.hu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Liang Yang <liang.yang@amlogic.com>

Add Amlogic NAND controller dt-bindings for Meson SoC,
Current this driver support GXBB/GXL/AXG platform.

Signed-off-by: Liang Yang <liang.yang@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/amlogic,meson-nand.txt | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
new file mode 100644
index 0000000..3983c11
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
@@ -0,0 +1,60 @@
+Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
+
+This file documents the properties in addition to those available in
+the MTD NAND bindings.
+
+Required properties:
+- compatible : contains one of:
+  - "amlogic,meson-gxl-nfc"
+  - "amlogic,meson-axg-nfc"
+- clocks     :
+	A list of phandle + clock-specifier pairs for the clocks listed
+	in clock-names.
+
+- clock-names: Should contain the following:
+	"core" - NFC module gate clock
+	"device" - device clock from eMMC sub clock controller
+	"rx" - rx clock phase
+	"tx" - tx clock phase
+
+- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
+				controller port C
+
+Optional children nodes:
+Children nodes represent the available nand chips.
+
+Other properties:
+see Documentation/devicetree/bindings/mtd/nand.txt for generic bindings.
+
+Example demonstrate on AXG SoC:
+
+	sd_emmc_c_clkc: mmc@7000 {
+		compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
+		reg = <0x0 0x7000 0x0 0x800>;
+	};
+
+	nand-controller@7800 {
+		compatible = "amlogic,meson-axg-nfc";
+		reg = <0x0 0x7800 0x0 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
+
+		clocks = <&clkc CLKID_SD_EMMC_C>,
+			<&sd_emmc_c_clkc CLKID_MMC_DIV>,
+			<&sd_emmc_c_clkc CLKID_MMC_PHASE_RX>,
+			<&sd_emmc_c_clkc CLKID_MMC_PHASE_TX>;
+		clock-names = "core", "device", "rx", "tx";
+		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&nand_pins>;
+
+		nand@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			nand-on-flash-bbt;
+		};
+	};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
