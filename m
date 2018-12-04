Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A503C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:04:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1D42081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Emk4930f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1D42081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=os4ksAEElg5P2gIkqkp3W4QRpKKQK0XrWqymQXnD70o=; b=Emk4930fBR91UY
	vRwDGZs4H1SQO+BbPFzh1ixNvn2ckuyFaUalxP7320+zZnAPI4IqZ7yalzPSzq9+djlgNQ5KjAV+f
	vq7wL9rZo/SiVHAd5A1AFBEsTcWn5ncbrSHir1umPyujdb7DxAqZEkKUSitIHwHHTh1c6qvQYjZbF
	J3ikOMN4IDlQDeNGJPzXQ1IfuL7Fd9iQaR5V0qyDmm70nALp2Pqj8QWp3UcuVVfJdeRqBHAmDExlC
	AUVn5BUVdfKyh+kQk9QTCrtsC/siBjj0ODdyCwnNcEJhgbiRl/40YEL+uBB2wxBiGugevzTOsmIJk
	gp7LvutdlbPr2+olJr3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFzc-00029Y-C2; Tue, 04 Dec 2018 19:04:24 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFzA-0001i1-77
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:03:59 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E61D620A5F; Tue,  4 Dec 2018 20:03:54 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id 4BAA22087D;
 Tue,  4 Dec 2018 20:03:38 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v3 4/6] dt-bindings: cp110: document the thermal interrupt
 capabilities
Date: Tue,  4 Dec 2018 20:03:30 +0100
Message-Id: <20181204190332.10351-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204190332.10351-1-miquel.raynal@bootlin.com>
References: <20181204190332.10351-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_110356_400462_FE42B7D9 
X-CRM114-Status: GOOD (  13.45  )
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
 linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Marc Zyngier <marc.zyngier@arm.com>,
 David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The thermal IP can produce interrupts on overheat situation.
Describe them.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/arm/marvell/cp110-system-controller.txt     | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
index 81ce742d2760..4db4119a6d19 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
@@ -199,6 +199,9 @@ Thermal:
 The thermal IP can probe the temperature all around the processor. It
 may feature several channels, each of them wired to one sensor.
 
+It is possible to setup an overheat interrupt by giving at least one
+critical point to any subnode of the thermal-zone node.
+
 For common binding part and usage, refer to
 Documentation/devicetree/bindings/thermal/thermal.txt
 
@@ -208,6 +211,11 @@ Required properties:
 - reg: register range associated with the thermal functions.
 
 Optional properties:
+- interrupts-extended: overheat interrupt handle. Should point to
+  a line of the ICU-SEI irqchip (116 is what is usually used by the
+  firmware). The ICU-SEI will redirect towards interrupt line #37 of the
+  AP SEI which is shared across all CPs.
+  See interrupt-controller/interrupts.txt
 - #thermal-sensor-cells: shall be <1> when thermal-zones subnodes refer
   to this IP and represents the channel ID. There is one sensor per
   channel. O refers to the thermal IP internal channel.
@@ -220,6 +228,7 @@ CP110_LABEL(syscon1): system-controller@6f8000 {
 	CP110_LABEL(thermal): thermal-sensor@70 {
 		compatible = "marvell,armada-cp110-thermal";
 		reg = <0x70 0x10>;
+		interrupts-extended = <&CP110_LABEL(icu_sei) 116 IRQ_TYPE_LEVEL_HIGH>;
 		#thermal-sensor-cells = <1>;
 	};
 };
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
