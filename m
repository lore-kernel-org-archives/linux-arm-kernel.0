Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4365DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:27:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA73222D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="goIXCAUM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KYg2QwY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA73222D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IaaVTvQ8hSvjZWeLO/gvtsG0p7Y10PW/mQ++T9UTGGU=; b=goIXCAUMC8oclD
	E5rMnTtqc4OVwl7jZup0bmw7mDAjEPleeVvulNX3Wf6jEndoAqzRhiBSs/+krMNDQsqD8b5Mz02sE
	qsdT36sAJeQ2wkVE0lpSO5O0L8aWoF0LUiPpoXN5QgvLavzcvuFZ24kWBcbhvi5h2S5kG0QN/M/VC
	GoMFRkalBi/ormc0500Au9x7YnvjFPQ1S81p96wGGx5AqGmfjq7nAm7oW758WYt8u5rOXBFMcdG+n
	eRtPiKz8Y7gFWqrSzzyD81Zon8ZxHSpLolqukRj6r+5WFNgw8F2si+5JuPshiElMvI5BTl7szfzju
	OfXRD6wBy2+SCOwkyMPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guMfL-0002cr-H6; Thu, 14 Feb 2019 19:27:23 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guMeO-0001U6-HY
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:26:30 +0000
Received: by mail-pg1-x544.google.com with SMTP id m2so1287892pgl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 11:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6PA7omnu5a1QEIw1FJbeZKYVUv3ytW4+L6xraVR/pk8=;
 b=KYg2QwY3pqecw/vKuQF3qTv4P53VS4HpwdC/ZE/zGzuSq9g976SGphyYcygNR8HyXf
 U/GL+Pr8XuW9N+85KQfr2kCXFa+TD1NXUZwwfyDpwvYze0DbmazlcDqdngc98o08pmXo
 HcNjMZrQd4Ep/OOF2pYvDZwm4zJkVKnZBvEho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6PA7omnu5a1QEIw1FJbeZKYVUv3ytW4+L6xraVR/pk8=;
 b=XlBzXGEfhith8NeqEds0Vfujfg5TbkThQ6P7BNd3ls3OK5c1Jbre2zHAkm5RSSRz60
 2zKxO2X10efzjAtEDo5Sccfgz6QooRTZ0OlWwe328eB6DGt9X0GivnIaDo8/jZqKg25V
 04r2bPvlP6rAKFZTPzOKUeZdeT6qrkORoSvUWghavu/qhaQvAtERmXtdtwC24NzXs9Al
 VRaSm9zTwZ+LJFCYNpxQlfvHDvX8Cc+kZtktEtq930Wo+ORRgaq7k6fHPgaZR8sZULhd
 6ElqCpWXmWK6zDbvCWmEtncn0PJThelYruyJksiZnubERFbUUmm42D+k/dMzxX53uc07
 SvYw==
X-Gm-Message-State: AHQUAuZQfsVgGFV0iuY9nHu1xT76W2h2jgpgQraFRdeZ3J207+Kkydfq
 FNk/TY5AF4Ff2CTKUoM4e86q+Q==
X-Google-Smtp-Source: AHgI3IbaKLGN1hq/z5LYB5B808XAS18IAysXSaBZfFEbEqN8Uw/C0DjJD1mDDwX+NZEGlxX6a1y7ZQ==
X-Received: by 2002:a63:d347:: with SMTP id u7mr1443184pgi.383.1550172383057; 
 Thu, 14 Feb 2019 11:26:23 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id k71sm8390100pga.44.2019.02.14.11.26.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 11:26:22 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v8 5/8] drm/sun4i: sun6i_mipi_dsi: Add DSI hblk packet overhead
Date: Fri, 15 Feb 2019 00:55:41 +0530
Message-Id: <20190214192544.7314-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214192544.7314-1-jagan@amarulasolutions.com>
References: <20190214192544.7314-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_112624_915462_48BE9463 
X-CRM114-Status: GOOD (  14.18  )
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

Like other dsi setup timings, hblk would also require to add
packet overhead.

Add 10 bytes packet overhead for hblk, so the blank is set using
a blanking packet like (4 bytes + 4 bytes + payload + 2 bytes)

The value 10 bytes are refereed from Allwinner BSP like how other
dsi setup timings grabs in existing driver.

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
index 6b26dba883e8..a64e6ec00f22 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -485,8 +485,13 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 
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
