Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA45C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:19:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B68D20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sxGSs8Zj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="j64vC5c9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B68D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=upGZshDApW0+VBOArMcSlVuE8ESYopUCDshVAX5rikU=; b=sxGSs8ZjQMXNC+
	dngi1G8Z1/Ci//+QYf7wt9fOyOZeSK5xXlB/CgLvQ+tEKvvI5/Ttl1n1r2x92DEa6mTJcKheCJjts
	mZM6YoWmeC/y1j4HxipJlFHKtXrxm6BjdOeW7UE/jV9UpJkKltFibreyf9uv49Wqxcnk2vDRhc+Sl
	STdKtBvPHcgWK6ULnbwEbOMuxp95ZO7Fu4Ya7SBjYK21SOAUPd9uIdYkPma0WetLgaggMagZ/EZEh
	i8lApg7FSR3G3jQYKQAXfFv46zpIVUNkZnHXXm8/DmaQgyVNgdGVHw+UnkvvnffFZzbeLMYfkoMR1
	ZKVgiku40aE1twixn5mA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOHT-00015p-Ct; Mon, 10 Dec 2018 16:19:39 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOFw-0007gn-Ag
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:18:11 +0000
Received: by mail-wm1-x342.google.com with SMTP id m22so11927842wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7B7/bFXR+1ggUu89xO8Gq2xSzsCKM6R16uBfSc/xhAo=;
 b=j64vC5c9Sc06k6W+B4eLBoq2kgCKRSayqR6+DwNYYJNjxUTlZd4q2LFlL8wdHQbIdS
 GN8bfAAT6V0Z6CvtFGRSbP8FBcFaEPZFXe3U3iFXpeMidy4Bs/9QNzou1htKl46xI/hd
 emjQS/y7d9brelH5z5Gw0ZKvG8G2md8LcP4LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7B7/bFXR+1ggUu89xO8Gq2xSzsCKM6R16uBfSc/xhAo=;
 b=PaECxUOmiFcrNk7zd6OcCpPVuMS+WH6FM51twfOBWxoJdKeF0L8J6aD9EiyPZtCDmz
 daUQI5+qN9LCRhFN3fBIcvl2zFjH9QXpa/Tx0KbkUaNGGDaSIxXlgBwXToYSUPmM/7lE
 njirEcJn2uKZhrQnIM1qqWQR6Cc1j49Vc/0MxEK+HZcFib5Nt8bVM3TQ5jaxjtwXQvJ1
 vgdVj8/uP3UNWu6B2tlQUa1fmUUtoeAvXRw+3drTfvEfRKiMhiYGZ7FL4bNZKeIEDqbf
 Sv2peW4Spcg0qZOXMT5Vkj+rB4mSPUzvMuO+o8gn+Rzq9bikmSlln+PZ8Fc4UEcnhQfZ
 iZoQ==
X-Gm-Message-State: AA+aEWZO99Q9nKGGisB8faBh8j6qZH3qVi+km1jYE4dfrhkmBSVINpHh
 Lm8I7Is/qb//0ECjv0L4avRlgg==
X-Google-Smtp-Source: AFSGD/V6DS87dkTsDhODWaxBYnTVebM8xXCu4fOadguVykyXB9nHb9tTYImyri0myo8lgB3AF4v7zw==
X-Received: by 2002:a1c:d7d3:: with SMTP id
 o202mr11936226wmg.135.1544458681432; 
 Mon, 10 Dec 2018 08:18:01 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.17.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:18:00 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v5 10/17] drm/sun4i: sun6i_mipi_dsi: Add DSI hblk packet
 overhead
Date: Mon, 10 Dec 2018 21:47:22 +0530
Message-Id: <20181210161729.29720-11-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_081805_083183_7D55C2D8 
X-CRM114-Status: GOOD (  14.32  )
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

Add 10 bytes packet overhead for hblk where blank is set using
a blanking packet like (4 bytes + 4 bytes + payload + 2 bytes)

This is according to BSP code from BPI-M64-bsp (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);

So, add 10 bytes packet overhead for DSI hblk.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 4c95b3384ed9..07eba9ec469b 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -494,8 +494,13 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 
 	/*
 	 * hblk seems to be the line + porches length.
+	 * The blank is set using a blanking packet (4 bytes + 4 bytes +
+	 * payload + 2 bytes). So minimal size is 10 bytes
 	 */
-	hblk = (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp;
+#define HBLK_PACKET_OVERHEAD	10
+	hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
+		   (mode->htotal - (mode->hsync_end - mode->hsync_start)) *
+		   Bpp - HBLK_PACKET_OVERHEAD);
 
 	/*
 	 * And I'm not entirely sure what vblk is about. The driver in
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
