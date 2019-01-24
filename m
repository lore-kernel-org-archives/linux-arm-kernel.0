Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB5EC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:00:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D48218D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="US2L0IH3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ebTKTuOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D48218D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hGoVabADvpyV7vFnv/z5UZvGjBX68+L3OhNzVFxxDLI=; b=US2L0IH39WmQui
	PGMOdOwRGEWS4JI6+MOiWwpWULa6yMc1xfwKYKRm1a+J/xiz9z3T8/zeawUASACxvaqH3YvQ5xiIw
	FHs1Kl0h6VZ9I6M1tf3fMaLZFHBaAyg4Qh1pohFmWFxr4nRPY6trRNdqsDH6v1gezPmt1gLwlwm40
	PxyyMzHD1MbGRJNV2JdUiowm2Cr09TENWQ7gCp3zg+Xqw+p3FduEzcmcEbISA0QQIHPa2zffDDj9m
	m53aCKMiFEchw+eytqNDP6zV9VzXeNLwX4X8P0Pv5oyQchIn7WqAk76G5r704UEdSTRUsTQ/X07X5
	7UgsAzrY+y4tvtp2tN3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlAX-0007zY-EO; Thu, 24 Jan 2019 20:00:09 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gml9y-0007DT-KT
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 19:59:36 +0000
Received: by mail-pl1-x642.google.com with SMTP id z23so3391584plo.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 11:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a8vOl3skF2N3dkaRRYLofdwZfQDV/6WD5CsnhZdLWdk=;
 b=ebTKTuOVkL11ASo0UBwv/Mx+SzrHJ5oxFw3eMUKqwdsqzM4HdFzzv/TA4aIK7Y3Ftw
 TcXzrmY5ETcR8XSeYVhErcnmF+JPo+UL0E/derqnYwa+gopPyOAQPmygRzw2jvMdg71o
 V12iSQzJ2QeiT7Lxi5VBYJwZbP/np+wp/leXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a8vOl3skF2N3dkaRRYLofdwZfQDV/6WD5CsnhZdLWdk=;
 b=KVsl/HCrrGkpWRPYsoGZ4sm9F+2P/EoS6DUV5IbMkmA16k9mKNeChF23mMRETIkkga
 ATmUk6jU+RIaBvd0fbZZU4AuepDyvA3gW1QGUEaimKNyeQlrc2CnS5uwAUqLRzFtDMI6
 Ao1wH2i8ms3N6GG4eNcHKzyfMx8PsJlYPTG3W9P2KslWmg/Q52mlZ4lvsrgXPCjiW5VX
 Wu0bV9Z6c0Qd4JeDh6lIbmz7AOwUcg50lIbjeU3+vzBwkiir4lXl1oWmN5tz5FX0eyQL
 ocDPfvXnM4bjRUcGPfvSHj2SvLDAQKW3xk1OIPXy42PuCcy3zfAt+78ODheKtdDt4iP4
 T0xw==
X-Gm-Message-State: AJcUukdYNQBDz8/DNgvTHMC/71oeN9YDO0GkW2Yoo3nWPGQKrY+pkWO6
 fa59wBUoMp7bX1+wJx3kl9LnmQ==
X-Google-Smtp-Source: ALg8bN600OaZSBVU1MphHnvnL6Q/ASOz8fdtUlZH15Pf1qk+U2hWLSI1BdNwhM2H3XNJJT28S7ntjA==
X-Received: by 2002:a17:902:848d:: with SMTP id
 c13mr7959131plo.257.1548359973705; 
 Thu, 24 Jan 2019 11:59:33 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.11.59.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 11:59:33 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 03/22] drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
Date: Fri, 25 Jan 2019 01:28:41 +0530
Message-Id: <20190124195900.22620-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_115934_707222_5D07A857 
X-CRM114-Status: GOOD (  14.17  )
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

Burst mode display timings are different from conventional
video mode, for burst mode most of the timings hsa, hbp, hfp,
vblk are 0 and hblk is computed as (mode->hdisplay * Bpp)

This patch add burst mode timings and directly goto alloc buffer.

Reference code taken from BSP (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hsa  = 0;
dsi_hbp  = 0;
dsi_hact = x*dsi_pixel_bits[format]/8;
dsi_hblk = dsi_hact;
dsi_hfp  = 0;
dsi_vblk = 0;

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 813d5523f1c7..0f02bcc997a5 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -477,6 +477,12 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 
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
@@ -515,6 +521,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	 */
 	vblk = 0;
 
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
