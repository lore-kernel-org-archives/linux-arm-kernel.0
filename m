Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8599C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:20:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27F420863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oHv/Qi18";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GcEno1Ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27F420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:MIME-Version:Subject:To
	:From:References:In-Reply-To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=46msxeoKPpdo6QZ8kb6Rh23edT6RDGTqw408TeYB9So=; b=oHv/Qi18n8wZ3j
	9AiPMH2nhOXovoEXjlZJRDeCfWL5PaIvKWv5uBsS4dzqB5K+hClZfY+SFmGXLyoqB5yBqFWQ225Tt
	A3hCGu39+XEjjx18Tqdbji35yLeZ8kM5MQj3PHxlOmqSidQ08XWJfUtMWAtKNnN6X368PtHIUVsa8
	RzbrhNV9ZTlD1gp0gjQj4APaBJGFlyM9Hod7jfz6WjlJVr4x+uIEYutAYMAYJHcT92Z7P8bYNYmiL
	K9DasYiD/cZfQMejXGPSSmAA5HrlnKKCCVPAThTiyyUZY29hkZa6/7vKvh7MMuuW5oBR5JTP9ZbJv
	YI1TJMUQjKR1vjADJd6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grmPK-0001LG-RC; Thu, 07 Feb 2019 16:20:11 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grmP2-0000kP-47
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 16:19:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
 In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9cwjkflv9mfVNCLxZUdjFYQ5O8RGgpFMzEICTsWGtcw=; b=GcEno1Ck/1xThkCas28Em8jrVy
 bhhSrZD+Cwv8iRhhstMS8sRnZULzHg4NVsjdjnG6LvDxHOLws0Hk9HmbNL1IttfiMIX7kvp2cyHvS
 uqkAn+M+uL8KxuahoaJm6OtJhcyECtmNRftYRZWggWKG3SF9nyPFSGizPQf0qUu1Kol0=;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:56330 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1grmOU-0002Sc-3G; Thu, 07 Feb 2019 16:19:18 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim
 4.82_1-5b7a7c0-XX) (envelope-from <rmk@armlinux.org.uk>)
 id 1grmOR-0000MV-Te; Thu, 07 Feb 2019 16:19:15 +0000
In-Reply-To: <20190207161825.ueinmyf6ygjiqzzy@shell.armlinux.org.uk>
References: <20190207161825.ueinmyf6ygjiqzzy@shell.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Kishon Vijay Abraham I <kishon@ti.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH net-next v2 3/6] ARM: dts: add description for Armada 38x
 common phy
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1grmOR-0000MV-Te@rmk-PC.armlinux.org.uk>
Date: Thu, 07 Feb 2019 16:19:15 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_081952_935888_382B347B 
X-CRM114-Status: UNSURE (   9.94  )
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
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the DT description for the Armada 38x common phy.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/armada-38x.dtsi | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 929459c42760..7b2e2bd6479b 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -335,6 +335,43 @@
 				#clock-cells = <1>;
 			};
 
+			comphy: phy@18300 {
+				compatible = "marvell,armada-380-comphy";
+				reg = <0x18300 0x100>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				comphy0: phy@0 {
+					reg = <0>;
+					#phy-cells = <1>;
+				};
+
+				comphy1: phy@1 {
+					reg = <1>;
+					#phy-cells = <1>;
+				};
+
+				comphy2: phy@2 {
+					reg = <2>;
+					#phy-cells = <1>;
+				};
+
+				comphy3: phy@3 {
+					reg = <3>;
+					#phy-cells = <1>;
+				};
+
+				comphy4: phy@4 {
+					reg = <4>;
+					#phy-cells = <1>;
+				};
+
+				comphy5: phy@5 {
+					reg = <5>;
+					#phy-cells = <1>;
+				};
+			};
+
 			coreclk: mvebu-sar@18600 {
 				compatible = "marvell,armada-380-core-clock";
 				reg = <0x18600 0x04>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
