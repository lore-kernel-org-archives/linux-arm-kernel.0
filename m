Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79CCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75CF8222D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fqBjogtk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YR4mdKif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CF8222D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c+oy/k/gGZGIb7tAVwIcT1bVzJd75n0pswOEaJ31JN0=; b=fqBjogtkJRqZeo
	PHZQyVX/vL7+8OdMXiPXmOCfIrAhDEn/pSRpez8XaDySCgP47XoX5eaCAt1F+/vMaR7cwiEPZgJ2a
	8f4NA0LzykZxDtMq8lVorg3LHB23O5/zy07d4kmfKTtoFuEfXILc147DYFfyOFfLUDWcLnszwmwv2
	LVOLXkhk3hjm6Lon6neNynlfR+pjLy71QmExl+LUpw5DQ++uJF/jQZ4JzEzsyLX9jD4/xQxigFk5W
	rDjZwXss+2Dh4XEMHv60pVIR7+NwBf0/qtH/pvKPMJx5vyj03V91GRpoSu8pjY5XyuXIgcrcI+TVj
	p6Zlbr4WN2vCQIV3u88A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guMlb-0006kU-Kr; Thu, 14 Feb 2019 19:33:51 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guMkr-0005k6-Eq
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:33:06 +0000
Received: by mail-pf1-x442.google.com with SMTP id s22so3596879pfh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 11:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qvbRbLJNQrsLfwewB47cDz1+x+w3diwoF9YMEG+Lj2w=;
 b=YR4mdKifcOd155tlUu0XmyU8rruftlI51Kjs+rpvMbzCLOanKN7+Zm5SEIYoSPn0AD
 OYiFaiLBugYD2TndvL1ZHsEL5XyHwzRSMZSscmrHyVCwbhah+TgL2n14TCXsgLQF6rzf
 X1Csi3MkYq4O1WgnGF2Ikw+VrM2Fn/wHPhGyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qvbRbLJNQrsLfwewB47cDz1+x+w3diwoF9YMEG+Lj2w=;
 b=b3F5VjPIhhJ2g1QS+y3GANNcqf0Vwp/1peyxlP8M8KjyE2qcUE+pCrRdAURMcM69nK
 GXuiHxhLxbcYAIEnAYGioCpYgxH0nccBrNsiUOCGM7BLlOwGkJWW11BnKAq1TojiuF9l
 xnvUo6j0JegljuEpwrspuF1VeLztK7MrEAob5vVg1vEtkakvmtk9A12bTJSX+R8aKla/
 2PvU2SDQsn38Eup0gTLhHSb4dLw2DRTscciKkuyrnF+fUxjhVTfZhUvsmJymJJeOm+UC
 oO5dXdKvbp2+EbTr+SIzu7hDW5ZwZufIYI8ruj5EI17HG17FIxGI7z2QlnQx2lxGccz/
 squA==
X-Gm-Message-State: AHQUAuagfSqpBjTLxne1wObJ6q7gRoeqR8Um8PipwvHdp8dRPZRy97s6
 lAQzGuHusJvm29vuBUMlIVUaRQ==
X-Google-Smtp-Source: AHgI3IaXLCw5eOUQoSanll7LQS8yH4nSacOv4VCAnqLTy0+Ye++cPlgHKZ8Fr/lYbgeuA/sqStqOcQ==
X-Received: by 2002:a62:6e07:: with SMTP id j7mr5869683pfc.135.1550172784895; 
 Thu, 14 Feb 2019 11:33:04 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.33.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 11:33:04 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v8 04/10] drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
Date: Fri, 15 Feb 2019 01:02:31 +0530
Message-Id: <20190214193236.7504-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214193236.7504-1-jagan@amarulasolutions.com>
References: <20190214193236.7504-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_113305_495818_17CDA29E 
X-CRM114-Status: GOOD (  14.46  )
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

TCON DRQ for non-burst DSI mode can computed based on horizontal
front porch value, but the current driver trying to include sync
timings along with front porch resulting wrong drq.

This patch is trying to update the drq by subtracting hsync_start
with hdisplay, which is horizontal front porch.

Current code:
------------
mode->hsync_end - mode->hdisplay => horizontal front porch + sync

With this patch:
----------------
mode->hsync_start - mode->hdisplay => horizontal front porch

BSP code form BPI-M64-bsp is computing TCON DRQ set bits
for non-burts as (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

=> panel->lcd_ht -    panel->lcd_x - panel->lcd_hbp
=> (timmings->hor_front_porch + panel->lcd_hbp + panel->lcd_x)
   - panel->lcd_x - panel->hbp
=> timmings->hor_front_porch
=> mode->hsync_start - mode->hdisplay

So, update the DRQ set bits accordingly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 4362d9df1da6..a4360aed17bf 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -402,9 +402,9 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 	struct mipi_dsi_device *device = dsi->device;
 	u32 val = 0;
 
-	if ((mode->hsync_end - mode->hdisplay) > 20) {
+	if ((mode->hsync_start - mode->hdisplay) > 20) {
 		/* Maaaaaagic */
-		u16 drq = (mode->hsync_end - mode->hdisplay) - 20;
+		u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
 
 		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
 		drq /= 32;
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
