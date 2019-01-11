Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C99C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:33:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDDD20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LhuqOQSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDDD20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bpPUsX0o05mGOuPJWR8F0nKpz9NbpmYwvQR6dRIGTNQ=; b=LhuqOQSqA+BT8c
	mor9VfLvU/dctxzH9puGucU/DBkGiBbPhKr03DH6pmLrLgCgLIkmpFVt1nUIqtKFXdEPiE6oc1H39
	HnsDTNDQ+MIgNvjAdUTrDRYYnBhqnJlfM/xRQFRoGsz+cHOAy5c+VN8jDgObduU8VH6+8YfXW8Wq6
	jmfSbtPu53lYTjKEGVHgunWE8mM+XKucMZ1QlsCa1hwsf4/dwJF/ldf/SYxtqWVkHJz01GXb9Slkp
	GvKw3jzx7QBX6iX71rKnZxBjbjczVHHHtBSK2nZeUJP65x3KyGORvGaSfviv/bQBvaeXrTmtzhfJs
	a97f4Xnr0nW+ezsYtxTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghwwa-0007rj-P9; Fri, 11 Jan 2019 13:33:52 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghwuU-0005ql-3w
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 13:31:49 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 79BEC20BE8; Fri, 11 Jan 2019 14:31:37 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id 1508C20A2D;
 Fri, 11 Jan 2019 14:31:37 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v2 06/10] dt-bindings: phy: mvebu-utmi: add UTMI PHY bindings
Date: Fri, 11 Jan 2019 14:31:29 +0100
Message-Id: <20190111133133.24803-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111133133.24803-1-miquel.raynal@bootlin.com>
References: <20190111133133.24803-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_053143_547589_3EFAB03D 
X-CRM114-Status: GOOD (  14.91  )
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

Add bindings for Marvell Armada 3700 USB2 UTMI+ PHY.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/phy/phy-mvebu-utmi.txt           | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt b/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
new file mode 100644
index 000000000000..4ade05ce5d51
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
@@ -0,0 +1,37 @@
+MVEBU A3700 UTMI PHY
+--------------------
+
+USB2 UTMI+ PHY controllers can be found on the following Marvell MVEBU SoCs:
+* Armada 3700
+
+On Armada 3700, there are two USB controllers, one is compatible with the USB2
+and USB3 specifications and supports OTG. The other one is USB2 compliant and
+only supports host mode. Both of these controllers come with a UTMI PHY.
+
+Required Properties:
+
+- compatible: Should be one of:
+	      * "marvell,a3700-utmi-host-phy" for the PHY connected to
+	        the USB2 host-only controller.
+	      * "marvell,a3700-utmi-otg-phy" for the PHY connected to
+	        the USB3 and USB2 OTG capable controller.
+- reg: PHY IP register range.
+- marvell,usb-misc-reg: handle on the "USB miscellaneous registers" shared
+			region covering registers related to both the host
+			controller and the PHY.
+- #phy-cells: Standard property (Documentation: phy-bindings.txt) Should be 0.
+
+
+Example:
+
+	usb2_utmi_host_phy: phy@5f000 {
+		compatible = "marvell,armada-3700-utmi-host-phy";
+		reg = <0x5f000 0x800>;
+		marvell,usb-misc-reg = <&usb2_syscon>;
+		#phy-cells = <0>;
+	};
+
+	usb2_syscon: system-controller@5f800 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x5f800 0x800>;
+	};
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
