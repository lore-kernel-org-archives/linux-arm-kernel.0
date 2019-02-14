Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0E0C10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0DC222D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W36aaO2f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l45VmOgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0DC222D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b5WQsi6xm/N4gqZhRMznU7AdLqLEo0yu3j4o5n3bUuM=; b=W36aaO2fyZNOgA
	HyTNLXoDaZHyjrttUvvUkqHFtW1kWiSQppodMn25UpRaag6EZvUI32PTnH4kHyNMKeUJPtCyCHKjr
	RLDMOoiI1o0AieozMqnhrZ47dvWYG6A9tCN+om5bMz+1nIA1wPj77ovMUJU9Cbxv8KuA9HAeU+GXb
	vpsnfvBcx5xMLjlrW2IfddtVJ27YDtQLg6U9Xd+qMpDMaWo1roaD0QjXajZcwUsuWT55bPb48vl1v
	v1PymwrcJUXHn/sa4Ge8M4KhISLsrz79iv5fv+G5pVXN/Gsk1Rn+6/KFkcqdIYQHnn6ttcAba/aPJ
	06r8OU3o6F4/KwECG0aA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guMes-00029P-BD; Thu, 14 Feb 2019 19:26:54 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guMeJ-0001NZ-Uc
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:26:21 +0000
Received: by mail-pf1-x443.google.com with SMTP id b7so3578547pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 11:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8bEG0NxK/TkiBajUPiod9cKRuA/aBM9IwOWB4PGFOrI=;
 b=l45VmOgAS7gmdmqj0kwq0CNxr3FjdmxmX5VCKjF0O1zGcSdzvmPJ4KZtP3D8MQKS5Q
 Bju+FpfWNcC9MkgAMtOQzfu+0SwUtNwa/522Egshy9HFToZIwme2xASYf4GWBNvLetdW
 rgRtQ29xehVznd7besQEhuVZQF0zo06VBDY2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8bEG0NxK/TkiBajUPiod9cKRuA/aBM9IwOWB4PGFOrI=;
 b=ROPJSuaucFJ13jPeZzmi1g2PF5lzIUuuNlRXizWzruLezoLDBEyI+mRr6HMwClJcZW
 Qo1KDFDxqNgD99AJA++zWgUrUM+1Fp+CrL9FHiJ84NGO7+cQQKswoVrRwokI+KJB79wb
 8+0Yll4kifClULUqkbCKC2IHER5qNAbagX9vEwv9ebHpU8B896WoNmAb8xbE69CQwbDe
 Fml+twFJZqvFUxGrUAMnvZtMEn2/WO9rYBFHwsn+Z3U64BSoviZxTdoPXlRfiJ+6Isc1
 QBRB6uJQaCula/1axz4uSJol05pdvn/zKuNUgtYXvnXjbc5dLFL1g4cUgK9lLcgzMgUq
 mulw==
X-Gm-Message-State: AHQUAub3GhrJDG2iXzAHQwjtJkRU1ermPH6TzwWFWNiAT91S3nZ6VyHT
 vLAUagcFF/EDDLy7/GL12HJdYA==
X-Google-Smtp-Source: AHgI3Ia0CDs3p5oMKUDDJam7CZ/l0xCiETZ3cSv8nrroWNdU6m6h7kQy+w24xsl0DYun6uSOM0FAIA==
X-Received: by 2002:a62:442:: with SMTP id 63mr5632258pfe.156.1550172379131;
 Thu, 14 Feb 2019 11:26:19 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id k71sm8390100pga.44.2019.02.14.11.26.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 11:26:18 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v8 4/8] drm/sun4i: sun6i_mipi_dsi: Fix DSI hblk timing
 calculation
Date: Fri, 15 Feb 2019 00:55:40 +0530
Message-Id: <20190214192544.7314-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214192544.7314-1-jagan@amarulasolutions.com>
References: <20190214192544.7314-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_112620_010246_A6ECAB6F 
X-CRM114-Status: GOOD (  15.21  )
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

horizontal blank is computed by adding all porch timing values,
or htotal total timing value without sync time.

Based on "DRM kernel-internal display mode structure" from
include/drm/drm_modes.h

hblk = htotal - (hsync value);
hblk = htotal - (hsync_end - hsync_start);

Current driver is subtracting htotal with hsa, but the hsa is
bounded with packet overhead. So subtract htotal with hsync
value(hsync_end - hsync_start) proper hblk computation.

BPI-M64-bsp is computing hbp as (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
=> (timmings->hor_total_time - timmings->hor_sync_time)
=> (mode->htotal - (mode->hsync_end - mode->hsync_start))

So, update the hblk value accordingly in sun6i_dsi_setup_timings.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 21f39f11a8de..6b26dba883e8 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -486,7 +486,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	/*
 	 * hblk seems to be the line + porches length.
 	 */
-	hblk = mode->htotal * Bpp - hsa;
+	hblk = (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp;
 
 	/*
 	 * And I'm not entirely sure what vblk is about. The driver in
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
