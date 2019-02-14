Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCB7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:34:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F46320675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lJaR2pH2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kXBtTe/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F46320675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rWVpvGf9Rr0uKz/g8L4GYUe/4ApuHIXrzogSgyPYgUw=; b=lJaR2pH23fu/Yk
	1Jtoa9YD6cLPu/TVLNJOJwrPfthvpFoMCjF2nmpnJR6qJtoJPXBxqMb2AUX+7f7Q46s6FTFCGylSe
	g4anODXIpy7Gdq2gTR6w4uKD0vIpQMIdYvDDzqSpEDWMCxW858y0fwSBz35wsHAQ0JavGSJGC8vfg
	v/7Mr0QPbucDFUWNWaUGjWCBgz/gbemegkr/U8NpJkHXHO3dYgWcPBdn2rTS0etxVoJ2Tx6pK+Hf8
	L/1fS7K+QAvFOiYdLCOXCecm6FzTC/1LuVTokqOs8aOwfyvn2+DCLBYXOfEJPjKOPhRQ19kQG1nSb
	UaZM5lvC2g0KPKi+Fncg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guMlk-0006tZ-NV; Thu, 14 Feb 2019 19:34:00 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guMkv-0005oE-2h
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:33:17 +0000
Received: by mail-pf1-x444.google.com with SMTP id n74so3584798pfi.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 11:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dmLB70XfR2J1D03CPPvqliqiD+PkiFMaZcieUMY43lg=;
 b=kXBtTe/clCxAbpE5dE4G/zYOQM5UWkCoZ8dYjMIC9oKZLt+EX4u/msuGADKWI4qMwe
 NAjFd0bR1BORcLV9cm3xRxZ6UVMVvCniFOFeDyrXkvCS/g/ghZJxIHWbiR5x65Mi8jbq
 Y12bxshHcvuqf8c5eLDHHik34DCAfHamojyo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dmLB70XfR2J1D03CPPvqliqiD+PkiFMaZcieUMY43lg=;
 b=W4rj57FQQtxAdx8Y+bAxjel+qqvUMaNN47g9Umsg7H7XQ/M8dDPKwbnIKT+ul/DO2s
 lzF7OcBUkbhhcHlhtfM1T+/RUHH+alNdMo7pva+z9I2XRCFiobYKN0f5z1qJEtWKphyj
 fLsW2a3X0dS+iHYDN3dqfghdjjaUM0HxnlArrmXRmzWtrLLHl4S5S7vQtMKn07UyEs3z
 6QJd/HkIk06pBH9j/KVtvnR9SLEGblgVyDiTnIoMFt932LOTjge4dL+6WqKAFIHV/AaK
 PbKCNonDVveKoMrxPNqXheZK26F8OEGhFWGtSh+KjVPMm88dXIK8BkLA/aKyVUdr135N
 /EEA==
X-Gm-Message-State: AHQUAuZF51g3z+um95N1a0p7UWLb+HgfhOWyzS7ZIuBwIzJOxXWI4YB8
 NOcVBRhU0uWv9JEdsBcIvgBo7w==
X-Google-Smtp-Source: AHgI3IbHhb1emtbzhHKeCm+L56KqhBW7mFSfErni09bP9cRLuonoxPPLn1mJD0iOb9MTS6ldkEZmzQ==
X-Received: by 2002:a63:e915:: with SMTP id i21mr1455445pgh.409.1550172788374; 
 Thu, 14 Feb 2019 11:33:08 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.33.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 11:33:07 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v8 05/10] drm/sun4i: sun6i_mipi_dsi: Simplify drq to support
 all modes
Date: Fri, 15 Feb 2019 01:02:32 +0530
Message-Id: <20190214193236.7504-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214193236.7504-1-jagan@amarulasolutions.com>
References: <20190214193236.7504-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_113309_662076_DC71353D 
X-CRM114-Status: GOOD (  14.80  )
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

Allwinner MIPI DSI drq has enable mode bit and set bits.
1) drq for non-burst, with front porch less than 20 would need to
   set both enable mode bit and set bits.
2) drq for non-burst, with front porch greater or equal to 20 would
   not require to do any drq bit setup.
3) drq for burst mode, would only need to set enable mode bit.

This patch simplifies existing drq code by grouping into
sun6i_dsi_get_drq and support all video modes.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 39 ++++++++++++++++----------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index a4360aed17bf..ab95e2a873b5 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -355,6 +355,28 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_INST_JUMP_CFG_NUM(1));
 };
 
+static int sun6i_dsi_get_drq(struct sun6i_dsi *dsi,
+			      struct drm_display_mode *mode)
+{
+	struct mipi_dsi_device *device = dsi->device;
+
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		return SUN6I_DSI_TCON_DRQ_ENABLE_MODE;
+
+	if ((mode->hsync_start - mode->hdisplay) > 20) {
+		/* Maaaaaagic */
+		u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
+
+		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
+		drq /= 32;
+
+		return (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
+			SUN6I_DSI_TCON_DRQ_SET(drq));
+	}
+
+	return 0;
+}
+
 static u16 sun6i_dsi_setup_inst_delay(struct sun6i_dsi *dsi,
 				      struct drm_display_mode *mode)
 {
@@ -399,21 +421,8 @@ static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 				  struct drm_display_mode *mode)
 {
-	struct mipi_dsi_device *device = dsi->device;
-	u32 val = 0;
-
-	if ((mode->hsync_start - mode->hdisplay) > 20) {
-		/* Maaaaaagic */
-		u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
-
-		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
-		drq /= 32;
-
-		val = (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
-		       SUN6I_DSI_TCON_DRQ_SET(drq));
-	}
-
-	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, val);
+	regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG,
+		     sun6i_dsi_get_drq(dsi, mode));
 }
 
 static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
