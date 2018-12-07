Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F5EC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:48:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69C220850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SDow1kCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69C220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wQBGfTCV7mnMqen491pfMw4NTQ6bm5itBPPf0hy+xzg=; b=SDow1kCc5NRQI/
	mW7Lh+WY7Mivl0fDOatcMciyhqw6Cd8BPS0e6Rf+VHB9J6gvHuyA29YzwJ+ACJHQ/8mviMy5/bl6k
	rP/N6ExY6f6XFXuQa9wU8GKCQG9WEu9pgRhBwpLMeJZhgWsbwHm24vy3gZN1HWwJz3fC8dwR6Dz1L
	JJJH7se/4lrzjtyCGt+ZXd35B/QutzcVAX64cqurmFfKdTsSSrwTlmY8uNTQQlrzMa9VTBs5A0QR2
	tqFE+Xzb7fhBmxwocPgNVMXOzkqbCUiZows+dylR9g4gWKjmmfA7IDi85Dg2bMVQNY6ZmyIxsFvvf
	msQNYHiaQPy+7iuoNlxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVArq-0007K6-RY; Fri, 07 Dec 2018 07:48:10 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVArO-0006jr-NT; Fri, 07 Dec 2018 07:47:47 +0000
X-UUID: 112c026c99b94c6bacabbf009e34cbfe-20181207
X-UUID: 112c026c99b94c6bacabbf009e34cbfe-20181207
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by
 mailgw01.mediatek.com (envelope-from <long.cheng@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 213092449; Fri, 07 Dec 2018 15:47:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 7 Dec 2018 15:47:29 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 7 Dec 2018 15:47:28 +0800
From: Long Cheng <long.cheng@mediatek.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 2/2] arm: dts: mt2701: add uart APDMA to device tree
Date: Fri, 7 Dec 2018 15:47:21 +0800
Message-ID: <1544168842-13860-3-git-send-email-long.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1544168842-13860-1-git-send-email-long.cheng@mediatek.com>
References: <1544168842-13860-1-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_234743_648448_FB7166AE 
X-CRM114-Status: UNSURE (   9.38  )
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
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@kernel.org>,
 srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 YT Shen <yt.shen@mediatek.com>, dmaengine@vger.kernel.org,
 Long Cheng <long.cheng@mediatek.com>, linux-mediatek@lists.infradead.org,
 linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

1. add uart APDMA controller device node
2. add uart 0/1/2/3/4/5 DMA function

Signed-off-by: Long Cheng <long.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi |   50 +++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 976d92a..a59728b 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -300,6 +300,9 @@
 		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 10
+			&apdma 11>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -378,6 +381,38 @@
 		status = "disabled";
 	};
 
+	apdma: dma-controller@11000400 {
+		compatible = "mediatek,mt2712-uart-dma",
+			     "mediatek,mt6577-uart-dma";
+		reg = <0 0x11000400 0 0x80>,
+		      <0 0x11000480 0 0x80>,
+		      <0 0x11000500 0 0x80>,
+		      <0 0x11000580 0 0x80>,
+		      <0 0x11000600 0 0x80>,
+		      <0 0x11000680 0 0x80>,
+		      <0 0x11000700 0 0x80>,
+		      <0 0x11000780 0 0x80>,
+		      <0 0x11000800 0 0x80>,
+		      <0 0x11000880 0 0x80>,
+		      <0 0x11000900 0 0x80>,
+		      <0 0x11000980 0 0x80>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 105 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 107 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 108 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 109 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 111 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_AP_DMA>;
+		clock-names = "apdma";
+		#dma-cells = <1>;
+	};
+
 	uart0: serial@11002000 {
 		compatible = "mediatek,mt2712-uart",
 			     "mediatek,mt6577-uart";
@@ -385,6 +420,9 @@
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 0
+			&apdma 1>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -395,6 +433,9 @@
 		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 2
+			&apdma 3>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -405,6 +446,9 @@
 		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 4
+			&apdma 5>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -415,6 +459,9 @@
 		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 6
+			&apdma 7>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -629,6 +676,9 @@
 		interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 8
+			&apdma 9>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
