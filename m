Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285CBC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:38:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D233E20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AHru3LTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D233E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DxUXL1PYx9kyZyemirwnpTIMmQS3BTNN2MQp0kPe8xw=; b=AHru3LTo6HcM+2
	SFVrBey3Sa/GpwWB+VfGrFMJiMTEyOvTB6Iost0oxAENbLZw95GzX6wcppe94k/OXuSw5SamcmgZq
	t1nLX966dLVhNuOd0FY0Du+U/VM62Kq3H42/v4bqOjhrDN8+QeQGxApvtneGg2b7WqR6+WEhpRPpM
	3u2ZWJSzlUGxSLLoQf8Gkt6430PwWzbEC2dWKp4iwGmuMjGyHSS/6dqKzwY8ADE/73o5RUA7gW5Jq
	M8kmbFHtOmDrjge4ARIvB7OVSFbkys4cvIAkhYtiAaX07ttCsLgaxsGlt4hcIz6nxLDBEggOXWd/I
	X9Pk5wouaOlzuB0qDFyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTmYW-0006aP-FZ; Mon, 03 Dec 2018 11:38:28 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTmWq-0004lt-WF; Mon, 03 Dec 2018 11:36:51 +0000
X-UUID: 61fa3bdee752427cbb03096412968724-20181203
X-UUID: 61fa3bdee752427cbb03096412968724-20181203
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by
 mailgw01.mediatek.com (envelope-from <yt.shen@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 454374608; Mon, 03 Dec 2018 19:36:31 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Dec 2018 19:36:29 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Mon, 3 Dec 2018 19:36:29 +0800
From: YT Shen <yt.shen@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 6/8] arm64: dts: add mmc nodes for MT2712
Date: Mon, 3 Dec 2018 19:36:00 +0800
Message-ID: <1543836962-18293-7-git-send-email-yt.shen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
References: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_033645_767688_F2F65621 
X-CRM114-Status: UNSURE (   7.86  )
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
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index e9856fe..4f0aa65 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -611,6 +611,40 @@
 		status = "disabled";
 	};
 
+	mmc0: mmc@11230000 {
+		compatible = "mediatek,mt2712-mmc";
+		reg = <0 0x11230000 0 0x1000>;
+		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_MSDC30_0>,
+			 <&pericfg CLK_PERI_MSDC50_0_HCLK_EN>,
+			 <&pericfg CLK_PERI_MSDC30_0_QTR_EN>,
+			 <&pericfg CLK_PERI_MSDC50_0_EN>;
+		clock-names = "source", "hclk", "bus_clk", "source_cg";
+		status = "disabled";
+	};
+
+	mmc1: mmc@11240000 {
+		compatible = "mediatek,mt2712-mmc";
+		reg = <0 0x11240000 0 0x1000>;
+		interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_MSDC30_1>,
+			 <&topckgen CLK_TOP_AXI_SEL>,
+			 <&pericfg CLK_PERI_MSDC30_1_EN>;
+		clock-names = "source", "hclk", "source_cg";
+		status = "disabled";
+	};
+
+	mmc2: mmc@11250000 {
+		compatible = "mediatek,mt2712-mmc";
+		reg = <0 0x11250000 0 0x1000>;
+		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_MSDC30_2>,
+			 <&topckgen CLK_TOP_AXI_SEL>,
+			 <&pericfg CLK_PERI_MSDC30_2_EN>;
+		clock-names = "source", "hclk", "source_cg";
+		status = "disabled";
+	};
+
 	ssusb: usb@11271000 {
 		compatible = "mediatek,mt2712-mtu3", "mediatek,mtu3";
 		reg = <0 0x11271000 0 0x3000>,
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
