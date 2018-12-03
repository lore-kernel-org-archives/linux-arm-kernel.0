Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D27C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:36:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BAD20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mx1FFcag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BAD20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w7jtQTf47+7KkJO+6czmfpOZEi/etfNnOdV0CUTSbKc=; b=mx1FFcag36yoG0
	1eoM043l+WP1D6NcPyJ1ANFHOWiZTuAnAakxneGMbmscETadOOtRbG44MvQwhhed8dM6+x5cqR9F8
	i3RDdqjYBk0zC5IDwmfFwenv5hoN7SOdvFrpinYCQkd8edY6tBcOoGHzJk6eNnztlG8R4xm65amWN
	MwnRVeQQ9nezVZxw3iYtFvgoq0pPcqeH6gMmgnNMRmotwOVbclR6U5Pf+1XL3QWbev7LpW2aXC4Bj
	+ZbzA2Pb60S/irFs6H3pZLGmFj0AiCmKcJwoUtD+zIkZ9HZlHff/02ooB7Lf1dlMlkNHpoxYxejKM
	93T6eqmLgcUGOXdxxrPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTmWk-0004ne-QL; Mon, 03 Dec 2018 11:36:38 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTmWh-0004lS-Fp; Mon, 03 Dec 2018 11:36:37 +0000
X-UUID: 9cd2eccea8954489abae62ad8260c66d-20181203
X-UUID: 9cd2eccea8954489abae62ad8260c66d-20181203
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by
 mailgw02.mediatek.com (envelope-from <yt.shen@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 714875319; Mon, 03 Dec 2018 19:36:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Dec 2018 19:36:26 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Mon, 3 Dec 2018 19:36:26 +0800
From: YT Shen <yt.shen@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 4/8] arm64: dts: add spi nodes for MT2712
Date: Mon, 3 Dec 2018 19:35:58 +0800
Message-ID: <1543836962-18293-5-git-send-email-yt.shen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
References: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: E2A0513212962A709977EADCA740F84B8B21384915524F0B04FB52814DD1B4F42000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_033635_654768_3A56CC1A 
X-CRM114-Status: UNSURE (   8.63  )
X-CRM114-Notice: Please train this message.
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 YT Shen <yt.shen@mediatek.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 65 +++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 7bac8b6..4843376 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -463,6 +463,19 @@
 		status = "disabled";
 	};
 
+	spi0: spi@1100a000 {
+		compatible = "mediatek,mt2712-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x1100a000 0 0x100>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UNIVPLL2_D4>,
+			 <&topckgen CLK_TOP_SPI_SEL>,
+			 <&pericfg CLK_PERI_SPI0>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
+
 	i2c3: i2c@11010000 {
 		compatible = "mediatek,mt2712-i2c";
 		reg = <0 0x11010000 0 0x90>,
@@ -508,6 +521,58 @@
 		status = "disabled";
 	};
 
+	spi2: spi@11015000 {
+		compatible = "mediatek,mt2712-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x11015000 0 0x100>;
+		interrupts = <GIC_SPI 284 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UNIVPLL2_D4>,
+			 <&topckgen CLK_TOP_SPI_SEL>,
+			 <&pericfg CLK_PERI_SPI2>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
+
+	spi3: spi@11016000 {
+		compatible = "mediatek,mt2712-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x11016000 0 0x100>;
+		interrupts = <GIC_SPI 285 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UNIVPLL2_D4>,
+			 <&topckgen CLK_TOP_SPI_SEL>,
+			 <&pericfg CLK_PERI_SPI3>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
+
+	spi4: spi@10012000 {
+		compatible = "mediatek,mt2712-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x10012000 0 0x100>;
+		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UNIVPLL2_D4>,
+			 <&topckgen CLK_TOP_SPI_SEL>,
+			 <&infracfg CLK_INFRA_AO_SPI0>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
+
+	spi5: spi@11018000 {
+		compatible = "mediatek,mt2712-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0 0x11018000 0 0x100>;
+		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_UNIVPLL2_D4>,
+			 <&topckgen CLK_TOP_SPI_SEL>,
+			 <&pericfg CLK_PERI_SPI5>;
+		clock-names = "parent-clk", "sel-clk", "spi-clk";
+		status = "disabled";
+	};
+
 	uart4: serial@11019000 {
 		compatible = "mediatek,mt2712-uart",
 			     "mediatek,mt6577-uart";
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
