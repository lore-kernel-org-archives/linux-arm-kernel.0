Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759FFC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:02:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F2B21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IJA1zfAG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jtO8WY2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F2B21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TMkvAk5ClGbClFnjL4aat/XzIOEbaQsGk9HNPYhbfmc=; b=IJA1zfAG/avnR2
	7w4WC4q70qwFBTztcKAP0WVP9E1d0EtyD49+d3UQJGNmQbogZnbr7zA0AjkJAg4o/Zv18UthNLWEb
	c9Q/TunQaVuJU8AY7Cz/uOQBw2zl7VeqvX+irkI6ZGoBdvaniSBolju+R1FDusfzzligM63dlyZf6
	OO1SUh2xRQbbWmlH14pFWzczjg2ml2sT+8egtjCplwWjv0ytTPwIhGFQeLmgWG89BIf6CxbOWxeET
	VZtkZK90prI7D6AfnDtEfw9iahxNzjhI6o75zzI/wI0FshMK8VH7z39a4h+n6appRumEc1/fpXLSc
	9rua83HOgX5ZHZPt1gIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlCF-0002AQ-8m; Thu, 24 Jan 2019 20:01:55 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlAL-0007cV-OL
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:00:32 +0000
Received: by mail-pf1-x444.google.com with SMTP id 64so3517495pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 11:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7/5Hsb2tbnBgyCik73JZ6QB0i9gQuu71ae0+ehEd1ME=;
 b=jtO8WY2z3Lecc100gdCc1MjGm53aU8DFsVHeQYUvKXnySWSqb5s0Gp9LOcim3SAoHf
 ZE+s8o+Byku0VqAXuYGzGDOKYXKnSqMqHSHXEdSntgXar5jlmfVDkXmeCd+jan4IYMJf
 Ru84/jOM1Rmqda/exVPryGA9U2Vgl29QOvFqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7/5Hsb2tbnBgyCik73JZ6QB0i9gQuu71ae0+ehEd1ME=;
 b=op7St3Spe7C+xZEY4F0NJV4aMu+X8+MSSZc3K9SEFZ4vSlyzgV0GKsQbvouMexfdDx
 hSatsDlvBPI82Ot06NHJkIjynhM9Ar4kTBZlC6OVruVkA0DzKHulYwLT4BaGUcQz6g52
 IeKVk5idyd+kaARGuWVOea06T6S9ZvCFtGfSqVPl+/uuGR5Gu9MWf95Js2p71gx2K3f3
 arVqjFixEQsK8HhR2parZyuANx7OpnufgJeKomV7avu95D0NtOwwMU5sldAKOoBxxUO4
 XQyRkheuJNKCR6UQssnmvfc0nYMfDhXQALgIQBlsh6yK+8ACYSeWOv5cpKBbG7QBYI7h
 tufg==
X-Gm-Message-State: AJcUukcUo7mYwNJ2FIvJC726FLCDZtSLNRfXe2LdwCtQeERhJR84xJsb
 M4Uqa6/3lXjwaoPHfR9mCzDimw==
X-Google-Smtp-Source: ALg8bN5o7CYIiKf5z4azOZLOeZhtdah5LCB/znjdbsgm7Z2kWLJE4drlNh/UxmtsRjD80IVJGMeM3g==
X-Received: by 2002:a62:60c5:: with SMTP id u188mr7930583pfb.4.1548359997052; 
 Thu, 24 Jan 2019 11:59:57 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.11.59.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 11:59:56 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 07/22] drm/sun4i: sun6i_mipi_dsi: Setup burst mode
Date: Fri, 25 Jan 2019 01:28:45 +0530
Message-Id: <20190124195900.22620-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_115958_566339_8BA7D755 
X-CRM114-Status: GOOD (  14.81  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Setting up burst mode display would require to compute
- Horizontal timing edge values to fill burst drq register
- Line, sync values to fill burst line register

Since there is no direct documentation for these computations
the edge and line formulas are taken from BSP code (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

line_num = panel->lcd_ht*dsi_pixel_bits[panel->lcd_dsi_format]/
	  (8*panel->lcd_dsi_lane);
edge1 = sync_point+(panel->lcd_x+panel->lcd_hbp+20)*
	dsi_pixel_bits[panel->lcd_dsi_format] /(8*panel->lcd_dsi_lane);
edge1 = (edge1>line_num)?line_num:edge1;
edge0 = edge1+(panel->lcd_x+40)*tcon_div/8;
edge0 = (edge0>line_num)?(edge0-line_num):1;

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 70 ++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 2aeaa19a8d1e..46ad142e66e8 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -355,6 +355,41 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_INST_JUMP_CFG_NUM(1));
 };
 
+static u32 sun6i_dsi_get_edge1(struct sun6i_dsi *dsi,
+			       struct drm_display_mode *mode, u32 sync_point)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	unsigned int bpp = mipi_dsi_pixel_format_to_bpp(device->format);
+	u32 hact_sync_bp;
+
+	/* Horizontal timings duration excluding front porch */
+	hact_sync_bp = (mode->hdisplay + mode->htotal - mode->hsync_start);
+
+	return (sync_point + ((hact_sync_bp + 20) * bpp / (8 * device->lanes)));
+}
+
+static u32 sun6i_dsi_get_edge0(struct sun6i_dsi *dsi,
+			       struct drm_display_mode *mode, u32 edge1)
+{
+	struct sun4i_tcon *tcon = dsi->tcon;
+	unsigned long dclk_rate, dclk_parent_rate, tcon0_div;
+
+	dclk_rate = clk_get_rate(tcon->dclk);
+	dclk_parent_rate = clk_get_rate(clk_get_parent(tcon->dclk));
+	tcon0_div = dclk_parent_rate / dclk_rate;
+
+	return (edge1 + (mode->hdisplay + 40) * tcon0_div / 8);
+}
+
+static u32 sun6i_dsi_get_line_num(struct sun6i_dsi *dsi,
+				  struct drm_display_mode *mode)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	unsigned int bpp = mipi_dsi_pixel_format_to_bpp(device->format);
+
+	return (mode->htotal * bpp / (8 * device->lanes));
+}
+
 static int sun6i_dsi_get_drq(struct sun6i_dsi *dsi,
 			      struct drm_display_mode *mode)
 {
@@ -404,8 +439,32 @@ static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 				  struct drm_display_mode *mode)
 {
-	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG,
-		     sun6i_dsi_get_drq(dsi, mode));
+	struct mipi_dsi_device *device = dsi->device;
+	u32 sync_point = 40;
+	u32 line_num = sun6i_dsi_get_line_num(dsi, mode);
+	u32 edge1 = sun6i_dsi_get_edge1(dsi, mode, sync_point);
+	u32 edge0 = sun6i_dsi_get_edge0(dsi, mode, edge1);
+	u32 val;
+
+	if (edge1 > line_num)
+		edge1 = line_num;
+
+	if (edge0 > line_num)
+		edge0 -= line_num;
+	else
+		edge0 = 1;
+
+	regmap_write(dsi->regs, SUN6I_DSI_BURST_DRQ_REG,
+		     SUN6I_DSI_BURST_DRQ_EDGE1(edge1) |
+		     SUN6I_DSI_BURST_DRQ_EDGE0(edge0));
+	regmap_write(dsi->regs, SUN6I_DSI_BURST_LINE_REG,
+		     SUN6I_DSI_BURST_LINE_NUM(line_num) |
+		     SUN6I_DSI_BURST_LINE_SYNC_POINT(sync_point));
+
+	/* enable burst mode */
+	regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
+	val |= SUN6I_DSI_BASIC_CTL_VIDEO_BURST;
+	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 }
 
 static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
@@ -667,7 +726,12 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
 		     SUN6I_DSI_BASIC_CTL1_VIDEO_PRECISION |
 		     SUN6I_DSI_BASIC_CTL1_VIDEO_MODE);
 
-	sun6i_dsi_setup_burst(dsi, mode);
+	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG,
+		     sun6i_dsi_get_drq(dsi, mode));
+
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		sun6i_dsi_setup_burst(dsi, mode);
+
 	sun6i_dsi_setup_inst_loop(dsi, mode);
 	sun6i_dsi_setup_format(dsi, mode);
 	sun6i_dsi_setup_timings(dsi, mode);
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
