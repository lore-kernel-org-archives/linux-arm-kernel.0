Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A26C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:20:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FCE20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U7z0kRkI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V/ScvD53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FCE20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/nw5F7H9mNYdFcf3d5OZ8thXqBEkYeJkCwo0CdEPM5M=; b=U7z0kRkIsw28rU
	giYUxhD7GpfYuSs8qhQu2Rf1o8SU3V36QNVLrFDN0q9o0Wc8T/zYucD0Ns+ggOaxXVJOVokhnaPdK
	/5s2ADwG+/QfLS3Rs6STGQ8Xcwz+xLSiyyoS+GBNZfy7kmK2bHsHSEspHCO2ucA99bw/yCKcX9Xlo
	tkLdGAbs2jB+IiMoCgQkqQBgpwgaTP3XMkKbac2ZqkGnJNxa6yr4ia1eSnpvrh3GYNpA2KCfEsSE/
	bN8tvWF0D2swkxAYZ7jnbq/E6vciyjewn1LmkCGIVjFjF23h2rSGQ40pKXFZjgvEKN6AOfs3pxnXT
	nFytrqaTzgPp58OSQisw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOHw-0001wo-LO; Mon, 10 Dec 2018 16:20:08 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOG3-0007ie-9n
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:18:14 +0000
Received: by mail-wm1-x343.google.com with SMTP id y139so11493166wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iu6bo30lI7sS+xNVJvtG33E9f/2Ed96R3LMOZkklEQk=;
 b=V/ScvD53nQq8q8RNbZwKLQaXHDUDSHeBK8qFTPi6210g4FA5YWqL+MjTPRV9xvIPA0
 T33N1XPkgDJTyx2LRFrRL1dG+IE5kTFWp64gJtU+urdyeYurxCnT6F2pzMZIwhMybXzg
 0QvJWttPKfrq+mIYia5Gvpq91Newb2CgaSZsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iu6bo30lI7sS+xNVJvtG33E9f/2Ed96R3LMOZkklEQk=;
 b=Q2YdJqtT47thbsRa5+7zH3lygxoPnnyBerAxtM8eZezzFn3QYMX5crnYv4V/xRafCG
 +j2hBC6I19CF5zYY+K04QPyutm8X9LL7ckYQHSpGf2decTk76mWDuiQ9e4XDJgGeS/QF
 z4sIuxz3ZJ96s5Ory0FraHKUuagUz2HTVhWriy2auJzmgjvJU3zRnl2vvhT5cZiNJPir
 Of2Pgg3RtqymDNuFN6YHjqMkXcqi0KESx00FC9qRRLHOhoK+r43S+KqQrOUqwHgsOnOg
 5kZyIq/eQxnQIES2dUZs0UTa/FoGAPaA7XeH6tqKiZmCuk/6afntber7faa7ntt/ZIAy
 sX4w==
X-Gm-Message-State: AA+aEWbt7cgjLY4opZQ1ShLGxCulic6ilOkoR88+OG94xHjgZrYFYAmE
 aw23ppDXAZCazNY0XgfT2zWYsA==
X-Google-Smtp-Source: AFSGD/X4QL8op0FfdcbGirGBh1dxiIlhCD60l+CuLwIUddllsDFHzpON/K3thRQdghvvcaUUBqcsOA==
X-Received: by 2002:a1c:e3d7:: with SMTP id a206mr10879717wmh.77.1544458683263; 
 Mon, 10 Dec 2018 08:18:03 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.18.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:18:02 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v5 11/17] drm/sun4i: sun6i_mipi_dsi: Fix DSI hfp timing value
Date: Mon, 10 Dec 2018 21:47:23 +0530
Message-Id: <20181210161729.29720-12-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_081811_715112_F8B12D55 
X-CRM114-Status: GOOD (  14.98  )
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

Current driver is calculating hfp maximum value by subtracting
htotal with hsync_end which is front back value, but the
hpp refers to front porch.

Front porch value is calculating by subtracting hsync_start with
hdisplay as per drm_mode timings, and BSP code from BPI-M64-bsp
is eventually following the same.

BPI-M64-bsp is computing hfp as (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hbp = (hbp-hspw)*dsi_pixel_bits[format]/8 - (4+2);
dsi_hact = x * dsi_pixel_bits[format]/8;
dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
dsi_hfp = dsi_hblk - (4+dsi_hact+2) - (4+dsi_hbp+2);

Example,
u32 fmt = dsi_pixel_bits[format]/8;
=> ((ht-hspw)*fmt - 10) - (6 + x * fmt) - (6 + (hbp-hspw)*fmt - 6)
=> (ht - hspw - x - (hbp - hspw)) * fmt - 16
=> (ht - x - hbp) * fmt - 16
=> (ht - x - (timmings->hor_total_time - timmings->hor_front_porch - x)
* fmt - 16
=> (timmings->hor_total_time - x - timmings->hor_total_time +
timmings->hor_front_porch + x) * fmt - 16
=> timmings->hor_front_porch * fmt - 16

So, update the DSI hfp timing accordingly.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 07eba9ec469b..d8947be92f9d 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -490,7 +490,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	 */
 #define HFP_PACKET_OVERHEAD	6
 	hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
-		  (mode->htotal - mode->hsync_end) * Bpp - HFP_PACKET_OVERHEAD);
+		  (mode->hsync_start - mode->hdisplay) * Bpp -
+		  HFP_PACKET_OVERHEAD);
 
 	/*
 	 * hblk seems to be the line + porches length.
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
