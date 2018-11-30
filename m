Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4992C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:49:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9712145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NuFNjgPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9712145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=inmiTKLruoY9QTO80DEaeaZ72UxkBolDISi60taOOrE=; b=NuFNjgPdAM/ScV
	Q7pvtH9Hf3pk+aWOMf+wADpEJD+ERMaAJxYxb0DP8+tUfNokxpPNzyjez4ii9HKHqnfIovPhLBpXF
	2i99UoLIwyWiO88TGbMIE4t/Y7aGrpW0SPYOXgd14GrQeqD/SJ35Z4YEPMjRXv1e7z3bdC8z9TQ7v
	fdC2eB6nUF29lu6LN46v5/HEoSuj0umbCaosv3xYLyDQhpJO+CMcxBjfJSNVFrBiTtOFtJEpKZJb2
	lB1VVoJAynvOpkXFU9i+m5l6FtrojctaJlsgihzbOpei0r9SSJgJtNlAdlodcueU3yVKezXVb68WK
	R3NJLy5IRgcJlzGZiBlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSk6s-0000nE-38; Fri, 30 Nov 2018 14:49:38 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSk5T-0007pQ-8o
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 14:48:14 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9A0D120CFC; Fri, 30 Nov 2018 15:48:05 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 66FAC20D04;
 Fri, 30 Nov 2018 15:47:46 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 5/8] dt-bindings: phy: mvebu-comphy: extend the file to
 describe a3700 bindings
Date: Fri, 30 Nov 2018 15:47:40 +0100
Message-Id: <20181130144743.675-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130144743.675-1-miquel.raynal@bootlin.com>
References: <20181130144743.675-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_064811_681696_327F152C 
X-CRM114-Status: GOOD (  17.59  )
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
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Marcin Wojtas <mw@semihalf.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Current file describe COMPHY bindings for the IP available on the
CP110 of Armada 7k/8k. Bindings are very close (and serve the same
purpose) as the new Armada 3700 COMPHY driver so update this file to
describe both. Also add an example of how to use this second
compatible (same as for the ESPRESSObin).

While doing so, enhance a bit the file by adding upper case where
needed.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/phy/phy-mvebu-comphy.txt         | 65 +++++++++++++++----
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt b/Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
index bfcf80341657..cf2cd86db267 100644
--- a/Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
+++ b/Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
@@ -1,16 +1,27 @@
-mvebu comphy driver
--------------------
+MVEBU comphy drivers
+--------------------
 
-A comphy controller can be found on Marvell Armada 7k/8k on the CP110. It
-provides a number of shared PHYs used by various interfaces (network, sata,
-usb, PCIe...).
+COMPHY controllers can be found on the following Marvell MVEBU SoCs:
+* Armada 7k/8k (on the CP110)
+* Armada 3700
+It provides a number of shared PHYs used by various interfaces (network, SATA,
+USB, PCIe...).
 
 Required properties:
 
-- compatible: should be "marvell,comphy-cp110"
-- reg: should contain the comphy register location and length.
-- marvell,system-controller: should contain a phandle to the
-                             system controller node.
+- compatible: should be one of:
+  * "marvell,comphy-cp110" for Armada 7k/8k
+  * "marvell,comphy-a3700" for Armada 3700
+- reg: should contain the COMPHY register(s) location(s) and length(s).
+  * 1 entry for Armada 7k/8k
+  * 4 entries for Armada 3700 along with the corresponding reg-names
+    properties, memory areas are:
+    * Generic COMPHY registers
+    * Lane 1 (PCIe/GbE)
+    * Lane 0 (USB3/GbE)
+    * Lane 2 (SATA/USB3)
+- marvell,system-controller: should contain a phandle to the system
+			     controller node (only for Armada 7k/8k)
 - #address-cells: should be 1.
 - #size-cells: should be 0.
 
@@ -18,11 +29,11 @@ A sub-node is required for each comphy lane provided by the comphy.
 
 Required properties (child nodes):
 
-- reg: comphy lane number.
-- #phy-cells : from the generic phy bindings, must be 1. Defines the
+- reg: COMPHY lane number.
+- #phy-cells : from the generic PHY bindings, must be 1. Defines the
                input port to use for a given comphy lane.
 
-Example:
+Examples:
 
 	cpm_comphy: phy@120000 {
 		compatible = "marvell,comphy-cp110";
@@ -41,3 +52,33 @@ Example:
 			#phy-cells = <1>;
 		};
 	};
+
+	comphy: phy@18300 {
+		compatible = "marvell,comphy-a3700";
+		reg = <0x18300 0x300>,
+		<0x1F000 0x400>,
+		<0x5C000 0x400>,
+		<0xe0178 0x8>;
+		reg-names = "comphy",
+		"lane1_pcie_gbe",
+		"lane0_usb3_gbe",
+		"lane2_sata_usb3";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+
+		comphy0: phy@0 {
+			reg = <0>;
+			#phy-cells = <1>;
+		};
+
+		comphy1: phy@1 {
+			reg = <1>;
+			#phy-cells = <1>;
+		};
+
+		comphy2: phy@2 {
+			reg = <2>;
+			#phy-cells = <1>;
+		};
+	};
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
