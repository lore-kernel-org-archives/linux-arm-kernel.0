Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA56C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:38:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2A220848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eHb0o0H/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2A220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8DrQ+fvQ50PqJ11rAU8pywjDCOKkw//t1OINNoJlUYI=; b=eHb0o0H/FwyNE+
	qpRkcQaNNzMT2vk3dlB9X9vXS9PH/BMbi1XphdhOmmTT3DDU9AioohmdzmNfWX184jrT+6uQGIObw
	t63/NvI+4wvAxRg0ooX2iO6EHyJJDGFRyug8a1uBCnHNOidsDMRQcL/bl8fV4yF7fF/iW2kUY4Wm7
	55QbF04rcioFwvQ/YuNVr5mOGSduyxl9+ryAe30kRvgVBBc6i63s7Ga5hzmcH7A7VBuZ/QDUmRlZ4
	RBeQ/Zg5dSg+ny0VqXUH8yRNT7rO99dnOWzsVwyta+xaXbQf8zolfZIFMqHVelmOzGHc7jfr1OWK1
	+Tct5/YJPCLj3GydB/8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTmYD-0006Jf-AK; Mon, 03 Dec 2018 11:38:10 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTmWr-0004nq-03; Mon, 03 Dec 2018 11:36:49 +0000
X-UUID: d31003e3a2524ceb9f84b818aff93692-20181203
X-UUID: d31003e3a2524ceb9f84b818aff93692-20181203
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw01.mediatek.com (envelope-from <yt.shen@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 119335718; Mon, 03 Dec 2018 19:36:34 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Dec 2018 19:36:32 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Mon, 3 Dec 2018 19:36:32 +0800
From: YT Shen <yt.shen@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 8/8] arm64: dts: add pcie nodes for MT2712
Date: Mon, 3 Dec 2018 19:36:02 +0800
Message-ID: <1543836962-18293-9-git-send-email-yt.shen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
References: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0BFAFADDB01FA537091C5B19D1297478478762E62F69B7E15D3AC1B36A88AEFD2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_033645_800616_D5FD683D 
X-CRM114-Status: UNSURE (   9.01  )
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
 Honghui Zhang <honghui.zhang@mediatek.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

This patch add device node for mt2712 pcie.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 63 +++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index e8afb54..976d92a 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -791,6 +791,69 @@
 		};
 	};
 
+	pcie: pcie@11700000 {
+		compatible = "mediatek,mt2712-pcie";
+		device_type = "pci";
+		reg = <0 0x11700000 0 0x1000>,
+		      <0 0x112ff000 0 0x1000>;
+		reg-names = "port0", "port1";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&topckgen CLK_TOP_PE2_MAC_P0_SEL>,
+			 <&topckgen CLK_TOP_PE2_MAC_P1_SEL>,
+			 <&pericfg CLK_PERI_PCIE0>,
+			 <&pericfg CLK_PERI_PCIE1>;
+		clock-names = "sys_ck0", "sys_ck1", "ahb_ck0", "ahb_ck1";
+		phys = <&u3port0 PHY_TYPE_PCIE>, <&u3port1 PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy0", "pcie-phy1";
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x10000000>;
+
+		pcie0: pcie@0,0 {
+			device_type = "pci";
+			status = "disabled";
+			reg = <0x0000 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges;
+			num-lanes = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+					<0 0 0 2 &pcie_intc0 1>,
+					<0 0 0 3 &pcie_intc0 2>,
+					<0 0 0 4 &pcie_intc0 3>;
+			pcie_intc0: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		pcie1: pcie@1,0 {
+			device_type = "pci";
+			status = "disabled";
+			reg = <0x0800 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges;
+			num-lanes = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+			pcie_intc1: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+
 	mfgcfg: syscon@13000000 {
 		compatible = "mediatek,mt2712-mfgcfg", "syscon";
 		reg = <0 0x13000000 0 0x1000>;
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
