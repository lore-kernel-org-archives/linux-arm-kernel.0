Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBACC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:58:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B17220837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b0+Xj2Le"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B17220837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e9WIRYZ/Ry6ykhiYfyUcgRAwKI9YjM6b7Vl08ebfZic=; b=b0+Xj2Le/EnaCS
	xUFJF2ph7Rhz9mP8Jen0HE+5l51fpyxGzyyrb7WqbFlYBfV8nnmSukAV6H5YCF1k+dqXjnpl54qQU
	FOQmSTQQ26GUDfHphyEdg8ltXX1VVEwmZX5XFyp5GPJWcinJbShb6TUTyUXraFrD+BV9tx5ha7Fg0
	chj6BdCuy11rGcxaiku1cbHHkVnSA9xKcwRuDui7xgLVZg1nj8ruk6RVTKFIG5GgAAJmze/yPSIT/
	3ema91XNaaDZNCTdDxvzPveoqph5Nrsa0S2y60X5TUe8MJV7OeSDXAPVxzPuA3uOcbqMyzowC53yq
	jFmhCSB5uNaWYEclK0QA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGdy-0000kt-Mf; Fri, 07 Dec 2018 13:58:14 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGc5-0006rV-Tq
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 13:56:31 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 829B220E2E; Fri,  7 Dec 2018 14:56:02 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 6AF4120CEC;
 Fri,  7 Dec 2018 14:55:44 +0100 (CET)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v3 08/10] dt-bindings: phy: Move the Cadence D-PHY bindings
Date: Fri,  7 Dec 2018 14:55:35 +0100
Message-Id: <d548e7929e0efe73fe797202b98b7e554b4a4adc.1544190837.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.ad7c4feb3905658f10b022df4756a5ade280011f.1544190837.git-series.maxime.ripard@bootlin.com>
References: <cover.ad7c4feb3905658f10b022df4756a5ade280011f.1544190837.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_055619_211194_A5C24716 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: Archit Taneja <architt@codeaurora.org>, Rafal Ciepiela <rafalc@cadence.com>,
 Krzysztof Witos <kwitos@cadence.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>,
 Chen-Yu Tsai <wens@csie.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Cadence D-PHY bindings was defined as part of the DSI block so far.
However, since it's now going to be a separate driver, we need to move the
binding to a file of its own.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt | 21 +-------
 Documentation/devicetree/bindings/phy/cdns,dphy.txt           | 20 +++++++-
 2 files changed, 20 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt
index f5725bb6c61c..525a4bfd8634 100644
--- a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt
@@ -31,28 +31,7 @@ Required subnodes:
 - one subnode per DSI device connected on the DSI bus. Each DSI device should
   contain a reg property encoding its virtual channel.
 
-Cadence DPHY
-============
-
-Cadence DPHY block.
-
-Required properties:
-- compatible: should be set to "cdns,dphy".
-- reg: physical base address and length of the DPHY registers.
-- clocks: DPHY reference clocks.
-- clock-names: must contain "psm" and "pll_ref".
-- #phy-cells: must be set to 0.
-
-
 Example:
-	dphy0: dphy@fd0e0000{
-		compatible = "cdns,dphy";
-		reg = <0x0 0xfd0e0000 0x0 0x1000>;
-		clocks = <&psm_clk>, <&pll_ref_clk>;
-		clock-names = "psm", "pll_ref";
-		#phy-cells = <0>;
-	};
-
 	dsi0: dsi@fd0c0000 {
 		compatible = "cdns,dsi";
 		reg = <0x0 0xfd0c0000 0x0 0x1000>;
diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.txt b/Documentation/devicetree/bindings/phy/cdns,dphy.txt
new file mode 100644
index 000000000000..1095bc4e72d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/cdns,dphy.txt
@@ -0,0 +1,20 @@
+Cadence DPHY
+============
+
+Cadence DPHY block.
+
+Required properties:
+- compatible: should be set to "cdns,dphy".
+- reg: physical base address and length of the DPHY registers.
+- clocks: DPHY reference clocks.
+- clock-names: must contain "psm" and "pll_ref".
+- #phy-cells: must be set to 0.
+
+Example:
+	dphy0: dphy@fd0e0000{
+		compatible = "cdns,dphy";
+		reg = <0x0 0xfd0e0000 0x0 0x1000>;
+		clocks = <&psm_clk>, <&pll_ref_clk>;
+		clock-names = "psm", "pll_ref";
+		#phy-cells = <0>;
+	};
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
