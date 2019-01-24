Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2596C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:02:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8156C218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W8cjLNeP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="a90IHH49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8156C218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fioFIvgNl3hD5Cj40gulkEnR0M8NU+M4uwzunJKmt+A=; b=W8cjLNeP0vHw7Q
	yoFP8Fxpw9vSlfwJ6IegH+7xfB8L4IHkQsQFTFtCvgArqayChIwt1Abg+RcC7jNNcU/qtPU0GK0zH
	tlG4EKU2SHpzSerp0amoL8AQ/6+yird1UTdeWsbouc4H9VrZY3U1s6H4GJT2x8krvigQW7ipGGDj6
	MBHVc6aMuGRew+3IrWrP0nQgx0Ds5XSdjND1RZo/XMggOaJIXsEOOCWrW2+tB09EH1ZxDnuCLAT3T
	3Rqc93M3Ey1hx9wigfVSV9iYLwbNN+mJmSJK5ULFOP+xzfOT/3oH/f7GcN7hznzVbjRSXWNB3Nifb
	B8hfnugHMDX69HdCMHWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlCT-0002P2-FA; Thu, 24 Jan 2019 20:02:09 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlAR-0007iU-CG
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:00:34 +0000
Received: by mail-pg1-x543.google.com with SMTP id t13so3115126pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7Mn8TUKedPpPTwJJGFCwGJQpWISkySJ1aVESwLSs9Og=;
 b=a90IHH49RLC8u6YgVR2YrGTkKeb3Zwe1s490sZYOmkA5ikOdYurAIGn40rdO5IJLLb
 WaLV6ku6UwDgFYLAAWlsDvXATmill3rfsWge2+kK1a+bu4P/SrhiZafvGGiVqO+IQ3iF
 KYtVn4JY2oow8J659KR1jUYFF4tpbwGufMF2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7Mn8TUKedPpPTwJJGFCwGJQpWISkySJ1aVESwLSs9Og=;
 b=niCiBg9ikkb4s5BvAr4zApB0QyEE/BkN+LJr8jcfRMjqGpaGhoH1TfkG6bsErbpHxn
 pXqjQ30IopP44UOvKLmSe5ZmfFwJKagQUEQutfUpr9exPX9uptNrUGMTD4NR8PW0R5n5
 jSAPlqRx5AvwBlJGRTPhTUJTCFI16Lg7WkN033k7sKT1oecQVTXFowGjZXC3a8YV5jp3
 OStX1Jop3WnSLsPKsMx9GEx0KbxcW4UkJ2Q6c1+fjvfBoaD44SdWVspuer9+WswatSGH
 TXbnXrl3fh7n9eEAYHIZzNeNsrX9JXJIg5dl4/bUpeJG2/gPGi6G5c+oQAoH7yByojjN
 WaqA==
X-Gm-Message-State: AJcUukcqU5ItlQnWAwtKNcQmetTMi6EcKxjQpoC6O/kwPsHwV7VXoQ9U
 ZKH6ttoC/+xX+JYz2DHHdBofHA==
X-Google-Smtp-Source: ALg8bN4cAGeBI6s1ZiVbiYz22ae57CBUg/beYIPEDJ8uj3kLe/zNBcz8/iJJHjtbyolmzAsMvMZrgA==
X-Received: by 2002:a63:7e5b:: with SMTP id o27mr7163496pgn.214.1548360002252; 
 Thu, 24 Jan 2019 12:00:02 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.11.59.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 12:00:01 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 08/22] drm/sun4i: sun6i_mipi_dsi: Enable 2byte trail for
 4-lane burst mode
Date: Fri, 25 Jan 2019 01:28:46 +0530
Message-Id: <20190124195900.22620-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_120004_143227_3570AE69 
X-CRM114-Status: GOOD (  11.90  )
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

For 4-lane, burst mode panels would need to enable 2byte trail_fill
along with filling trail_env in dsi base control register.

Similar reference code avialable in BSP (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

if (panel->lcd_dsi_lane == 4)
{
   dsi_dev[sel]->dsi_basic_ctl.bits.trail_inv = 0xc;
   dsi_dev[sel]->dsi_basic_ctl.bits.trail_fill     = 1;
}

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
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
