Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1125CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:23:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC15D20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qReYUhUk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Fby41GOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC15D20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CNzxfKubzEqP4LGdJ9J4SkuD7RsZMaJUQKZ7UHIWcvM=; b=qReYUhUkQ97BuO
	jgd8nmQEx5cFiUEXZOi8gjVSA7XPKKA6W6e0R+grYIeLCoV37Bir3oymP6gdqO9NLwirjNhfJBHUe
	bH5fTuxf4Z0Ft4HLX8ZmARgaQgq8A6qRRzytDwxGqRS/5N1NktDQ5pI6PxC5zBtSfo4lFmGxHNYsA
	T15yx8lbuyEp5RTq+ufOlsEPeV2C8e77QHjaKlZwYMdVqX2ktlUVIRK2FFTVegogfgWuF02j6ytMp
	4RXz4RPm6kN9qc8fmSOaeWMtRNeMQakWi0yTMM3/CjaI85MOjrD1A3RQbpqmsatQw8g02ZPzEL8Dq
	phy6wEFdRd32YsXhhzvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOKj-0005Io-OO; Mon, 10 Dec 2018 16:23:01 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOG3-0007f7-9r
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:18:14 +0000
Received: by mail-wm1-x343.google.com with SMTP id c126so11858576wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oiAA/cUEr092LynkAnVQtsmpFwj1u/ZrP8Y7/2WzfF0=;
 b=Fby41GOV+1hziXy0cQmlduCVcOA7fyZ3cELSFpSyPAoOMg4bvRyz4+y4SEGMpt/ahS
 P6pZciUC8YqcGoUEFQ5MtL/+lmadFyOH56ST2kSp+/v2WQVdtgtFaYeUgoK2+LAS+rZI
 6NAxz1mjg5GSwnzbWzWJq2TwJEuQq7P67LSbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oiAA/cUEr092LynkAnVQtsmpFwj1u/ZrP8Y7/2WzfF0=;
 b=ZZ+CLAeKRFI+0EIXR2Ep9/Ir3D6sE4bwyHbiSEILZamz+I8fA7X/76Arq14Ix8K3qC
 BWElD89pQs1yw5XsKT094v1S6Wa51uoJ3nD7d6n5PxHeEsLZqxmH2qDM4YHsghMdQT4Y
 kPbiX5MDvIuJwrstxVapC3tbJ6iRaJBJwJpI1s0VvfI+vMERPLzvU4KvPTWCVbNL4fmc
 fupyZmFYY1PR2SCuSxQiaMUSujJcWy97icVrlZIN/SnSQy1eX4MtED3VaP4/7YeVQNCT
 t8IlZPGiXxyIcMuc5QyPrcy6zzgu0fkrVxF/nAjwIjO6iQz8yTvDCVbIAQACnn+UZQD7
 CGng==
X-Gm-Message-State: AA+aEWapyNP9RZxJ3FSFvbdvxo5lSLAY2iaZp7Yg2ZKlgfswRNykvFWR
 XtLfuGbEPTv2EgZzrsP/FVMiXA==
X-Google-Smtp-Source: AFSGD/XfvcRdGmj8WQOq1Wc7vWq4fKFJIXF0ufvWTlz2ZYxpONPT8VIJ6rZZCNnXhKal0kD3+aipNw==
X-Received: by 2002:a1c:de57:: with SMTP id v84mr10923097wmg.55.1544458679797; 
 Mon, 10 Dec 2018 08:17:59 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.17.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:17:58 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v5 09/17] drm/sun4i: sun6i_mipi_dsi: Fix DSI hblk timing
 calculation
Date: Mon, 10 Dec 2018 21:47:21 +0530
Message-Id: <20181210161729.29720-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_081811_779350_A1C36190 
X-CRM114-Status: GOOD (  15.77  )
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

hblk is adding line with all porch timing values, or timings
values from htotal without sync time.

Current driver is subtracting htotal with hsa, but the hsa
is bounded with packet overhead. For real hblk calculation
needed by subtracting htotal with back and front porch values
and BSP code BPI-M64-bsp is eventually following the same.

BPI-M64-bsp is computing hbp as (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
=> (timmings->hor_total_time - timmings->hor_sync_time)
=> (mode->htotal - (mode->hsync_end - mode->hsync_start))

So, update the DSI hblk timing accordingly.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 81151d7633f9..4c95b3384ed9 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -495,7 +495,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
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
