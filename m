Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34A4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:50:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28772082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tFpBe+Wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28772082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wQBGfTCV7mnMqen491pfMw4NTQ6bm5itBPPf0hy+xzg=; b=tFpBe+WzX5Ifl1
	LhNsoebFnszvYM0EtC0bRlq0gKFJLkeiIiTIkRSd56Vzy7ziOplzXfbxyz+ovl6HhcPImTEoBbnOw
	dzT+8jgQs+p0TN8IEqCLMXwW9OppLfQz0UmabVzJ554GvtmekBWYCo0vY/saskwxNACfPEkbMxKCc
	4zvcTkf5QOm6QSKTstkPcfUkL/5ornE3Vm5dOItzVcuQdj1UXYmRPOzr3o/vMB42peccI5/I0GvFO
	2NkOLaY0iCRIk04ajDF48sz5lMJo9dn18TOaHz9m4/y0l2pWnKYeKYqHSVgiXU9+M3IUxCYbIA5+X
	EziDYv1zOjCoJjUzrzrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWFOD-0005Ux-9j; Mon, 10 Dec 2018 06:50:01 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWFO8-0005E8-M9; Mon, 10 Dec 2018 06:49:58 +0000
X-UUID: 213959fed1614c4e97bfc9b7cd114a2e-20181210
X-UUID: 213959fed1614c4e97bfc9b7cd114a2e-20181210
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw02.mediatek.com (envelope-from <long.cheng@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1056328416; Mon, 10 Dec 2018 11:48:26 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Dec 2018 11:47:57 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Dec 2018 11:47:56 +0800
From: Long Cheng <long.cheng@mediatek.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [resend PATCH v4 2/2] arm: dts: mt2712: add uart APDMA to device tree
Date: Mon, 10 Dec 2018 11:47:45 +0800
Message-ID: <1544413665-1222-3-git-send-email-long.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1544413665-1222-1-git-send-email-long.cheng@mediatek.com>
References: <1544413665-1222-1-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_224956_981822_E837144E 
X-CRM114-Status: UNSURE (   9.93  )
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
