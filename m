Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B15C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:41:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE54218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jv7Fbfor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE54218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kGr9duDt+9EExTFDtcs5piotCfDOSGgaAl7bGSiiAr8=; b=Jv7FbforHlrpIJ
	q9avCsJcbYL5AWUHo+UiENrhPjQqU2k2VNUitBwlJtFUwrZi5BPpLWVMrBHew3Y3TMvRshMKBeNmK
	sPfChQ/3EvuvNh1r7/ovYZdFv8SxpgHKroSLgI5F3xG5A32TKwtDiOBLXZ3zFUYzz6CV5aod1pTWV
	yv9rw5uvH/EQXtLXDe6EDyiWyde6vGAJ7S0utTvOcurM1LMqdn9UfWIYiAh3l/fKb3iWO9mXBDqef
	qFuz3b7CMVF9IHF9S2YA0g826ad4JtafjAfYNbI2KfZ7sjDarMYCdMm0EszXxfdCDTppRRUI9vvv2
	4xCxqRntcU+XAfvt/0PA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyvC-0006tA-To; Fri, 25 Jan 2019 10:41:14 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmytg-0004LQ-4L
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:39:41 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 3C765209BF; Fri, 25 Jan 2019 11:39:38 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id C3657209EF;
 Fri, 25 Jan 2019 11:39:27 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v4 06/10] dt-bindings: phy: mvebu-utmi: add UTMI PHY bindings
Date: Fri, 25 Jan 2019 11:39:20 +0100
Message-Id: <20190125103925.15753-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125103925.15753-1-miquel.raynal@bootlin.com>
References: <20190125103925.15753-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_023940_322324_8D11A33E 
X-CRM114-Status: GOOD (  14.42  )
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/phy-mvebu-utmi.txt           | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt b/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
new file mode 100644
index 000000000000..aa99ceec73b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
@@ -0,0 +1,38 @@
+MVEBU A3700 UTMI PHY
+--------------------
+
+USB2 UTMI+ PHY controllers can be found on the following Marvell MVEBU SoCs:
+* Armada 3700
+
+On Armada 3700, there are two USB controllers, one is compatible with the USB2
+and USB3 specifications and supports OTG. The other one is USB2 compliant and
+only supports host mode. Both of these controllers come with a slightly
+different UTMI PHY.
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
+		compatible = "marvell,armada-3700-usb2-host-misc", "syscon";
+		reg = <0x5f800 0x800>;
+	};
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
