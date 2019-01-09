Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2B6C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:33:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43425214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i0IQOiY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43425214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9/7vkY7LmuKezPsW0Esp/E/V0cABctbU4lIkVVueif8=; b=i0IQOiY17II5u+
	t/vYpzBZZ8g3WT/cgQ4HwshF9WcWgJaoNw/04K7iHGD/bC0e8vxiBG3sAFGLjN1CogeUIBRvaH47M
	T4BCr82Gq6aqKaz3NAh0KIXuTAknvHv/L7c1FpQHv8irr8Iq/qV6JzgQlwmTL18CjvlClJYerZ3SI
	LFvX5xzTbuNB1BCzILdX7Ewq4SlVjrSSLib3cQ/qle1vO2Yn+jQ6HWOCfxHx9LFDMnc/YjnVZzfB6
	KjDeXxRo1gvsrBzv8KWT75wqdXkv3t3jdk9FRRZPeY6l7lTt5+l16M0945F+5kWQtq4x1GhSfA1nh
	vJukS2iGyfUmd8Ktg04Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghAFG-0006bO-LF; Wed, 09 Jan 2019 09:33:54 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghAF4-0006Qp-Fg
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 09:33:44 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 19FD6209C2; Wed,  9 Jan 2019 10:33:40 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr
 [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id D0EA0209EF;
 Wed,  9 Jan 2019 10:33:29 +0100 (CET)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 2/9] phy: dphy: Change units of wakeup and init parameters
Date: Wed,  9 Jan 2019 10:33:19 +0100
Message-Id: <fdbd45434e4325b6808be802c9f30700ac4f9a16.1547026369.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.5d91ef683e3f432342f536e0f2fe239dbcebcb3e.1547026369.git-series.maxime.ripard@bootlin.com>
References: <cover.5d91ef683e3f432342f536e0f2fe239dbcebcb3e.1547026369.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_013342_793526_4D0FBD42 
X-CRM114-Status: GOOD (  11.06  )
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
 Chen-Yu Tsai <wens@csie.org>, Sakari Ailus <sakari.ailus@iki.fi>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Init and wakeup D-PHY parameters are in the micro/milliseconds range,
putting the values real close to the types limits if they were in
picoseconds.

Move them to microseconds which should be better fit.

Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/phy/phy-core-mipi-dphy.c  | 8 ++++----
 include/linux/phy/phy-mipi-dphy.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/phy-core-mipi-dphy.c b/drivers/phy/phy-core-mipi-dphy.c
index 465fa1b91a5f..14e0551cd319 100644
--- a/drivers/phy/phy-core-mipi-dphy.c
+++ b/drivers/phy/phy-core-mipi-dphy.c
@@ -65,12 +65,12 @@ int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
 	 */
 	cfg->hs_trail = max(4 * 8 * ui, 60000 + 4 * 4 * ui);
 
-	cfg->init = 100000000;
+	cfg->init = 100;
 	cfg->lpx = 60000;
 	cfg->ta_get = 5 * cfg->lpx;
 	cfg->ta_go = 4 * cfg->lpx;
 	cfg->ta_sure = 2 * cfg->lpx;
-	cfg->wakeup = 1000000000;
+	cfg->wakeup = 1000;
 
 	cfg->hs_clk_rate = hs_clk_rate;
 	cfg->lanes = lanes;
@@ -143,7 +143,7 @@ int phy_mipi_dphy_config_validate(struct phy_configure_opts_mipi_dphy *cfg)
 	if (cfg->hs_trail < max(8 * ui, 60000 + 4 * ui))
 		return -EINVAL;
 
-	if (cfg->init < 100000000)
+	if (cfg->init < 100)
 		return -EINVAL;
 
 	if (cfg->lpx < 50000)
@@ -158,7 +158,7 @@ int phy_mipi_dphy_config_validate(struct phy_configure_opts_mipi_dphy *cfg)
 	if (cfg->ta_sure < cfg->lpx || cfg->ta_sure > (2 * cfg->lpx))
 		return -EINVAL;
 
-	if (cfg->wakeup < 1000000000)
+	if (cfg->wakeup < 1000)
 		return -EINVAL;
 
 	return 0;
diff --git a/include/linux/phy/phy-mipi-dphy.h b/include/linux/phy/phy-mipi-dphy.h
index 9cf97cd1d303..627d28080d3a 100644
--- a/include/linux/phy/phy-mipi-dphy.h
+++ b/include/linux/phy/phy-mipi-dphy.h
@@ -190,10 +190,10 @@ struct phy_configure_opts_mipi_dphy {
 	/**
 	 * @init:
 	 *
-	 * Time, in picoseconds for the initialization period to
+	 * Time, in microseconds for the initialization period to
 	 * complete.
 	 *
-	 * Minimum value: 100000000 ps
+	 * Minimum value: 100 us
 	 */
 	unsigned int		init;
 
@@ -244,11 +244,11 @@ struct phy_configure_opts_mipi_dphy {
 	/**
 	 * @wakeup:
 	 *
-	 * Time, in picoseconds, that a transmitter drives a Mark-1
+	 * Time, in microseconds, that a transmitter drives a Mark-1
 	 * state prior to a Stop state in order to initiate an exit
 	 * from ULPS.
 	 *
-	 * Minimum value: 1000000000 ps
+	 * Minimum value: 1000 us
 	 */
 	unsigned int		wakeup;
 
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
