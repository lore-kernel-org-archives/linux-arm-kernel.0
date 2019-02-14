Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA5CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:27:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24807222D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RbrnN6ha";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dbkFqMfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24807222D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=brAHeyCt0q0uK+QnL3fYWqh6S48hyJy3u2cAoWAvEVQ=; b=RbrnN6haU7752k
	yasp9rqDSX8iorimQoN9uHZKCgn/K04vIuSXHpsiw/sxrcwmfHfDwf6IGAmZiCHMgIH0F9NVqizxI
	pZYHb7dSRwj7GXE+lZu/hSGHZPt51WASDhQRLFasDDmlnEkAss5nWyMvJDdbcikhOGB4Na2l1UakA
	RIuxeMkg99pGrp99FEdda8FXMhjRccHvLS8++KEsL/TyBfGo9xkhCC3AuwFb6l1b37XgKAxwP+3+D
	WAd5uH2WBMk7XfVUilAb2eStVWOnGmgxKof2Ugsa4fGZqcD4uv+aqdmWsOH1JDbpx23bPN2lRPyux
	NK+SmF49rtcf6NDcD6HA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guMfU-0002nj-6M; Thu, 14 Feb 2019 19:27:32 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guMeR-0001Yn-9A
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:26:33 +0000
Received: by mail-pf1-x441.google.com with SMTP id j18so3593737pfe.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 11:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l45/w0iXjOS/5kE7BbpDMgm34gyLbKfVsq3DBo0xqe0=;
 b=dbkFqMfikgxyGeQmRCQmyLfUMr1v9qGRB/1u1KREh4PmaL3FKvldPTGzwqHsTAZriR
 qTNMVBshoZFnhTqq62vjZdUezp6D3LV4DXsQxSoXWlE7w1p5/nz8K9dHVjUI0uewmm/3
 Tx6ZYGS+edH/xG+wyuR+MLY2LA5OsTE2FbXxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l45/w0iXjOS/5kE7BbpDMgm34gyLbKfVsq3DBo0xqe0=;
 b=mtiSU9CsTesbqTmNRAIjM65t5gIhd0vEP3WeMfD4i+xSG3Jo2c51zfAuaNufikJRs9
 2U8xEMKAlDsLUvN6wslWIwVw/tC4dQDBtEbf5dD5wM5rUuCRzA6mvva1CAOUlLv3LnKg
 9KxStKVzmXOP6cRRjZ2h1Uo+BSGvbGltMI55czWKFIVstg4muG9TnrAnPjJsgZOxmnVb
 rSi3iwMZWpqVL6mFlM6XkwTk4oftvuS9cGzfSci7gjg/XKSDc/2uZ3rhi2Bnz4Lqz5m+
 +nWVmmWs+CNnyq5J2FehdYblcH/EDTTofhooJISwwGIX1HgSAxz29Sv5jFasOvtQN+Yk
 Kc7A==
X-Gm-Message-State: AHQUAuYES0uuRUHWJUGpWOjcdbv3E7XJW6I0z6YZFP+7/G15ehNibftu
 iZvrCT3vJEkHZZdThICJEYIoKg==
X-Google-Smtp-Source: AHgI3Ia7Twnq5r7dgW0TFcIF1mUc1g5B8v31Ffn2m2aFBQM1Cv15c3uxxsag0SXtBDHRvwgLsyoMtA==
X-Received: by 2002:a62:a1a:: with SMTP id s26mr5742054pfi.31.1550172386534;
 Thu, 14 Feb 2019 11:26:26 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id k71sm8390100pga.44.2019.02.14.11.26.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 11:26:25 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v8 6/8] drm/sun4i: sun6i_mipi_dsi: Set proper vblk timing
 calculation
Date: Fri, 15 Feb 2019 00:55:42 +0530
Message-Id: <20190214192544.7314-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214192544.7314-1-jagan@amarulasolutions.com>
References: <20190214192544.7314-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_112627_759593_955253AB 
X-CRM114-Status: GOOD (  15.62  )
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

Like other dsi setup timings, or hblk for that matter vblk would
also require compute the timings based payload equation along with
packet overhead.

But, on the other hand vblk computation is also depends on device
lane number.
- for 4 lane devices, it is computed based on vtotal, packet overhead
  along with hblk value.
- for others devices, it is simply 0

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
index a64e6ec00f22..a08dfdcbe9e8 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -446,6 +446,27 @@ static void sun6i_dsi_setup_format(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_PIXEL_CTL0_FORMAT(fmt));
 }
 
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
 static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 				    struct drm_display_mode *mode)
 {
@@ -493,13 +514,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
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
