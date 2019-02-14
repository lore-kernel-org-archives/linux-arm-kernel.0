Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB8CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:37:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B5721B1C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A/3z1xki";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ug/rn53s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B5721B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HQVpoDn/zdlcTmriFwQe0kk0siHrYn97dhEsSNqtLt4=; b=A/3z1xkizmWJXn
	z9RahAqSEML7fX3gu0BjublfR6+3mr0Kgy1nWrALTn1+wd+BKWF0u+Jz9g233qpAl3G00+5+xO/Th
	y+050Hx0SdbTJy1mrTeasLkbpGTVUeTGW/f0uAS7AFWr0N9PAjsZwoQt+97u4Q9EVWXhjDK+HPbPS
	9fkAF6Bi8YbaJ3ZnVbNau8fTCaGu63REEutAFCbabRsE5DpJviNhsRa8wW8+NBo3m2Y+nSgixRjRq
	dzx273yOtbjUbCG+4KlE6AVenMkw+Mz7kh9dINOts/TYf3Rqivz1cUl5t18Oe9QU+sq+fHU5P933C
	U/13mTAXVXH06IuBUceA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guMp0-0001Y7-Ru; Thu, 14 Feb 2019 19:37:22 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guMl5-00063U-IZ
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:33:40 +0000
Received: by mail-pg1-x541.google.com with SMTP id i130so3573082pgd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 11:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WDmxxzjCCLiFJpoIHfbvmHM+WtyBWfZzHa7paSm6QGI=;
 b=Ug/rn53seStgQKetu4l86Pn/tP9IzrtjSHXmCu80yJ1G1X6MyRj2q1Z97To2fADWUb
 UMU6Ys1oMlbxj29Ym154Q5OFolUXgLX/bDGyMWfZyy+TnugXqjjo3m0znsESaDeJAl3F
 SD4751gvEryqZ6Ld7JGzgHZmV6xBRjnwPCOzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WDmxxzjCCLiFJpoIHfbvmHM+WtyBWfZzHa7paSm6QGI=;
 b=SFkJbty0NsQoBKleL9YPfN2//+Nn2YOCQS1AHoKR/xgv1TpEp5owtaokMjAJXH+E2l
 xe7lRCkx2VVTbmx5jccDg4xt+Btb5TF129tyU1ZJ535bST2Vc3YdqLp0tjSmXgPRRbEj
 ps2cNI6nkWH3KACfHeuPiy8cnUpVx7UR4FfPOyVNP0xk5lnlo/Tn7uJuLbm4A/iP3BzY
 b2ACQYDNYPDJ2QSOsojqn4mEKu48QL/ouoYObnMGtr4bKV98G+zeBK+SzbvcKz2dX79O
 L5DvHmFYSpZe6T1Tbkv6/viUn1fVuproZupeW/Y+y/MmhVjz0LgpYfe2g9gb0caxD0TQ
 EiKw==
X-Gm-Message-State: AHQUAuZo69S9wvZbcUmTKnTD+9yfCoh9pTOPEefOkbQurF2cjY5bBdBK
 vcMoqf6PhcCdMhs0QtS1pTS3rA==
X-Google-Smtp-Source: AHgI3IY4y1me3baq2nOd8mvboYHGJlofzAkb/9sc4TzbmT1NCoVHXusfBNijz/AatZ4iaxqzKpXmEA==
X-Received: by 2002:a63:1105:: with SMTP id g5mr5356652pgl.322.1550172798908; 
 Thu, 14 Feb 2019 11:33:18 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.33.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 11:33:18 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v8 08/10] drm/sun4i: sun6i_mipi_dsi: Setup burst mode
Date: Fri, 15 Feb 2019 01:02:35 +0530
Message-Id: <20190214193236.7504-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214193236.7504-1-jagan@amarulasolutions.com>
References: <20190214193236.7504-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_113320_029831_B296CE51 
X-CRM114-Status: GOOD (  15.00  )
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
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Burst mode in DSI would require separate setup initialization
with respect to conventional video mode.

Allwinner DSI controller would need below sequence to setup the
burst mode.
1) configure the burst drq.
2) configure the burst line.
3) finally enable mode.

- To configure burst drq, controller would require to compute the
  edge0, edge1 and fill into burst mode register.

- To configure burst line, controller would require to compute the
  line, sync values and fill into burst line register.

- Enable burst mode, would require to enable burst mode bit in DSI
  control register.

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

Note: edge0 computation would require tcon0 divider and it's value is
always 4 in Allwinner BSP. This patch find out the divider value at
runtime by reading tcon clocks.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 70 ++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 62b4c822bf18..63b83b47cf0d 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -356,6 +356,41 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
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
@@ -422,8 +457,32 @@ static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
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
@@ -708,7 +767,12 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
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
