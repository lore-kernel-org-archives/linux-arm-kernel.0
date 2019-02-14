Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDF8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:34:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C85021B1C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gWVaFIDC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="G6kR7dmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C85021B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cXMU3/YukSE1CtdT1gZm/zyGEPZ4HScpEsAW7EprwIk=; b=gWVaFIDCAJp4s+
	wHOZfIKTN8XqDpl/bsHRSMByGVMbA2VSw82I98xSH9q8RFW802zg9mxT7U8TwgpzLkZ4TUWBdYach
	UGCQo3aba6FUNl+Fp6SmuXLuzsYO2ZVyoYRXFLcUWic0cDBJMAX9hfOWrazUTW8E96FTRK8JFmZbI
	NEVPqama8S0LyFbDxUL1Zes245j4nXiQttmrxZRLGLLecLvgBsCdukrtcg1xCON+VOzyE5QBWq/Xu
	xdM4ZYLAb1n7sTyOmCZKBTdBOsahQkqP7f5mNc+960m3M1oVmmRQP456uq3dbUnDUQVdvTW0OD2iE
	PLYzq5/dRLBFB+J6gU0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guMmP-0007mI-OC; Thu, 14 Feb 2019 19:34:41 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guMl9-00068Y-4l
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 19:33:41 +0000
Received: by mail-pf1-x443.google.com with SMTP id g6so3576132pfh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 11:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=19y3NFakPeHXY1zH8KnDf83WNrHHUKHDkZ84jCJtIp4=;
 b=G6kR7dmHa4ZyWHpN3fO0+0fN7GZ6QTCxKC2gsrRJZ4n7Rpa3N98OGiZMpah9yIffl2
 KxaQJZdscp+9MXf3VA2OC7nVh7fC7mpuJGLNrD3jJ70b29DsO3NxhqcsGsGqXXAzNQLq
 I2eI0p1717HVSVxkb6F803/d/HsF5Fv4QZ8FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=19y3NFakPeHXY1zH8KnDf83WNrHHUKHDkZ84jCJtIp4=;
 b=TAH/PoM6RBlseUs0Q+KIXoOj3w4hrLbqgKUEmC7rxcZmdpRplUrT1xGO2xG1aDzx83
 xavHnzoh1l7OkWrtIxUWGCu1erp5j8sxc7neZ0h2iWY7ra0ofM6szP/qlqeerkmw1P2G
 bGGgwkL2xXbAj2IYupA0P48UAw4M+ijR9jZeHnjBUfUlD/4X43kbw8DHbm6lX4Va7bQ2
 plInqHHIdP8y5c3Bn7L5VtPTwZEIET5P1cb7MZ5rNtaxkMM4pFYf/zfvvR2/v6t903kC
 NZ56Dv1pRwZizTl6YuHgNypw7Dzy8elJuOBlX5SGWzdE6AUfHgxzvxX3PdCKQthdM4s4
 +6pg==
X-Gm-Message-State: AHQUAuah993NNGP/8e/EiK+yN8nxUhYuLVPgfP5IE3R2AfQFXhlS0xA5
 kilVKB/p1rob8P0NpX5GjRMGAg==
X-Google-Smtp-Source: AHgI3IaiQm+AOueGS0W7QlK2nb6SV5QrYhhCcGjVaQOI8XBvu5vulXxgbm/qCrHac+tB3G2fAiUu3A==
X-Received: by 2002:a63:8b43:: with SMTP id j64mr1458946pge.332.1550172802340; 
 Thu, 14 Feb 2019 11:33:22 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.33.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 11:33:21 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v8 09/10] drm/sun4i: sun6i_mipi_dsi: Enable trail_inv and
 trail_fill controls
Date: Fri, 15 Feb 2019 01:02:36 +0530
Message-Id: <20190214193236.7504-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214193236.7504-1-jagan@amarulasolutions.com>
References: <20190214193236.7504-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_113323_753991_CA8AAE35 
X-CRM114-Status: GOOD (  11.77  )
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
index 63b83b47cf0d..ec9424b6da9e 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -34,6 +34,8 @@
 #define SUN6I_DSI_CTL_EN			BIT(0)
 
 #define SUN6I_DSI_BASIC_CTL_REG		0x00c
+#define SUN6I_DSI_BASIC_CTL_TRAIL_INV(n)	(((n) & 0xf) << 4)
+#define SUN6I_DSI_BASIC_CTL_TRAIL_FILL		BIT(3)
 #define SUN6I_DSI_BASIC_CTL_HBP_DIS		BIT(2)
 #define SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS		BIT(1)
 #define SUN6I_DSI_BASIC_CTL_VIDEO_BURST		BIT(0)
@@ -482,6 +484,10 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
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
