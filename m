Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D57C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:57:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FD9217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d8rmGR9x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRa47VnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FD9217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d6UMrrd0dyqe7V862CTUAuU41sGColVs+aBGJBaJEJA=; b=d8rmGR9xpjyO3h
	wCVoMONDI9CL1zVDphK2/CgXy2sVC92CbVZYyhLqHnE0C4/j2INwige7Z14VMfCdu7Gg21OPWBXlC
	hc4jcvDgZBGecHQYpMjScRixl21YC614C4AsK2OesMwSiAQL5fXNe6FHhra0UzY75/M7mWgf8D9gZ
	+mdfYRcAb5JWTKlTzhLwytczw6yWV+pnjHemWvxbtwQr6DjNdb0RHbAOb0W9bkLDzDpt7YJk1JFYs
	27KQ+eSFO1qDxXqow5Fi3iwMVgUmm0PvUY5P+gpjDpScQJqGq8hUmGDtvqEn/uhypnUtedCuSC7gM
	4Q60yxu4GEjxqnbMo75g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqMxO-00070M-DW; Sun, 03 Feb 2019 18:57:30 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqMvc-0005Cl-Sq
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 18:55:54 +0000
Received: by mail-pl1-x642.google.com with SMTP id w4so5762241plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 10:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3boBwPz84wKOTuMSt6x2S3V4gv4HON5vQaFKv3xMX4s=;
 b=VRa47VnXRlbni7LIoQLfQ7w/R0O32ecl9wN3l2TgHLPDkoyEVoyelD23n8z0y2UPvB
 2bFz7c8ii36Z8DHKyhTh2fFL9DGzzyWViEq4+zbnlCcvsQsgNa/x4gGZqgZB0aE0Vmt9
 3jyECZNCJ1kC1pnrlB3PSLhuHq+IwS3Doo0eEyUPU8eRxk84hCeElirLgbYKSWQ+PCBz
 d4Vks9yH5ZWg9IXXemvF3swQ04aHFqIpRvXTUcCyTY+rp2C31dYF4CFk79Xxg8LRV7x1
 vv5AV4j5FkgdcTelZ6RJpmz1I0sZEn+uwZLRSDMJrx/5i5/VgpLSV5Iua+nn7/qBoGvD
 fMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3boBwPz84wKOTuMSt6x2S3V4gv4HON5vQaFKv3xMX4s=;
 b=H01y+0M3qmMsjzShTxzTn0GVfw7kIIMfm5M4PmnDzA9Eph/q0R+sUi78cmj1BFWpLy
 8BzuJ2Z6JQwXqTlgVnH75M/jqlIV+i2M080AtmVjgagaTnmThKLWpkzOQ1MxxSwL2VSL
 uwMKbKE/07Of+4aHUCHhHMA4a3kGPXW4eti16k8KR9ft6HI6j9jJZSlvJumY07KZ0nVa
 Gt0lnlRXs7JYLOqBYrKxzq8a4pjHWJDWzdgt/vnPlUrucl0ROZqWAWFCPLJsx4Dx2C7l
 FhYsHGZfTuKwBxAoTP9UoFJf8yoS43hwfoYD63sHtkqkFSGZIOTDJrPFAzo+bxcyQAis
 9ynQ==
X-Gm-Message-State: AJcUukf0oTQ0T/ff9RmySXVTP2q5TqLfz/Cz9virtaRpJ2Eg3QO4xK5x
 H+luNjS+V/gTy6MAAzgvatM=
X-Google-Smtp-Source: ALg8bN7pGdVJacaLeRgswxYNzmK9dFHp9AowmcotFeiJcV7PrMeQ1R8AubNvAkhu5B3Xy6MEow+sTw==
X-Received: by 2002:a17:902:8a95:: with SMTP id
 p21mr49734150plo.183.1549220140249; 
 Sun, 03 Feb 2019 10:55:40 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id g28sm19524553pfd.100.2019.02.03.10.55.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Feb 2019 10:55:39 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Archit Taneja <architt@codeaurora.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Icenowy Zheng <icenowy@aosc.io>, Sean Paul <seanpaul@chromium.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: [PATCH RESEND v2 06/12] drm/sun4i: rgb: Add 1% tolerance to dclk
 frequency check when bridge is connected
Date: Sun,  3 Feb 2019 10:54:55 -0800
Message-Id: <20190203185501.8958-7-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203185501.8958-1-anarsoul@gmail.com>
References: <20190203185501.8958-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_105541_415939_2E0E5A91 
X-CRM114-Status: GOOD (  16.57  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Clock rate check that was added in commit bb43d40d7c83 ("drm/sun4i: rgb:
Validate the clock rate") prevents some panel and bridges from working with
sun4i driver.

Unfortunately, dotclock frequency for some modes are not achievable on
sunxi hardware, and there's a slight deviation in rate returned by
clk_round_rate(), so they fail this check.

Experiments show that panels and bridges work fine with this slight
deviation, e.g. Pinebook that uses ANX6345 bridge with 768p eDP panel
requests 73 MHz, gets 72.296MHz instead (0.96% difference) and works just
fine.

This patch adds a 1% tolerence to the dot clock check when bridge is
connected.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 16 ++++++++++------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index f4a22689eb54..3f04446120f6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -61,6 +61,7 @@ static enum drm_mode_status sun4i_rgb_mode_valid(struct drm_encoder *crtc,
 	u32 vsync = mode->vsync_end - mode->vsync_start;
 	unsigned long rate = mode->clock * 1000;
 	long rounded_rate;
+	long tolerance = 0;
 
 	DRM_DEBUG_DRIVER("Validating modes...\n");
 
@@ -95,10 +96,14 @@ static enum drm_mode_status sun4i_rgb_mode_valid(struct drm_encoder *crtc,
 	tcon->dclk_min_div = 6;
 	tcon->dclk_max_div = 127;
 	rounded_rate = clk_round_rate(tcon->dclk, rate);
-	if (rounded_rate < rate)
+	if (tcon->bridge)
+		/* Check against a 1% tolerance for the dot clock for bridge */
+		tolerance = rate / 100;
+
+	if (rounded_rate < (rate - tolerance))
 		return MODE_CLOCK_LOW;
 
-	if (rounded_rate > rate)
+	if (rounded_rate > (rate + tolerance))
 		return MODE_CLOCK_HIGH;
 
 	DRM_DEBUG_DRIVER("Clock rate OK\n");
@@ -172,7 +177,6 @@ static struct drm_encoder_funcs sun4i_rgb_enc_funcs = {
 int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 {
 	struct drm_encoder *encoder;
-	struct drm_bridge *bridge;
 	struct sun4i_rgb *rgb;
 	int ret;
 
@@ -183,7 +187,7 @@ int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 	encoder = &rgb->encoder;
 
 	ret = drm_of_find_panel_or_bridge(tcon->dev->of_node, 1, 0,
-					  &tcon->panel, &bridge);
+					  &tcon->panel, &tcon->bridge);
 	if (ret) {
 		dev_info(drm->dev, "No panel or bridge found... RGB output disabled\n");
 		return 0;
@@ -225,8 +229,8 @@ int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 		}
 	}
 
-	if (bridge) {
-		ret = drm_bridge_attach(encoder, bridge, NULL);
+	if (tcon->bridge) {
+		ret = drm_bridge_attach(encoder, tcon->bridge, NULL);
 		if (ret) {
 			dev_err(drm->dev, "Couldn't attach our bridge\n");
 			goto err_cleanup_connector;
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index b5214d71610f..487cb070b25c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -258,6 +258,7 @@ struct sun4i_tcon {
 	struct reset_control		*lvds_rst;
 
 	struct drm_panel		*panel;
+	struct drm_bridge		*bridge;
 
 	/* Platform adjustments */
 	const struct sun4i_tcon_quirks	*quirks;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
