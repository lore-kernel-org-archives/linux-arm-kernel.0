Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52233C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:42:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026B620863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S6KJJW0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026B620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=EpiZGRHkdJae25Zn2nkmaZXi3SiAyzExuoE+N+/4p5Q=; b=S6KJJW0r+msaz0BARur5MkEwuO
	WdkW9E7yPpCFYN+ktejB5z4KrTQTCnOXn6HVcI6TlNGwNa2TgMMT0VMi6bTmc+hXFWxhjNeNztHPU
	qphYbfeXffU/CCc7wA3bwt2iFcc5xXlWzQYn0Ezv0Zxh6HL1bJUfFq/lcWrbcHu6JmctXF1xBkWWM
	ZMLqdAs5DVzNBZ4a74M7uzGZmBfnhI0Le9DMp3yuRNlFCGD59Z+ri0Vw/UrgfqnEJG7To7+hLV4NM
	S4K+YHnlqCH7Yxpp7HP+b9Cjyc5Wme8TPXmvW3kAevLOThqRsqyxAyYGNhopqY0LZb/dd8/ZKcBAP
	oEfDK7og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyd0U-00011i-N5; Tue, 26 Feb 2019 13:42:50 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyd08-0000az-4K
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 13:42:29 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 894DF1A0171;
 Tue, 26 Feb 2019 14:42:26 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7CBD31A02F2;
 Tue, 26 Feb 2019 14:42:26 +0100 (CET)
Received: from fsr-ub1664-016.ea.freescale.net
 (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F33F205EB;
 Tue, 26 Feb 2019 14:42:26 +0100 (CET)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Li Yang <leoyang.li@nxp.com>, "David S . Miller" <davem@davemloft.net>
Subject: [PATCH net-next v4 4/4] dt-bindings: net: freescale: enetc: Add
 connection bindings for ENETC ethernet nodes
Date: Tue, 26 Feb 2019 15:42:23 +0200
Message-Id: <1551188543-28867-5-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551188543-28867-1-git-send-email-claudiu.manoil@nxp.com>
References: <1551188543-28867-1-git-send-email-claudiu.manoil@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_054228_304024_6101BF71 
X-CRM114-Status: GOOD (  10.86  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, alexandru.marginean@nxp.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Define connection bindings (external PHY connections and internal links)
for the ENETC on-chip ethernet controllers.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v3 - added this patch to the set
v4 - documented strictly the enetc node bindings, changed node type
     from "pci" to "ethernet" and added compatible string (Rob H.)

 .../devicetree/bindings/net/fsl-enetc.txt          | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt

diff --git a/Documentation/devicetree/bindings/net/fsl-enetc.txt b/Documentation/devicetree/bindings/net/fsl-enetc.txt
new file mode 100644
index 0000000..c812e25
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl-enetc.txt
@@ -0,0 +1,69 @@
+* ENETC ethernet device tree bindings
+
+Depending on board design and ENETC port type (internal or
+external) there are two supported link modes specified by
+below device tree bindings.
+
+Required properties:
+
+- reg		: Specifies PCIe Device Number and Function
+		  Number of the ENETC endpoint device, according
+		  to parent node bindings.
+- compatible	: Should be "fsl,enetc".
+
+1) The ENETC external port is connected to a MDIO configurable phy:
+
+In this case, the ENETC node should include a "mdio" sub-node
+that in turn should contain the "ethernet-phy" node describing the
+external phy.  Below properties are required, their bindings
+already defined in ethernet.txt or phy.txt, under
+Documentation/devicetree/bindings/net/*.
+
+Required:
+
+- phy-handle		: Phandle to a PHY on the MDIO bus.
+			  Defined in ethernet.txt.
+
+- phy-connection-type	: Defined in ethernet.txt.
+
+- mdio			: "mdio" node, defined in mdio.txt.
+
+- ethernet-phy		: "ethernet-phy" node, defined in phy.txt.
+
+Example:
+
+	ethernet@0,0 {
+		compatible = "fsl,enetc";
+		reg = <0x000000 0 0 0 0>;
+		phy-handle = <&sgmii_phy0>;
+		phy-connection-type = "sgmii";
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			sgmii_phy0: ethernet-phy@2 {
+				reg = <0x2>;
+			};
+		};
+	};
+
+2) The ENETC port is an internal port or has a fixed-link external
+connection:
+
+In this case, the ENETC port node defines a fixed link connection,
+as specified by "fixed-link.txt", under
+Documentation/devicetree/bindings/net/*.
+
+Required:
+
+- fixed-link	: "fixed-link" node, defined in "fixed-link.txt".
+
+Example:
+	ethernet@0,2 {
+		compatible = "fsl,enetc";
+		reg = <0x000200 0 0 0 0>;
+		fixed-link {
+			speed = <1000>;
+			full-duplex;
+		};
+	};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
