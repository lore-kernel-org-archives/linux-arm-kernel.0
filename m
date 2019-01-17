Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD53C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:17:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E0A20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lz88MJg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E0A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CKlObq2fklSqNVZ9vUuiguaH+QdVlpfkdWK3Wp1Ev3Y=; b=lz88MJg6eM/iGO
	1GcNDp4LT4ZGwnG4sSvGjMhoj5CXJPfR4we2pFtZ3IL6ab4ZbZBTBpWRwwROWNNZhqEututr6L5E0
	1AA8trzKPA4NTLFpdHsq46dQ/5JGz09MbagBeMR1R15l1bFnO0gL0zkBtJKdmeKRpPUv02TKyEDAr
	GAEzH/LqUyEmkFr+vZFTEymUxTbGex/zGBBq8JScgtMhvdu4oysMUswHXkpedWrbZvj1QAgVJgjPr
	GUIxrMmXtH2LK+6EtUFHlIf3AgK5wxDYmSf42xMPGUZpQZI5Q61R9giAXqMiq0FJIHL7LPwFB3giW
	zdG2nX4NEzgUEx4n6CLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk1vB-0002AD-NE; Thu, 17 Jan 2019 07:17:01 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk1ua-0001Y6-FB; Thu, 17 Jan 2019 07:16:30 +0000
X-UUID: e5b1bc7658a34903a70f9f304a0aa767-20190116
X-UUID: e5b1bc7658a34903a70f9f304a0aa767-20190116
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 153564971; Wed, 16 Jan 2019 23:16:19 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Jan 2019 23:16:17 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 17 Jan 2019 15:16:15 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 17 Jan 2019 15:16:13 +0800
From: <min.guo@mediatek.com>
To: Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: usb: musb: Add support for MediaTek musb
 controller
Date: Thu, 17 Jan 2019 15:15:45 +0800
Message-ID: <1547709348-17506-2-git-send-email-min.guo@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
References: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_231624_885445_67EDB4CE 
X-CRM114-Status: GOOD (  12.64  )
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
 hdegoede@redhat.com, tony@atomide.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, Min Guo <min.guo@mediatek.com>,
 chunfeng.yun@mediatek.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Min Guo <min.guo@mediatek.com>

This adds support for MediaTek musb controller in
host, peripheral and otg mode.

Signed-off-by: Min Guo <min.guo@mediatek.com>
---
 .../devicetree/bindings/usb/mediatek,musb.txt      | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt

diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
new file mode 100644
index 0000000..3e3f671
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
@@ -0,0 +1,43 @@
+MediaTek musb DRD/OTG controller
+-------------------------------------------
+
+Required properties:
+ - compatible      : should be "mediatek,mtk-musb"
+ - reg             : specifies physical base address and size of
+   the registers
+ - interrupts      : interrupt used by musb controller
+ - interrupt-names : must be "mc"
+ - phys            : PHY specifier for the OTG phy
+ - dr_mode         : should be one of "host", "peripheral" or "otg",
+   refer to usb/generic.txt
+ - clocks          : a list of phandle + clock-specifier pairs, one for
+   each entry in clock-names
+ - clock-names     : must contain "main", "mcu", "univpll"
+   for clocks of controller
+
+Optional properties:
+ - extcon : external connector for VBUS and IDPIN changes detection,
+   needed when supports dual-role mode.
+ - vbus-supply : reference to the VBUS regulator, needed when supports
+   dual-role mode.
+ - power-domains   : a phandle to USB power domain node to control USB's
+   MTCMOS
+
+Example:
+
+usb2: usb@11200000 {
+	compatible = "mediatek,mt2701-musb",
+		     "mediatek,mtk-musb";
+	reg = <0 0x11200000 0 0x1000>;
+	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
+	interrupt-names = "mc";
+	phys = <&u2port2 PHY_TYPE_USB2>;
+	vbus-supply = <&usb_vbus>;
+	extcon = <&extcon_usb>;
+	dr_mode = "otg";
+	clocks = <&pericfg CLK_PERI_USB0>,
+		 <&pericfg CLK_PERI_USB0_MCU>,
+		 <&pericfg CLK_PERI_USB_SLV>;
+	clock-names = "main","mcu","univpll";
+	power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
+};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
