Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23AEC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:17:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891C3217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XzMd5otr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lmouE3bj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CC7tbdyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891C3217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kev5DP6CMiFSig3C8dyMr7kFkKpHfzUZKXesmErwfPQ=; b=XzMd5otrTguEw5
	xxnmw8KB1IjNazW7FwIZhfJ3rliBebGTwUYIgg2y809qBjJBN/gF5LXXwF9z/dmF2/PvPRxhlCvst
	JYaDi/GAoxb5jmyuTPgV9Gi2AuUDWeICuiHfmA24G78A4FvcnFaoe9epuC9Tnb1xsgDqdNsY3s8eZ
	cSzMzPLek6j1Igv8oYCmFyNowDVRyNrFeDlwTVbK5LU+/NMhX9xROdqgCREZm/G4Fv+yrpC0NrTuW
	PUyLRdwAgsnU3BeqttnVyhnEuCWEGi794lAoNbWhwENOMDkl08hon/I6EQDd/AHFXZO/Von0mXPWK
	+SmDLvz1/x3MWxxBMQaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlR5-0002bh-Iu; Thu, 24 Jan 2019 20:17:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlPj-0000kt-Q4
 for linux-arm-kernel@bombadil.infradead.org; Thu, 24 Jan 2019 20:15:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p/fJ1iw2WcKuA3279PZCjqMz7GBGf1KE2XCGX061XcE=; b=lmouE3bjcmpcK4/Oy1Vle5Vo/r
 QtvnYVPTzmWhJ5Nm0rmKTrnQaFxnlsA4zG8//L3FB8+drcH8fIqFL2G0OF4/9j+ogIj59pSoLNYgA
 zhGvcUWp8E5tZMSRhWI7F8iDoK28PHHfjyuLDGNjT/T8PMG7NWvy+mcmBP3xnSbAi7TKWtD9hyEit
 0ZystHZHi6uRJK+lxWMWfpFdgRCVoIxVMLAN0ng0bRY77WqWg8/nj64sKle9QYAxREKCco8lxs5pi
 pfP8QhSbPwtkY1Mw9nMI+S+xtCR0zgcHR2qielpFnQlxDNrm6hLHeBGRYr0yV4NvzhzI4hzqyCVGL
 4T6CopJw==;
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlBY-00023L-0Y
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:01:13 +0000
Received: by mail-pg1-x543.google.com with SMTP id w7so3112509pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p/fJ1iw2WcKuA3279PZCjqMz7GBGf1KE2XCGX061XcE=;
 b=CC7tbdyLxoRdfqqHGpLeXCUiQEbgaexutUTQRuVYuirYw0CEJF6xTKYaBdsFyFzMgl
 +mOf3fjdQjDVA496o1n4r6lNRvIDETxD1zWANt0JNbj7Xzp1gr57NASbumpuLDLCBOXs
 Li2ZfTWYkQZStwDJUpN5TcGcvwK7FaR4lW5eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p/fJ1iw2WcKuA3279PZCjqMz7GBGf1KE2XCGX061XcE=;
 b=nNZMuf9oA5rRlCpVGFjTbOj+TSIyHtQ2EGdsOsWJTYW19Clqzvln8OOia8KJNxsK40
 337ptE77h4HbqVZLKEJgpkU+0K81jkX3RhwT0xjGJuZgMR/IU1l6pkBUGlqafbWLB6Pw
 rtOWhBDFZBngtRtqNIQR6ylt0e+2N6gCRh/79Es25b5e3H4/kV+pVHA8HJ9lSvhMyNOO
 DX9rph9KfnTlcfFyMpQ8Hm5tNH3BTxzB0rMdYaB+kag/FMlnXaGEM4MA+qX4hhlZQn4a
 DdxHx9C6Y8caskBeDAwMTyvyx/irP7tPDfRVatndE4Pvi8//VwPt5p5RPBsmHz4St4gY
 PBEQ==
X-Gm-Message-State: AJcUukcarF1Q8+eiF+Ra1Or5CXb0UDchIbkx3u8uGG4sTULcJSzsloaE
 uMIp3058XPJGS02dlbMCGVeF3Q==
X-Google-Smtp-Source: ALg8bN5s9ZdKUPSLcjyahaie8Nxi1A3bxmx5c2bMvR7xMCSOGff1YPDujEn8dCM/B/3aSm4tatnYrw==
X-Received: by 2002:a62:1b83:: with SMTP id b125mr8204996pfb.42.1548360070231; 
 Thu, 24 Jan 2019 12:01:10 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.01.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 12:01:09 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 20/22] drm/sun4i: sun6i_mipi_dsi: Fix DSI hbp timing value
Date: Fri, 25 Jan 2019 01:28:58 +0530
Message-Id: <20190124195900.22620-21-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_200112_121335_A1317992 
X-CRM114-Status: GOOD (  16.90  )
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

Current driver is calculating hbp maximum value by subtracting
hsync_start with hdisplay which is front porch value, but the
hbp refers to back porch.

Back porch value is calculating by subtracting htotal with
hsync_end as per drm_mode timings, and BSP code from BPI-M64-bsp
is eventually following the same.

BPI-M64-bsp is computing hbp as
(in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
dsi_hbp = (hbp-hspw)*dsi_pixel_bits[format]/8 - (4+2);
=> (panel->lcd_hbp - timmings->hor_sync_time)
=> (timmings->hor_back_porch + timmings->hor_sync_time -
    timmings->hor_sync_time)
=> timmings->hor_back_porch
=> mode->htotal - mode->hsync_end

So, update the MIPI-DSI hbp value accordingly.

Tested on 2-lane, 4-lane DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 58bda0928aef..e24719cabba2 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -578,7 +578,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	 */
 #define HBP_PACKET_OVERHEAD	6
 	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
-		  (mode->hsync_start - mode->hdisplay) * Bpp - HBP_PACKET_OVERHEAD);
+		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
 
 	/*
 	 * The frontporch is set using a blanking packet (4 bytes +
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
