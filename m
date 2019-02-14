Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D984C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A364222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Afo57Q5T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="q6e3FOHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A364222DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vm3O05JFD3SwxNe+NLVXpDrjfIw00vnwhOq2bn38AvE=; b=Afo57Q5TVlRRBZ
	dTIOI3nUNXUDIknFTNx+3lgiB3Z87mXzvxpzfR5kOgsB6U6oJcdMj7alpy7D4fU2/aR9HXGSSLoB7
	7Y3/0wa3s7g8Pa76IsECZ1PBpMQUcTe4scqX3FuryUdkKYcEHEWtcteVlDwqg4ExVCb+cEjiL/an5
	MuV32yIV+AQh/dNPCjuGSrziP1LA8zo9UH137G4DY4BvQyJeTPBXksd3U0pOnQweIKhyLxH/zu2dZ
	AdD5pk/p6+SQjo7op6PbM+SLS9J//rCK+yIx3ybmyInL0YPaw9RAt4nBfW5FUSU/HUuAGfbNu2od1
	w3Outf29nR2luS55SJUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guMeV-0001do-O1; Thu, 14 Feb 2019 19:26:31 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guMeD-0001BO-AB
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:26:17 +0000
Received: by mail-pg1-x542.google.com with SMTP id m2so1287639pgl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 11:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2syAOh2G4OGCHhPfMkd8JNfHtkJm8hpP6JpgjrXSNMM=;
 b=q6e3FOHZTmmQzss3505cT/xH5CkXq+WIO7l/C5e1VQ8BuVvDv+MBGZhwRxd77mW2iI
 tCG4T7T7Vj4OpCEdiYID/htrKYOksv4q0FZfxtXuw4DXY4Y/0F8Gl/pXPtEBS7Yw7MCA
 cmdmjziaZOeZxT+g2QsC9oSx7xngknrQLPsWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2syAOh2G4OGCHhPfMkd8JNfHtkJm8hpP6JpgjrXSNMM=;
 b=WrnPt8BmSij3j+3Ec1wStI3rvRDOUBzsxRvwDlqTAy9UfLOPxhz0f80ACmgbvdCiXa
 YMYjkD6NYOFcs2dLcSWDa6jphpP6K62LY0gL909HgB59AI3y3BbHLlofJJJctw4J5R21
 y7qJzAcqfqKdOmvfNL8SXfZx1+Yg2ADjspkODb3DuOwR3IDkciO9jUf2JSNZOmQo7YF+
 CNgmZAs3gG7G1MyVRA++4pIGchz9maihCjbwfZKRMPjs6x/jfwiM2ByAH1sbUkrQCr9J
 li8Ia8r4WRLDQ2bN9Hma/TGsyycusOkkl4/usPv87ff08DaNhqfrH927B6hUlLNQVxs5
 EC5w==
X-Gm-Message-State: AHQUAuYV3ST4oHYq0zZ0iuxQLhBOQeulrZIFvcPQYDQglEbAQnpktaRJ
 iMK6zaGk3GsGBM3867wtwN4/Xg==
X-Google-Smtp-Source: AHgI3IaUIaaLaj0DjeiCs9lzTeYUZpLtwK6r4ls8yW9TJXb/UuzR7SBlm25xLXoG5M+AVVSqZSJKJg==
X-Received: by 2002:a62:380a:: with SMTP id f10mr5929791pfa.100.1550172372276; 
 Thu, 14 Feb 2019 11:26:12 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id k71sm8390100pga.44.2019.02.14.11.26.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 11:26:11 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v8 2/8] drm/sun4i: sun6i_mipi_dsi: Fix DSI hbp timing value
Date: Fri, 15 Feb 2019 00:55:38 +0530
Message-Id: <20190214192544.7314-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214192544.7314-1-jagan@amarulasolutions.com>
References: <20190214192544.7314-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_112613_593482_B23FCA00 
X-CRM114-Status: GOOD (  13.85  )
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

So, update the hbp value accordingly in sun6i_dsi_setup_timings.

Tested on 2-lane, 4-lane DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index d70a8c43a4b8..982ae6b17654 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -472,7 +472,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
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
