Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225B8C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:39:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D918F2082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SoR/OuxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D918F2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2/zY4OdASZxj5ez8a3jIDPYtlTLpXCf6rPQXPLkW934=; b=SoR/OuxHOsWixF
	eLKUwXHhNyBH0fLxPKuEILAqYzZK4Ut2fQ7EuAYQ3WANJ8XswqtWvX0VnHaSWeww/NhgVwCiTNm7U
	CY5vjPT1QOGfZXx79ADPM/FsnbsWErL/fkhIA+F/4INupGHWwdnmRP4BPqMfcTwR9Us/4YwTNzJaP
	fR4rIQw7lJ2PKjxc51xwALay+yPTsPPEIwdw6q7Z+cCbo7mXtyn3v8iBIQW+1WtRcY0e7sER3NTQR
	F01YOxJp9IrJmFYBFTtI9YAfpaNhZ0xR+dnyma94pC7STL/FlE8nBYjAlAqPpZlGypRi6zP9NVeYi
	v5OXW870LOFRhHphfgRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPrA-0005Ei-3F; Tue, 29 Jan 2019 09:39:00 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPpC-0003hS-Tp
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:37:04 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 6F6DD207A3; Tue, 29 Jan 2019 10:36:57 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id CE6A2209BF;
 Tue, 29 Jan 2019 10:36:38 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v5 5/6] ARM64: dts: marvell: armada-37xx: declare USB2 UTMI
 PHYs
Date: Tue, 29 Jan 2019 10:36:34 +0100
Message-Id: <20190129093635.4321-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190129093635.4321-1-miquel.raynal@bootlin.com>
References: <20190129093635.4321-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_013659_770001_A5BBF3E8 
X-CRM114-Status: GOOD (  12.50  )
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
Cc: devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Marvell Armada 3700 SoCs there are two USB2 UTMI PHYs. They are
both very similar but only one has OTG/charging capabilities.

Because there are USB host registers and PHY registers mixed in a
single area, a system controller is also created and referenced from
both the USB host node and the PHY node.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 28 ++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 5cfd1b920f31..d2d8ef00c592 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -344,18 +344,46 @@
 				compatible = "marvell,armada3700-xhci",
 				"generic-xhci";
 				reg = <0x58000 0x4000>;
+				marvell,usb-misc-reg = <&usb32_syscon>;
 				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&sb_periph_clk 12>;
 				status = "disabled";
 			};
 
+			usb2_utmi_otg_phy: phy@5d000 {
+				compatible = "marvell,a3700-utmi-otg-phy";
+				reg = <0x5d000 0x800>;
+				marvell,usb-misc-reg = <&usb32_syscon>;
+				#phy-cells = <0>;
+			};
+
+			usb32_syscon: system-controller@5d800 {
+				compatible = "marvell,armada-3700-usb2-host-device-misc",
+				"syscon";
+				reg = <0x5d800 0x800>;
+			};
+
 			usb2: usb@5e000 {
 				compatible = "marvell,armada-3700-ehci";
 				reg = <0x5e000 0x1000>;
+				marvell,usb-misc-reg = <&usb2_syscon>;
 				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
+			usb2_utmi_host_phy: phy@5f000 {
+				compatible = "marvell,a3700-utmi-host-phy";
+				reg = <0x5f000 0x800>;
+				marvell,usb-misc-reg = <&usb2_syscon>;
+				#phy-cells = <0>;
+			};
+
+			usb2_syscon: system-controller@5f800 {
+				compatible = "marvell,armada-3700-usb2-host-misc",
+				"syscon";
+				reg = <0x5f800 0x800>;
+			};
+
 			xor@60900 {
 				compatible = "marvell,armada-3700-xor";
 				reg = <0x60900 0x100>,
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
