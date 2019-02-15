Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB8EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:22:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD2621B1C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DOyTI1go";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9zxOUs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD2621B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Ld8llFmimyXl6LDyGPIToWm1+wUaomj6FaAOfLjniI=; b=DOyTI1gouDIhtw
	uGDdcsHqJiOBTmZvBfOqgJ377u/yKfURTeXHX2/qA5FZ3GDk5GIJtmsufc+psUC28bYoG4hFDm3WX
	0ieL4AIdjO9zLC2H0O9Aha3c5OFWwILlVp+lq2BJ+VtFLXu2/BRgZnPNP3Jgy7Dsm7nR1azJSZBp9
	5xok1JcJFvloFaY0MEMzlqpwzMDp4B5oSYBIufHNZCTwINHA7PbdGlk7c82XtgC5XULS3KiUEUVP6
	KO/hc5EjtD2/wg5vM93KnhOLEI9UhKVolRIO6EJlm8dtpqAqXatFJJmSgRB79iR4Ze+ewLraGAGbx
	gLmmH27iyqoXSAVbwxvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guVxC-0000b8-8j; Fri, 15 Feb 2019 05:22:26 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guVld-0003ZK-HU
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 05:10:36 +0000
Received: by mail-pg1-x543.google.com with SMTP id h11so1865869pgl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 21:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1x7jSjNuOcqa7ELWz+osBF2DU9XbsTzajqJhiKYtai4=;
 b=X9zxOUs73Ork+6lEicbg0/nmY9WaidSQ2Mw07uOa+DjZPI41URBA+jrIAYC+fGzXQW
 fQTMZ8X1Mlj6COlYJiZLeNTvLc62ifeQ9oxLhFDtjinGylI8xMI1HKi9uxRZc7zzrnuh
 8qDADLG6CgIWqc/ItWC3mKPtsMWyb8JY5xsnXP2o97pqFzRhrBdwkAlLuMpuoBPdOXyr
 WB7hidzlL6p9/e3yqxhGox5Q5q7EScyk5Th1bpN85bGw+cC5e/Qb/g6q3Qoeg4Ursu+Z
 uUHnyvPqYrQHtj7GCTZ+lZM+2XnGKWQ9+nR6WHt/8ayZwkKebjL2djOO+JS1hEOhD9zs
 z3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1x7jSjNuOcqa7ELWz+osBF2DU9XbsTzajqJhiKYtai4=;
 b=e3jXJB98rZnBe0LGCFpgqyBulTlq3fMCcpIvH+jBNCKRxfGuy1KS4qn6jJuBGU5a2Y
 rrr+6rPOd4u08d3fVLNq2XqbIDOrsshebebya58JARpZXMoohDpPmhgaYBs4pMDZpDl+
 WYVBuPVmNVcw7Xy9eQ5HP2DHgKOqgm+ot2VWmlFiNyBineTg5V8CStij/A/qxbo0alXf
 qs+VHegls7/Eyey1XAN7PFeNzhGU7E145p9jVoPt1jsifB8xfth91adC2h8V9d1q0S7g
 tHQl+NOwQJAOHVWpcimUXUfSKBltAhJIAT3r+Pxuw8dx19zG3ylvAFVEFYDQOXgayJCd
 QqYQ==
X-Gm-Message-State: AHQUAuaGyhnm65ZrKjXCe2kfJgy7jOLUJgkhMEspt6OjXV1qDbClqtPc
 pi1R2P5XpMZd5yseVPTY93A=
X-Google-Smtp-Source: AHgI3IZv1qI2L0UQZeeRuPafi5VstAfM3R54ImAq8UBPipjgBAEuJilRDTMRd6Zv2eJpZstjeZNfhg==
X-Received: by 2002:a62:be0b:: with SMTP id l11mr8183471pff.52.1550207428676; 
 Thu, 14 Feb 2019 21:10:28 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id m9sm4900442pgr.7.2019.02.14.21.10.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 21:10:28 -0800 (PST)
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
Subject: [PATCH v3 06/11] drm/sun4i: rgb: Add DT property to disable strict
 clock rate check
Date: Thu, 14 Feb 2019 21:09:52 -0800
Message-Id: <20190215050957.20755-7-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215050957.20755-1-anarsoul@gmail.com>
References: <20190215050957.20755-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_211030_260953_8DB01B00 
X-CRM114-Status: GOOD (  14.70  )
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

This patch adds DT property to disable strict clock rate check

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 2 ++
 drivers/gpu/drm/sun4i/sun4i_rgb.c                            | 5 +++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c                           | 3 +++
 drivers/gpu/drm/sun4i/sun4i_tcon.h                           | 1 +
 4 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index f426bdb42f18..18c8b053a28d 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -63,6 +63,8 @@ Required properties:
     Documentation/devicetree/bindings/media/video-interfaces.txt. The
     first port should be the input endpoint. The second should be the
     output, usually to an HDMI connector.
+  - no-strict-clock-check: don't reject timings if exact dot clock can't be
+    reached.
 
 DWC HDMI TX Encoder
 -------------------
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index f4a22689eb54..b392d4b1ebd3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -94,7 +94,12 @@ static enum drm_mode_status sun4i_rgb_mode_valid(struct drm_encoder *crtc,
 
 	tcon->dclk_min_div = 6;
 	tcon->dclk_max_div = 127;
+
+	if (tcon->no_strict_clock_check)
+		return MODE_OK;
+
 	rounded_rate = clk_round_rate(tcon->dclk, rate);
+
 	if (rounded_rate < rate)
 		return MODE_CLOCK_LOW;
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index cf45d0f940f9..f5f7f479332b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1108,6 +1108,9 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	tcon->id = engine->id;
 	tcon->quirks = of_device_get_match_data(dev);
 
+	tcon->no_strict_clock_check = of_property_read_bool(dev->of_node,
+						"no-strict-clock-check");
+
 	tcon->lcd_rst = devm_reset_control_get(dev, "lcd");
 	if (IS_ERR(tcon->lcd_rst)) {
 		dev_err(dev, "Couldn't get our reset line\n");
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index b5214d71610f..ab510b80004a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -258,6 +258,7 @@ struct sun4i_tcon {
 	struct reset_control		*lvds_rst;
 
 	struct drm_panel		*panel;
+	bool				no_strict_clock_check;
 
 	/* Platform adjustments */
 	const struct sun4i_tcon_quirks	*quirks;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
