Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF2CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:21:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E282082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aZuKPJji";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="S6PS8uPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E282082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QyNXD4hIf+l8A6irG3U8nl/hLBfnfwZx4930TDpFoBY=; b=aZuKPJjiryJthy
	YvktVR54WyO6ByqAs8pI/+SOKONi2COKVKm0hkrPvpiynLReq+GYYpAgRjldaG3NdIILZS/1wM/6I
	QG9dghHzpdRoEoiczF9Eqf059EEtS+7U3/hViC+VCDDWyqQMbBWA1BaFNGs9iUXpJ3vJtng6aBwOf
	nn9qQoDpplmsh6D2qUdsfQuuzMuRHxjt89gQat7lUQoG/45D7s3ctzY15lx76CFi9w3PwsflQrFgY
	q5YESgHp8ct24XjBWPJoPoycWSpFgipTmFu8LWKWF1yOJ3untpo/YcO2AlBGUaijeKMUYIK8UadeP
	RSeVWbFXWiMI6z4TsJXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOJI-0004Cc-5G; Mon, 10 Dec 2018 16:21:32 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOG8-0007lP-F8
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:18:23 +0000
Received: by mail-wm1-x341.google.com with SMTP id r11-v6so11502682wmb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DaE2bcL6r+p/M15eQzTefkij1Q0qgITroLCaQhT54ts=;
 b=S6PS8uPD8o5uagR8UnFFV5omwXh05Mz44ipN7Z9aiXIlDLaDRYzk2Jj/QB6wdZGifY
 UfH6mmYsN3/xenatx9Yp6xZ6SrIX2kOaNglIrA4UwTpP6kGP3k/6TrHj05Ho1hEiBJLg
 KEwN29zz3nVhYewi3bpIULmuRTEgscTShjO4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DaE2bcL6r+p/M15eQzTefkij1Q0qgITroLCaQhT54ts=;
 b=U3acTKIgEF8Ga22YcS7kgqffK+KzNN+YHhXK6IL7e/xB6Pd06zAAWKSFBHFHPJihRO
 WnasBqdp54UOJZjO2ljP6hfyoXxlJWRojvxJ2DihXs3c5hQmnTyu95/fXmGoabiFWO2K
 w7AqevEJ4gXyg4f5XipVQOsGUmK9/JO1NIwXfjy7JBvmM5fwXuetUH1gXO30s/vV7om3
 GczUbPtVWp4X/hQGjzbhRzVxxYbvCcFy+MXtfZjp8iBqOGw+UJkbtCSR4CdciidAe8Bj
 jiwR4sk1ulKlxiWxCtUvZKk1GaFThrru9we/8RgFN2jbw8rVQZTArYcLkbgyKpXOVsyl
 yL8g==
X-Gm-Message-State: AA+aEWZZHEKycoLNumGA+PG+a9c2MP4lQ1oIN9preKs+93rTNhs3WMJt
 DZuQTwt4EInVN9Y3lQygqllAOA==
X-Google-Smtp-Source: AFSGD/VZAupYbQ9LuzdN+x/pfuCVOroCGUxCmBhiF84wmW8VVo6bObaVkTtxkS+buZnlKVFmY0nK5g==
X-Received: by 2002:a1c:9dcc:: with SMTP id
 g195mr10789931wme.153.1544458684950; 
 Mon, 10 Dec 2018 08:18:04 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.18.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:18:04 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v5 12/17] drm/sun4i: sun6i_mipi_dsi: Set proper vblk timing
 calculation
Date: Mon, 10 Dec 2018 21:47:24 +0530
Message-Id: <20181210161729.29720-13-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_081816_853875_C817D25E 
X-CRM114-Status: GOOD (  16.35  )
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
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Unlike hblk, the vblk timings should follow an equation to compute
the desired value for lane 4 devices and rest of devices it would be 0.

BSP code from BPI-M64-bsp is computing vblk as for 4-lane devices
(from linux-sunxi
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

tmp = (ht*dsi_pixel_bits[format]/8)*vt-(4+dsi_hblk+2);
dsi_vblk = (lane-tmp%lane);

So, update the vblk timing calculation accordingly.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 29 +++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index d8947be92f9d..cbcef7bf7681 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -355,6 +355,27 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_INST_JUMP_CFG_NUM(1));
 };
 
+static u16 sun6i_dsi_get_timings_vblk(struct sun6i_dsi *dsi,
+				      struct drm_display_mode *mode, u16 hblk)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
+	int tmp;
+
+	if (device->lanes != 4)
+		return 0;
+
+	/*
+	 * The vertical blank is set using a blanking packet (4 bytes +
+	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+	 */
+#define VBLK_PACKET_OVERHEAD	6
+	tmp = (mode->htotal * Bpp) * mode->vtotal -
+	      (hblk + VBLK_PACKET_OVERHEAD);
+
+	return (device->lanes - tmp % device->lanes);
+}
+
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
@@ -503,13 +524,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 		   (mode->htotal - (mode->hsync_end - mode->hsync_start)) *
 		   Bpp - HBLK_PACKET_OVERHEAD);
 
-	/*
-	 * And I'm not entirely sure what vblk is about. The driver in
-	 * Allwinner BSP is using a rather convoluted calculation
-	 * there only for 4 lanes. However, using 0 (the !4 lanes
-	 * case) even with a 4 lanes screen seems to work...
-	 */
-	vblk = 0;
+	vblk = sun6i_dsi_get_timings_vblk(dsi, mode, hblk);
 
 	/* How many bytes do we need to send all payloads? */
 	bytes = max_t(size_t, max(max(hfp, hblk), max(hsa, hbp)), vblk);
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
