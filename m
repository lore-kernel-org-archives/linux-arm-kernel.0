Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BDEC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:42:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64DA218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z+tLLi7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64DA218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KqVtlsg8Euh1wjBVAB5JxWvt5d/VshAaDP8Dz7mc8ig=; b=Z+tLLi7sxTxTDH
	DOE2Z3L3hTbyQb4CI9I49+sjUjXYf7FekLkxoXCmyFEPN7DpEq3qJxeqGMT22uQrHmq85xZgLfrps
	uiQJNT18qNWbuT1D+zSFcK0CRG+joSBgd5xS409/xBh5bKi0QD5iYUjYnH1z+90Uzhmxfa6uVVcqc
	BeHK39FF8cTG36mw2Nef1YPqf3ocYO1LbSyFziUCtJOad18FwN0z842IV0/qBl/g6E35b1FMRQlAj
	sWaDZA+v0d1QaK3TWxmc4dpf7/E09aC5BKJqqDl+5ujLhwW7pgEd8cl9jl04GFMjnWGjRsCa1DXxI
	9emoyhgWqqVLy4cd3ujQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmywJ-0007sm-RB; Fri, 25 Jan 2019 10:42:23 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmyto-0004TB-J7
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:39:55 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 656AA20A7A; Fri, 25 Jan 2019 11:39:46 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 47DA320A15;
 Fri, 25 Jan 2019 11:39:29 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v4 10/10] ARM64: dts: marvell: armada-37xx: link USB hosts
 with their PHYs
Date: Fri, 25 Jan 2019 11:39:24 +0100
Message-Id: <20190125103925.15753-11-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125103925.15753-1-miquel.raynal@bootlin.com>
References: <20190125103925.15753-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_023949_829102_93412BA8 
X-CRM114-Status: GOOD (  11.47  )
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
 linux-usb@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Reference the PHY nodes from the USB controller nodes.

The USB3 host controller is wired to:
  * the first PHY of the COMPHY IP
  * the OTG-capable UTMI PHY

The USB2 host controller is wired to:
  * the host-only UTMI PHY

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index d2d8ef00c592..c0b1c9146525 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -347,6 +347,8 @@
 				marvell,usb-misc-reg = <&usb32_syscon>;
 				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&sb_periph_clk 12>;
+				phys = <&comphy0 0>, <&usb2_utmi_otg_phy>;
+				phy-names = "usb3-phy", "usb2-utmi-otg-phy";
 				status = "disabled";
 			};
 
@@ -368,6 +370,8 @@
 				reg = <0x5e000 0x1000>;
 				marvell,usb-misc-reg = <&usb2_syscon>;
 				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&usb2_utmi_host_phy>;
+				phy-names = "usb2-utmi-host-phy";
 				status = "disabled";
 			};
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
