Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C062DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:27:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904B7222D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EO2N9mHX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V+GKYnGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904B7222D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YbC8WdfqXpjKwkEDzAyCsypbjMUpG9pEW4A3fh78p20=; b=EO2N9mHXgeG8nU
	Qr/BNvToqDCTvu/gqtDZHCUJIMCAND8qNYdek+/6ka9m/Z27NHt/rlNn4oq+a9IR1l1Pn+qZkGlMg
	eKuTZisPZFpPZZhUtGWNR67D1ky4CtrCkyAa2chUFGjU77e8xbQUUOg6Coc+i5NGqpzj3Ofq8c6b3
	1gbKN99d1jsGAgPhu3saD9bTum0fEzTbKBLEEDvsvI8SyhaHBPREWXH1L4aqSMTnqYgyyJYy9L5uy
	24b2y3mLAFUDC/3o706bf1vmdbIwyPCHhg48OKfQ2G5JnupLHzqDjBngtnmfD8+VVslDUz1zD1doj
	hWUOBhlXPvrwKIiHiKEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guMff-00033S-2g; Thu, 14 Feb 2019 19:27:43 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guMeU-0001dd-FA
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:26:43 +0000
Received: by mail-pg1-x544.google.com with SMTP id y1so3537273pgk.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 11:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5N07oU2k2LE7t0QlvtqZwD41GQ0JhcM9+FfY0qN6oOk=;
 b=V+GKYnGRmRLbvW/9tmZOQnqrqzQVvOyAc9i+ybY4q6VXxG4RFFoK8DqK2T+BsWuglr
 fzRDTS2pzI3jNAYMc68T7vBJC4gSHKsp4sLqVf7YsrB/efnhLsJj1LbwKuj5iZUKyMAQ
 vnvc9xkb66E+nMMT2llLXX0UGrq8rxSx9+1NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5N07oU2k2LE7t0QlvtqZwD41GQ0JhcM9+FfY0qN6oOk=;
 b=pC2evg1bm75tn7MtAmIqNyKgsYd0Ma7EqOFejswqaiKx661XK77YAV93U8Ge3aC8nr
 wynoJEURBniml7l3AFgsuNji77WmZu2pMFPv+V3wNCbeZ4/ZNesHiNFzp3ueWrSDpJkn
 YoSGvpKzbvJXv+xIK/kn9lIVjHDEehiNJ/doW8Os5+t89uaTtrSwhuGt2QGqmbQfUAB/
 P/C3BDkC39q+fdJXeKVxT9ueXr0kY+0P4x1fd+x1obHV1EyGTxG6pqhKvQN+nxdSyAqf
 OATB+6a0B55p+8nL6XKbGmuzUqUEAzPv+4dmgD+cHRa/tiDu0VP6NW/+Ro8Ki8kXNfXS
 yAtw==
X-Gm-Message-State: AHQUAuaS9ipcpesYbd2Y/Q9Fwcjvh4TDgv9CXj5U70DOYTCJ5RstUAG0
 WX6fj5MpnM04xkcfqagYYE89QQ==
X-Google-Smtp-Source: AHgI3IYa3jkq2zGmzYMgdNauEe0uYUJbfzKwzALB7vINehRpWgxtagKi09HgO0hbmCn1Lw5pM+LpXA==
X-Received: by 2002:a62:168e:: with SMTP id 136mr5787813pfw.116.1550172389962; 
 Thu, 14 Feb 2019 11:26:29 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id k71sm8390100pga.44.2019.02.14.11.26.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 11:26:29 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v8 7/8] drm/sun4i: sun6i_mipi_dsi: Refactor vertical video
 start delay
Date: Fri, 15 Feb 2019 00:55:43 +0530
Message-Id: <20190214192544.7314-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214192544.7314-1-jagan@amarulasolutions.com>
References: <20190214192544.7314-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_112630_966943_FC10A713 
X-CRM114-Status: GOOD (  15.23  )
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

Vertical video start delay is computed by excluding vertical porch
value from total vertical timings, but the current driver excluding
vertical porch along with vertical sync values from total vertical
timings resulting wrong start delay.

This patch trying to update the video start delay by subtracting
vertical porch from vertical total, on the other hand it added 1
extra start_delay line for TCON based on the Allwinner BSP reference.

BSP code form BPI-M64-bsp is computing video start delay as
(from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
=> (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
=> (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
   - panel->lcd_y - (panel->lcd_vbp)
=> timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
  			     - panel->lcd_y - panel->lcd_vbp
=> timmings->ver_front_porch

So, update the start delay computation accordingly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index a08dfdcbe9e8..31cf9c58e98d 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -358,7 +358,24 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
-	return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
+	u32 vfp, start_delay;
+
+	/* vertical front porch */
+	vfp = mode->vsync_start - mode->vdisplay;
+
+	/* start_delay = vertical total - vertical front porch */
+	start_delay = mode->vtotal - vfp;
+
+	/* add extra 1 delay line for TCON, as per Allwinner BSP */
+	start_delay = 1;
+
+	if (start_delay > mode->vtotal)
+		start_delay -= mode->vtotal;
+
+	if (!start_delay)
+		start_delay = 1;
+
+	return start_delay;
 }
 
 static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
