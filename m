Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C918C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:45:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1808218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hlljti5t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="L5Yb0b0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1808218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ROLM/R2Vzt8/9r0AY8m6OjMxnrj/80Yn9Wf0bb+S9GE=; b=Hlljti5tF99dzl
	PjCLY5fO1IxWwexqnJyMtAuPu3ti1PwuY96e/zr8imAKHW7JT9e6H92Tsc73hfAduzIpkOYngO1e0
	+RVFtHPLEX38nKCwkhKMZnkA4iX6/ug+tYoWCZ0b8Pd0k6EFKMVloSz3CaHha0T0/0EzxYXXVjL/7
	GQJBUfq34jXzAvwZtCkdpxt/ean8HpMpikBGwCvif1ujIDM6hsAeaox2vJEBjhYOnPm8q+WxuLO0k
	ia63mNwvNJNfG64eiXBJMEW5EjOhKRE4/ACUdx2qz6f/9rcxFKqb4otVuzy1XFQKwCEnz9nbuU02K
	ayjlTleJVdc3avPkYF6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb0I-0004oK-Qq; Fri, 01 Feb 2019 15:45:18 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpay4-0002DY-Mn
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:43:08 +0000
Received: by mail-lf1-x141.google.com with SMTP id i26so5420977lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=84THfXXcgvHcJWr1/uOYg32V3kLlV4Ule+FUJsuojRc=;
 b=L5Yb0b0JI9GGktwopEnSvepURroFbEHVxRtM15IoDKL1JhwJG3ZBwGQgJ2sh3Rw5TA
 iDnws8KdDnCZMRbe+mXF69inQx7rAj9LpRRoXCzEOHZ8qyoDBHVXGo5T0GGAVuQsJbx/
 kCmLrxPE+erOMMqggrGIWCRrZH6tHpGsSk1N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=84THfXXcgvHcJWr1/uOYg32V3kLlV4Ule+FUJsuojRc=;
 b=gORzC+7uOkm6SDlV79rtmniK+blmBQB95TGr01AJrAfGW3EzaxcY6QOUkRodQGFsTL
 e2c8UfcT9OyUAEo/ZXG32Rm7k3QluHEQEmM4r6tVBinzr4zSKLPSE4OKJSf2ZQqngjXr
 VIqofN/M3l/zUsjbDQJXbIN2UPbDOP7UmVpC49+bpx7K+mxncZ4w7aQSveh+5JhOaZey
 Zc57o4Kee5fclvTWwH/+2asuHJRgTD3Nw3PTqizh5xZ+H/Fv8qaDPTSULT65p1AlBjsF
 E1WY4YoYz5mVjMbL9jrhPMj4fzKJjAxQ8y7cDdQNh7inz5T4aOc3L4MozUAXrcqWgg18
 FhOQ==
X-Gm-Message-State: AJcUukf6P7wj1/KFIL4G2NtVzL5OkoYo/ozlLAisrHQ9/mtfrEW4lXyC
 7IBsV4S9T5twVjBC/eVeev3JQw==
X-Google-Smtp-Source: ALg8bN7eWAS4XWIfCIU/GKq6nDCT+Mcco6ruQsm5PRsdG39i7pjM42SH4WVYRmLXcxOYg7dqPiZlSw==
X-Received: by 2002:a19:db82:: with SMTP id t2mr30736640lfi.130.1549035779099; 
 Fri, 01 Feb 2019 07:42:59 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
 by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.42.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:42:58 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 08/23] drm/sun4i: sun6i_mipi_dsi: Enable trail_inv and
 trail_fill controls
Date: Fri,  1 Feb 2019 21:12:17 +0530
Message-Id: <20190201154232.10505-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_074301_352444_29FFC14B 
X-CRM114-Status: GOOD (  12.25  )
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

The burst mode panels with 4-lane would require to enable trail bits
in DSI basic control register.

So, enable 2byte trail and trail_env for 4-lane burst mode devices.

Allwinner A64 BSP should also relie on same setup for enabling trail
bit in DSI controller.

Reference code avialable in BSP (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

if (panel->lcd_dsi_lane == 4)
{
   dsi_dev[sel]->dsi_basic_ctl.bits.trail_inv = 0xc;
   dsi_dev[sel]->dsi_basic_ctl.bits.trail_fill     = 1;
}

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 46ad142e66e8..a2ad9fa7f8d5 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -33,6 +33,8 @@
 #define SUN6I_DSI_CTL_EN			BIT(0)
 
 #define SUN6I_DSI_BASIC_CTL_REG		0x00c
+#define SUN6I_DSI_BASIC_CTL_TRAIL_INV(n)	(((n) & 0xf) << 4)
+#define SUN6I_DSI_BASIC_CTL_TRAIL_FILL		BIT(3)
 #define SUN6I_DSI_BASIC_CTL_HBP_DIS		BIT(2)
 #define SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS		BIT(1)
 #define SUN6I_DSI_BASIC_CTL_VIDEO_BURST		BIT(0)
@@ -464,6 +466,10 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 	/* enable burst mode */
 	regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
 	val |= SUN6I_DSI_BASIC_CTL_VIDEO_BURST;
+	if (device->lanes == 4) {
+		val |= SUN6I_DSI_BASIC_CTL_TRAIL_INV(0xc);
+		val |= SUN6I_DSI_BASIC_CTL_TRAIL_FILL;
+	}
 	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 }
 
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
