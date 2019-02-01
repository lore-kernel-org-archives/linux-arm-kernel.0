Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C801DC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:43:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98945218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ndPLFZbx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Cl9237Zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98945218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8s7bwDST+fYN2kT17DOaCUcVLd3VQjAnSNWWdMCrS8U=; b=ndPLFZbxPyPfE5
	p4wC0OTZYmy0OQkRcULD4lcp5yyyN9pjeqGsnTKe+fkd63BrzkBNZWgxoEj/RqFGLuoebUxUHLfp+
	9qeRPCtMO9ImezBKOO+SsykAhXvNMUTTHhwv5Nr9O1BNM6J4tqfqoQCsN+CjvWPJAChkaUYWCM0wk
	Nfk52OdT36AAyZOnvUJHGwHcHb42grWYqeqzZvRUSFo00Y2Be6iq5xGo2uQg2mUdHnHD3GKCciDwF
	4b0wRur6GZdUeWyr4iY+erLKS79OmvlOPBnh/7nW4Knvzs5Pp5UOgDLM2NeCqq9As5XwBylJU1CYp
	Q8P8fCyFL7ccuVP68z1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpayi-0002vj-1X; Fri, 01 Feb 2019 15:43:40 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpaxv-000233-Jx
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:42:56 +0000
Received: by mail-lj1-x242.google.com with SMTP id u89-v6so6228701lje.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9CvRh+lhKmHHKkuw4aE/avnLB9iVsPqvkmbgt9/tcc0=;
 b=Cl9237ZmhAZM+nDRRTR+SVUVYqvlUfgRSp9sa5t8N1qJ5ZA805AQ4tH+TD7ztwLWST
 8x6nY5+r5Pg0cMmfgZQVhcedaM/NkT/5dX7jnxyrWO+XZyldYrdoqzcVr1Q4rZigE6uF
 af11TT8DYsZHj3gAuQ8EW1bPaTFA1jP5IDPWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9CvRh+lhKmHHKkuw4aE/avnLB9iVsPqvkmbgt9/tcc0=;
 b=YoHORQvnVnF7Nsc2UtkvjfLet6g2vGCOhgXr3+GHGJF3FOEz4L7WydmYiPqYcd21fC
 J1OJxYT/PN0bzswO0MoOujPkNExLuZ38fHwY2fGOZSyMFWlgvCWUjd1mW1b/czsjl6n8
 uMLYDxyz4tcuKkJ/dXIqvqm741r04RTSDugtjRtjJ8KmPTHGWT9eua+s+dl6M+wgT71Y
 cRtXW3Z71GxdR6beTFyfidYDTRuUHKJ5MWkvl9SAN1RgckM/XncmxCIj5CUSLHQj92Wg
 YsnnhLodfwf5M1bSHZ3ThbXQtgD+IGnthYrjj1k8gYPV1l+fpJHpnGvCjaqIcrMWzieF
 LC8Q==
X-Gm-Message-State: AHQUAuYRwXS8/D6ihghRK0FF5Dlvg27J9dNJ3y0setqPh222FbuQd6pi
 /bGDNZM8a5S+9lF4SsAqO4PF6Q==
X-Google-Smtp-Source: AHgI3IZSyZEjd/uuBNj8z5Gb1VKqc7/TdJVgFfWgCLRelTrh4xlWzq2odByzPCLT+9+tpu16YiiYYA==
X-Received: by 2002:a2e:9ad0:: with SMTP id
 p16-v6mr6897329ljj.102.1549035769983; 
 Fri, 01 Feb 2019 07:42:49 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
 by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.42.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:42:49 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 03/23] drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
Date: Fri,  1 Feb 2019 21:12:12 +0530
Message-Id: <20190201154232.10505-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_074252_012721_71D5137A 
X-CRM114-Status: GOOD (  14.72  )
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
