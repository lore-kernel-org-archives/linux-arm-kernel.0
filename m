Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA95C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6E3222D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="USEw/9Sf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JTxgTxcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6E3222D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bHft8+xMqoR+vg7WWf5ySCm4tsYhHeyT9iUODyXmqNY=; b=USEw/9SfpqmyBo
	oN7FplqLbSpKRqoUv+lEorZclI56b4Ktodv1HY0HKPp4USeiCM4rDnfLgyan5JbUEzGBWl6/PklMQ
	POAOOlp8MUfQjnGe9V5M4jcwBz0CYrOuPg9/Cq6cGmX44rppb9YHKwU5+dfIEecPOQysfxB8vax+x
	gM0pWroa8KQA3Fk/CHLncAwaHg2KuRCUjziXcU6lNm34wokRrRI86Ma7gV8GqjXVCt2LpaezIbQKz
	6xeSCYTLCG3Eu69e07s2TmYx9TSswtoX31q1YOzM4Qo2OqmAaqv0q7hcjdxsJlQYMCiSzF/C+MNSl
	tINHMdKy3IssSICkC0MQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guMlD-0006EB-Cp; Thu, 14 Feb 2019 19:33:27 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guMko-0005gL-1P
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:33:04 +0000
Received: by mail-pl1-x642.google.com with SMTP id f90so3659159plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 11:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5VMKk6PGn9i1BoO8FOUUuNIi7jW6XyTdiZlLmf93b6U=;
 b=JTxgTxcwgB81iNX1gtQGeVHqLDQQE8FtOIge1cIWQ2bunLOPZjShyWmZOlOpFEZmc+
 UjQ6nu7sPn3AYX/ZprtwNCfKHWcuQOJxbSZ2X1cYy3ArI6ZuYRKIRPpMY5kvy9GZCDEC
 dmisNUAInbvCt/1Cvuy9seOMYsl/6Oj6bgwE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5VMKk6PGn9i1BoO8FOUUuNIi7jW6XyTdiZlLmf93b6U=;
 b=P7yxR4qME8GKTU04Nx3rUVeX+D11n5+sRxE4VAxFlWNSSVHnq8aS5R1XEQUe1dQfIO
 7MXa8gPhfXAZEOsz//JHu/X/v7006VVpUViOO2FQkf4V3sz4cAa9eS9nnmHEtN/v5MhY
 HctJJHbj30RYWv32cFF07FjfHpuP+b120/z/Uvy2G7SucmqFkp4kO53pf7FM9YP1NiHE
 Vojd/A6mOETN0V0tdZq8YN42rg0Ua73wtuZc8qlb9AxoLb2JQISV6EZlaFTWHEGQShMd
 8BTUoCQAQzHAwD6bHqw4hM7WpGaQerPv7YU869c6kuXVfn8sUhmi6/81yty6Rcq65xHq
 KLGA==
X-Gm-Message-State: AHQUAuaLES4p1mPFcr9ftYg9rVHhT0F0MEhVXLQ9ghwjFNzafhy1Dtrf
 5XYBKcmI+MXEK3PhidbR49+9/g==
X-Google-Smtp-Source: AHgI3IaVnH7vqxvpWqtMvQ+l205UdbIhTt83vP7v58ygsEbw0XAdgz53meHQSapcpkoZoDen9txtQQ==
X-Received: by 2002:a17:902:8e8a:: with SMTP id
 bg10mr5933126plb.192.1550172781435; 
 Thu, 14 Feb 2019 11:33:01 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.32.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 11:33:00 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v8 03/10] drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
Date: Fri, 15 Feb 2019 01:02:30 +0530
Message-Id: <20190214193236.7504-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214193236.7504-1-jagan@amarulasolutions.com>
References: <20190214193236.7504-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_113302_104825_94A4D38D 
X-CRM114-Status: GOOD (  14.10  )
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

Burst mode display timings are different from conventional video mode.

For burst mode most of the timings hsa, hbp, hfp, vblk are 0 and hblk
is computed as (mode->hdisplay * Bpp)

This patch simply add burst mode timings without touching existing mode
timings.

Reference code taken from BSP (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hsa  = 0;
dsi_hbp  = 0;
dsi_hact = x*dsi_pixel_bits[format]/8;
dsi_hblk = dsi_hact;
dsi_hfp  = 0;
dsi_vblk = 0;

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 1a0707468121..4362d9df1da6 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -516,6 +516,12 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 
 	/* Do all timing calculations up front to allocate buffer space */
 
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
+		hbp = hfp = hsa = vblk = 0;
+		hblk = (mode->hdisplay * Bpp);
+		goto alloc_buf;
+	}
+
 	/*
 	 * A sync period is composed of a blanking packet (4 bytes +
 	 * payload + 2 bytes) and a sync event packet (4 bytes). Its
@@ -554,6 +560,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 
 	vblk = sun6i_dsi_get_timings_vblk(dsi, mode, hblk);
 
+alloc_buf:
 	/* How many bytes do we need to send all payloads? */
 	bytes = max_t(size_t, max(max(hfp, hblk), max(hsa, hbp)), vblk);
 	buffer = kmalloc(bytes, GFP_KERNEL);
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
