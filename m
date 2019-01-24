Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFF8C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:16:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5AE217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZF6fMXC9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VPDH0PeZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="o7lyrIkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5AE217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BTZeQ66ePFETbQ+C2ke6qM1SraWJiGA2OXi8QKl2+J4=; b=ZF6fMXC9qdKRJ3
	fFTVjr1mb/zqjP/wbZ1l9YkR/BEsDruy4nIFNFg7lm4bRnM4/wR5ke1dYhWA+zD5WiuHvniCregLG
	g3PNlbjskpoScTm1fkoan7jbYEOhKSiMIqIsS9LVfmz8VgvG3GazszKyqCtKM6Iel7twhZM2V7ozE
	fDuNC88rskzEVhCbMjlbbMg8VfNRm9/0sRrrPU3G4puAW/hgZQX01IFp+4GfKWj7Alqbml7HbSXfK
	YjCaAU1F8f8EMiFYmVVQbQ8CHoxWQVi2ukCZgWQ1NyV8Bi63CA0VGvFs5HdS7ViXoPJZtdVj12LPX
	bl8V0R9xYdMEjHQncoVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlQY-0002CQ-Rc; Thu, 24 Jan 2019 20:16:43 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlPj-0001JK-05
 for linux-arm-kernel@bombadil.infradead.org; Thu, 24 Jan 2019 20:15:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8SYjzJk1Ajw/4LSvmuyBM6xgYSP98STN7cje2swaDiQ=; b=VPDH0PeZAgtzbTYiu+0iUEMAEX
 hg//dUn+ccbNhfAYWHa8ETdjedUJcuX9wfJjOQJlhwo4wMyZlN/x9rl//PmQH1DxuRXSBQ18TjE3m
 llqrD1LflJBG1h3q/obryP0+MmfWr7KpBY2B6599dZ1NWO5y6GWofHA0NvX3mz20qOo4WlwbXKRUI
 3GNOKN9csOxpiqaH4ZVlXg/uJBWKrHZWu7tHbeCWRW9v6eSljBcDnbv5Vrb4aoJdUBB1ddrk1Asb+
 jGC7SJE3aiVGfi0fa9O2jJkq00A9PRXEhfI69nRU9IL6lWvFbeOWI9/gK2Be2A6FqjrPdcr9io3wY
 LWz24v1A==;
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlBe-00024Q-2n
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:01:19 +0000
Received: by mail-pf1-x441.google.com with SMTP id q1so3530970pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8SYjzJk1Ajw/4LSvmuyBM6xgYSP98STN7cje2swaDiQ=;
 b=o7lyrIkTLas5a3xgc3B+h3z+ZF1kayWCYA+DRkIO5xFRgGUGwXFhXy4u65Kg8OdoW7
 PHTG65m5HHlswX7p3b0zjZCTvqG+lf/LxEQHuRQI0F1nHBdA+ywmODr3C9+hePv4d5GZ
 fPcIILMmRq3oflwNoVMKkNL2hnpIRqihybDbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8SYjzJk1Ajw/4LSvmuyBM6xgYSP98STN7cje2swaDiQ=;
 b=gzD6w3Z+Ccl6WLx/FRgcLDovl31pRYaBIwbCyJIdpoah03b8P/2WLmzpqk7KuCX//A
 j2MyKUNxKW6T9C/0MGpCYjhnh8UbpulCQGLVrINAiEAX5ea3wuXlQH3sLm9NOBDLKorz
 7NabVGqH2XHFXazt54TtOxrMhvE+NeOWpKAOu7i4sqByKv+pjLXdZsw2h/bL/zu08yz4
 UaKiiSzEEVLD2N3pwGneGjo3ODLun33D64zfP593d59d9qUiYgIdPkV+bZrDxJK+5uTA
 AVZZTaG7a3tpDzlv0IEVHW1ONfoYmX1DFDhUX2NzSZmz0rdWT37zmCll7ptRB5hP+jcl
 Eg3A==
X-Gm-Message-State: AJcUukc4rnvVHkv0zQ9bmw1xYhzfHHuGRhhujyEVGfaq1k+/rX4ic8OB
 okgVtNuVY9CftNv73O7hiX4I7g==
X-Google-Smtp-Source: ALg8bN5cmk131g1Yx+/XYabfpyhyd48ETdfvdb+yZtMMsEbaOYRmvgmU9pzpfNN5bjLaF9GhQ5eJtw==
X-Received: by 2002:a65:590b:: with SMTP id f11mr7269183pgu.60.1548360076442; 
 Thu, 24 Jan 2019 12:01:16 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.01.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 12:01:15 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 21/22] drm/sun4i: sun6i_mipi_dsi: Fix DSI hfp timing value
Date: Fri, 25 Jan 2019 01:28:59 +0530
Message-Id: <20190124195900.22620-22-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_200118_321428_62E6CB6D 
X-CRM114-Status: GOOD (  16.19  )
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
index e24719cabba2..9f72eb5f54a6 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -586,7 +586,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
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
