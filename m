Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801CDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:19:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504F320672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VqBRmW3A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lvquzrG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504F320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xquKVdbIWpNuNXfaeElrIF1CVJg882Avqt9fu4Miu2E=; b=VqBRmW3ARhtaiI
	pDNTTXX0L/+hmEcw2lBRYb5Lioljtc++1aQFnMT5ySwWyO4vovcCGstlr9YlfLkdMld2lAAr9X5sl
	efUfHkRdBkU2qSzZD1CFc2lp3aUYd0UuL/sXZ4MBLNkF1cNrcJg9b2SbK/2j1S/Hr3iXeaN5lxgGT
	GuTDCyanbR/nbe92NvdoUVunm1W4PqzKm2GBvJpEEqJWOjy2JecXxD/hmpD97h8yDCs+HOqherHSJ
	waQnrdtcbR/xwZwCXmnc9XsFJxU9vdEfBES0lPcWbM0HtAAgkJyJS6ggZLZDhCxQ4lnf/giY9lMWH
	I4FLHFZJwnM4+cE0KciA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOHf-0001QI-HV; Mon, 10 Dec 2018 16:19:51 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOG0-0007dP-L0
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:18:12 +0000
Received: by mail-wr1-x444.google.com with SMTP id t27so11077146wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TxNgORGPoSCn3Oq9HEn9GoMFiwahxDYqmWRf1K3P8O8=;
 b=lvquzrG04DT0Y6bsbtOA+ZLoIGEvklE7XkuYHVBq0nhUBrl4xHRjAy8d0aNGFU11ux
 klqCRmNcoo8g0irOhc48Z5qjccbNYyTYTskDA+JQVBI+9QZNSbDjKPspgWEGimdGDFy2
 slUsatULEvlKJQKiznvGc7Vbpq4fseqW3Fup4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TxNgORGPoSCn3Oq9HEn9GoMFiwahxDYqmWRf1K3P8O8=;
 b=S+HV5phDw8cBHMsvok4x7VTExtD9l/cGa4wJI+ZcFIiXDXegAMeuA4pwBKOk0eV+TX
 wh99rBrX5CXhRpw0Z+bYPjtIe69qPGGI1//GC+9Q9d77v4rSbecxm3cr7cqp+6CBSpH/
 dk8ayxa+Vkz1p4M1iB1p5u8WcdhoNEy/De2cuNzyzM8POrqxQMdryLSmGRLjYFOZYKJj
 1sRDSqM8vsLExQE3VUKwh1iTo/S4zOFMmj193VMpKAjGX32E271mEa1wXvr/Fc1vX8un
 Ag0OFMjgfrJmtpgwkxfJZ7vMrydjpg7sUtLXmeD4ERHyFnVOXdpOArbCOUVfCJXujQQw
 5XKA==
X-Gm-Message-State: AA+aEWbmCxOM1ml3+RjsnaMpyAeLOIFI3kGE4XMEAzvYke6138z1Qc/q
 Jn6aBWlWzd/1KdfJ2uY0qf9W8A==
X-Google-Smtp-Source: AFSGD/WKoXN5Q1BGK+/QFKiIqyuJtSy532LcvwxbVFqOOwq141q0U/0oZ2d0GXXsJfPAZD8eAJY75Q==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr10124004wrs.75.1544458676335; 
 Mon, 10 Dec 2018 08:17:56 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.17.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:17:55 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical video
 start delay
Date: Mon, 10 Dec 2018 21:47:19 +0530
Message-Id: <20181210161729.29720-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_081809_098301_D778EDF7 
X-CRM114-Status: GOOD (  14.22  )
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

Video start delay can be computed by subtracting total vertical
timing with front porch timing and with adding 1 delay line for TCON.

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
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index c9b0222ebcd4..cb41fea4f3ee 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -358,7 +358,17 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
-	return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
+	u32 vfp = mode->vsync_start - mode->vdisplay;
+	u32 start_delay;
+
+	start_delay = mode->vtotal - vfp + 1;
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
