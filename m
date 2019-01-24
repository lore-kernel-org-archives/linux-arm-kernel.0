Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC38C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:59:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA8C21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UmrFDyH4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="f0m7RZmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA8C21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H7dUf4DDVNaQh7ezdkaagGuzIA8rXo/j4qUxfsIuc6c=; b=UmrFDyH4nXA/fd
	NgQ+y6h7RnQgnkPMHEIYviAqAv0eQWb/TckiGh6eEe+Ek9FQn8It1+Ql8JgbWOb+DSc7F4N38/jjY
	3goXriTxBN6NzMT/EuoYFu9bslBVonEezEmcQckkypaaeULLwmTrXvtRsnmOKp7nKVPHpeIoVi5Hz
	r49QJLU9J0rwVA61qAFAVDHjy0IcSLD/BR8s3TorQ3PRIIkSDxONjEySF6Tm259lY4AMaMn37Wwx1
	CXt7ERbVBQ/s2KfhmtQ72MNDrDIuHJEv666i5sQY6e9ihdM2i6fpZ2mgDK4IezC7o0m05qZSfleBc
	yHDEMQ/PBX1MyilSf/lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlA2-0007HA-W0; Thu, 24 Jan 2019 19:59:39 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gml9n-00071C-42
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 19:59:25 +0000
Received: by mail-pl1-x641.google.com with SMTP id u18so3379054plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 11:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Cv7G+uVy+k+Tf6IPY0z7Yjji/++uyA4xCwVVFJCJxkM=;
 b=f0m7RZmyu24bHhy+RMBGhJS68qlkuPGVmNyOJ+TuYa1l8utHvIfQCUANzU1trU4H0J
 YUySIARQpI1o2XDCjOlsHDNc/rshvTFF+ioRKXwWDenXF7pOJQ3h8ohK7s+0C33gIMsC
 lVJMy7gV+a4YPVV+9K5g40DXtsvD59X1MvRao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cv7G+uVy+k+Tf6IPY0z7Yjji/++uyA4xCwVVFJCJxkM=;
 b=fZhO1yfM+DXIcz3iV3vt+cMtuhs3qiSwSV+8uv4wBS/sIz9xPJydduRYaHgt2w06oZ
 JNkV5IgW2z0nHRiQTKqh1BsSPXvzlRllE4kPi1zkfWKiBDE8tC7RMTNW/WXphhBTwoaL
 vWhaWjI0seQEPDJR8bnRTBBaGgT02xvL6m3T3JrpWNPoO2gub3sAGCwEqyz8MwLooJA9
 MN+Cnjr5lnf1kbWS6hKxWajdUEytU1zJp8nY/Tt5Q8dAhpEHYf5JYktfedK4RyO/x8JU
 BLk5WM3RyktQ0bEiCWQ7dzlzuWg6/z4Q14whalJZSq+ZnMBaGm6ZxLMTY0b9GxtYYYdC
 0fuA==
X-Gm-Message-State: AJcUukc4TZIMTn1ekZ+jK/Zp02cSd2GQ9r8G3TBAwqcIf5ZFXIa84N9B
 8YggpywCQqIm2LwT4t67zwvnUw==
X-Google-Smtp-Source: ALg8bN7Z4NMxU57+VzhbK4DXHjRQikjqU8XbsmcimCifrDQZOCQOb/CcTQAx3F3utejo5+REng37Lg==
X-Received: by 2002:a17:902:9a8b:: with SMTP id
 w11mr7699262plp.121.1548359962542; 
 Thu, 24 Jan 2019 11:59:22 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.11.59.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 11:59:21 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 01/22] drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop
 N1 instruction delay
Date: Fri, 25 Jan 2019 01:28:39 +0530
Message-Id: <20190124195900.22620-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_115923_498239_065D135B 
X-CRM114-Status: GOOD (  14.59  )
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

Loop N1 instruction delay varies between burst and non-burst
video modes. for burst mode panels it is computed based on the
panel clock along with horizontal sync and porch timings and
the rest it is simply (50 - 1)

Reference code is available in BSP (from linux-sunxi
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_dev[sel]->dsi_inst_loop_num.bits.loop_n1=
(panel->lcd_ht-panel->lcd_x)*(150)/(panel->lcd_dclk_freq*8) - 50;
=> (((mode->htotal - mode->hdisplay) * 150) /
     ((mode->clock / 1000) * 8)) - 50;

So, this patch add loop N1 computation for burst mode, for non-burst
which is already available.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index e3b34a345546..a5fcee750bee 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -354,6 +354,24 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_INST_JUMP_CFG_NUM(1));
 };
 
+static u16 sun6i_dsi_setup_inst_delay(struct sun6i_dsi *dsi,
+				      struct drm_display_mode *mode)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	u32 hsync_porch, dclk;
+	u16 delay;
+
+	hsync_porch = (mode->htotal - mode->hdisplay);
+	dclk = (mode->clock / 1000);
+
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		delay = ((hsync_porch * 150) / (dclk * 8)) - 50;
+	else
+		delay = 50 - 1;
+
+	return delay;
+}
+
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
@@ -383,7 +401,7 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
 				      struct drm_display_mode *mode)
 {
-	u16 delay = 50 - 1;
+	u16 delay = sun6i_dsi_setup_inst_delay(dsi, mode);
 
 	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
 		     SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
