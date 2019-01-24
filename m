Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D44C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:01:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2845521726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aFmMaaP4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Mr+1LHQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2845521726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1t6H0nEZ44quxwd+p5SEQAm9PgPxY1VejlQ32ZqI6v0=; b=aFmMaaP4CJT37l
	1Xa9b0KY2MWMLZkLB7EGmgbp8ssgBIq6oqXPYnupABPt5IlMfwz7U8Wytazi4nhb3OHKaCaiAWjPA
	zMowMOeHidweGf1/1rW9nf7QXohqI/orj52uG65lV94IwFXkN+E+GAD3Cj+61K4bmdTnS8PjMwfGu
	jTFS8/kKurIR6mUn1RCr5ESKnaib6xhFVgiW7UnjZTnxRwXRvN9H8go1+N2R07R4sEJ8m2z63si93
	SqHbGHR6tIdnD0yUOxQr6oGwSIwtr6sryXtA3fVQdjCJ+TEGP7sVJgf+EYISGdwJYge87oWtxBQw2
	hNE+5ksijpP659GBx9Aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlBI-0001AA-Vi; Thu, 24 Jan 2019 20:00:56 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlA4-0007Ia-Mk
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 19:59:49 +0000
Received: by mail-pf1-x444.google.com with SMTP id y126so3529705pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 11:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=anHsrjMbLEFT68kAkE2t/9/N/A+LioJPwdjsAaUWV6M=;
 b=Mr+1LHQbGiGFa9RRSZEvmtvsm2fe15PzViT5Ls9dOEOJBDRMewkDbH+rFr+ohoXcRW
 yuQgBYFuy7z0M6CXzdfYUqwUxIE0QEikvpvuRXGf/52K1ghAEpq9fnWC7JDdBTmAh0sB
 nnud8zcmJgemxCqCzVmw7LD/rm+zBvoWVSZ9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=anHsrjMbLEFT68kAkE2t/9/N/A+LioJPwdjsAaUWV6M=;
 b=UOE53mQ405szrQqmzad+v1Emye13WYwQpHINKtfWhNs3Y6cxQ/893TyWdRdbn4CWO2
 d/Thdv0TR8h+UfNePpm1qAaH28nxI1MpC+jGUaTCGT9JVf7DMVx3BaIxAQWhZ5O+tQIm
 Bn5x6sfjePYDCmT4FseOOmT5ZiEmfySpHtMxdUzrrtZ6yNO0CBfRcOHfjvXhVQM1y0jt
 OiAJngs29Rg4rNdVrgfc3sGgSGS9n0rI2tJxKnecbRerG7s85zVAxgZITQsLRRbgyyCQ
 LFAdQxIJJuBKuZnWWC5iQ2pd30sLr87UDkAHN5XnLDz+3GLKL8PQLrbUMxKUO4Hv3gMz
 VDpA==
X-Gm-Message-State: AJcUukfo124zBQyUIYI6tKaUfwDoKTRLX8by8TYr36mALYmvyscmJDDb
 5GgvCnluMDgy8k+idl7HG11OCg==
X-Google-Smtp-Source: ALg8bN4mq0xPurqMf/0RAVMft7fSNwSdm3nfmoE8i/Vp1Tl0U0YR5qs/NZVNeCxU/34qzXtNSfQMYQ==
X-Received: by 2002:a63:2109:: with SMTP id h9mr7134428pgh.277.1548359979766; 
 Thu, 24 Jan 2019 11:59:39 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.11.59.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 11:59:39 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 04/22] drm/sun4i: sun6i_mipi_dsi: Simplify drq to support
 all modes
Date: Fri, 25 Jan 2019 01:28:42 +0530
Message-Id: <20190124195900.22620-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_115941_656221_685B610F 
X-CRM114-Status: GOOD (  15.43  )
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

Allwinner MIPI DSI drq has enable mode and set bits.
- for burst mode, drq need to set enable mode bit.
- for non-burst video modes, drq need to set enable mode,
  set bits for those front proch greater than 20 and for
  rest drq is not used.

This patch simplifies existing drq code by grouping into
sun6i_dsi_get_drq and support all video modes.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 39 ++++++++++++++++----------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 0f02bcc997a5..16a86d35dc5a 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -354,6 +354,28 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
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
@@ -381,21 +403,8 @@ static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 				  struct drm_display_mode *mode)
 {
-	struct mipi_dsi_device *device = dsi->device;
-	u32 val = 0;
-
-	if ((mode->hsync_end - mode->hdisplay) > 20) {
-		/* Maaaaaagic */
-		u16 drq = (mode->hsync_end - mode->hdisplay) - 20;
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
