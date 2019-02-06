Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4978FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:35:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D9B218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sV/ZHhuw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DDv6jKAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D9B218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:MIME-Version:Subject:To
	:From:References:In-Reply-To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HG4WEyeWwq5j7Zl6MREQJ773GW08NVJnRqFnHtaqkLE=; b=sV/ZHhuwlUMDND
	IzaJKH12zoklJ92xElKAgd1g1gJo+Vt5OvOY+EBz7TGPyiTcQOFEk2kdRkvHmzsiuufihKqPmITtH
	xxqplhJbfBBvvozp2xVqRnsaEtFgHbm/9u5Xo3z/xGU1Vl4ZlhQ5eitVocbP5s8s+/dEcp5yMsBIq
	H1FsMBBucSFSg2CuH/hRip3sTe07hMDvGasp4meBYeFK6rY+AnorBsENpDAPiSc9nxRRC9klM4AOO
	mgfxYDWkqilFYmLjl3YpvuyFf2BOmuu7j0EoSSfpQCtsecMZw5w4rpEPcp5LHVe8hYYbZT4ZxnJ2u
	uUSHWiulV6SITzyQSNKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grLU8-0008J0-EQ; Wed, 06 Feb 2019 11:35:20 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grLU5-0006pp-Ep
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 11:35:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
 In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xs2AeFQYTysgkl3KG/GkyOALRM4oktxQFWnu5zdT0rQ=; b=DDv6jKAIrWV93p1opI7DJYLhvo
 eWMjAb7t0f95oQ2jh2BRPr2PtjYBQcFONrMNvrb3xB7Y5J5WfywNsNArWj+pkGFtfb8P3MKktp5gC
 kdQmVlVlrw7aLLtn2LaaEKCDGjso7KTv5IcvZ0cA8VU8L2lzvqaAjsKYL+/EPmqVHUUI=;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:48916 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1grLTc-0001Bc-Cs; Wed, 06 Feb 2019 11:34:48 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim
 4.82_1-5b7a7c0-XX) (envelope-from <rmk@armlinux.org.uk>)
 id 1grLTb-00060v-Dk; Wed, 06 Feb 2019 11:34:47 +0000
In-Reply-To: <20190206113409.ko7lwuv5kb7l7rjo@shell.armlinux.org.uk>
References: <20190206113409.ko7lwuv5kb7l7rjo@shell.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Kishon Vijay Abraham I <kishon@ti.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH net-next 1/6] dt-bindings: phy: Armada 38x common phy bindings
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1grLTb-00060v-Dk@rmk-PC.armlinux.org.uk>
Date: Wed, 06 Feb 2019 11:34:47 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_033517_507064_ABEDE101 
X-CRM114-Status: GOOD (  11.39  )
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

Add the Marvell Armada 38x common phy bindings.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 .../bindings/phy/phy-armada38x-comphy.txt          | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-armada38x-comphy.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-armada38x-comphy.txt b/Documentation/devicetree/bindings/phy/phy-armada38x-comphy.txt
new file mode 100644
index 000000000000..ad49e5c01334
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-armada38x-comphy.txt
@@ -0,0 +1,40 @@
+mvebu armada 38x comphy driver
+------------------------------
+
+This comphy controller can be found on Marvell Armada 38x. It provides a
+number of shared PHYs used by various interfaces (network, sata, usb,
+PCIe...).
+
+Required properties:
+
+- compatible: should be "marvell,armada-380-comphy"
+- reg: should contain the comphy register location and length.
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+
+A sub-node is required for each comphy lane provided by the comphy.
+
+Required properties (child nodes):
+
+- reg: comphy lane number.
+- #phy-cells : from the generic phy bindings, must be 1. Defines the
+               input port to use for a given comphy lane.
+
+Example:
+
+	comphy: phy@18300 {
+		compatible = "marvell,armada-380-comphy";
+		reg = <0x18300 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpm_comphy0: phy@0 {
+			reg = <0>;
+			#phy-cells = <1>;
+		};
+
+		cpm_comphy1: phy@1 {
+			reg = <1>;
+			#phy-cells = <1>;
+		};
+	};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
