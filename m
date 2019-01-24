Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D69C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:02:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2306221726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cP20GTwS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="M0xo5hHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2306221726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QYxGDv/haARZWFtbyG5VR789hJ0AS+1qTW44BkwZHtc=; b=cP20GTwSvF5Tf2
	XJlUeq/X1jmBvYTtzX/4KKtrtG2V7mi7SoyJJMEL2bWC75R/HxY2sGVJotVWNVyZ/9Q/XWtfqKOEL
	YNG3omfyIsEvtlgthTYee36UL3Tyn5eDS/r6erv8gfSLzEuIaZ90Qx0UBYcHDDDr2LX3izYdslpgu
	jq5lHqa3hTT2RKBAZ9oQ0Eoms68v1mzHjvh5G1JJTT2DOBjZg+nHwieVzSNU8S33l5be2JWhAVk+k
	9vV9LtcKke0RDlzTtIHUALCf82kOU0OYTUfcEJ4ab5gTzBKF2m+dilxk4XYUqX9KkpkxZ5Ex5UCgJ
	0VkwwOhOYVyQJUgwkJRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlCk-0002dl-72; Thu, 24 Jan 2019 20:02:26 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlAq-0000vS-JV
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:00:41 +0000
Received: by mail-pf1-x442.google.com with SMTP id c73so3510420pfe.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MNcVG7JjZJxYSjToIwzsBT7cF1LnDkJMtO8vjjM/iYI=;
 b=M0xo5hHQFL0meWnF0pmr5OQUf9Hqaz0UB3gfOzmleILi9XCpEOkGIioJrBKOYsBgdJ
 K+tdO5kFAonmFJ4uq/vBMttkV+fxKzs/zsrfrX5xrm+48bOYaHGbq1zgWbzmnopxZNl+
 uVQy+wwlBg2OPnKVoVmL9rGB96ny5/FV+qNmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MNcVG7JjZJxYSjToIwzsBT7cF1LnDkJMtO8vjjM/iYI=;
 b=TAT7xaUdPDBjwj0kzk7Gp3M0jZPC2j25xBQhZqokM7OLenolBN6mGQLsyPK4Xc3Lx9
 wqL3KhzJ1U/NdpymxsgjGlV3JS539A3WvW1X6UUEw4gOfVbvQnDzVxZ9B+49UqdAWPMD
 qS+0VJFNP/WRxr0SYwSfCPJrm0R1c/OOxPcGMnci0DeXV63nU1iTI81m8tnL0RTyyaH8
 hMcnHwuYAMatmQZTcIKzzUOCYuMF17I+u95xFah9T8lNDD7hj0DZYAF9cZnyLR0Frtw1
 V7O6LCAYvJRym/v98qzy/D2XCnvY4Jt7UZ1shp0h3oAB2Bbg4SQs89QYvLEEX6MDr8lq
 dRGA==
X-Gm-Message-State: AJcUukepG2DUnDZZdkAAQH64YIkZ0OUADzdU2jAd3HdJ02lq4vEtW7iC
 U/cSVMO4zpAdCdoTfNex88h/GA==
X-Google-Smtp-Source: ALg8bN6vo+jcgh3jqoCTLJjTd35KJOoRitbhzaHFwIUX8hICspRQhzy8BJ5Tp30SJbE8vuhczujTwg==
X-Received: by 2002:a62:44d8:: with SMTP id m85mr7989017pfi.164.1548360027770; 
 Thu, 24 Jan 2019 12:00:27 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.00.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 12:00:27 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 13/22] drm/sun4i: sun6i_mipi_dsi: Add support for VCC-DSI
 voltage regulator
Date: Fri, 25 Jan 2019 01:28:51 +0530
Message-Id: <20190124195900.22620-14-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_120029_287239_ADD1DAC1 
X-CRM114-Status: GOOD (  14.27  )
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

Some boards have VCC-DSI pin connected to voltage regulator which may
not be turned on by default.

Add support for such boards by adding voltage regulator handling code to
MIPI DSI driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 14 ++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 3d7c03161954..9be414131460 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1107,6 +1107,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 	}
 
+	dsi->regulator = devm_regulator_get(dev, "vcc-dsi");
+	if (IS_ERR(dsi->regulator)) {
+		dev_err(dev, "Couldn't get VCC-DSI supply\n");
+		return PTR_ERR(dsi->regulator);
+	}
+
 	dsi->regs = devm_regmap_init_mmio_clk(dev, "bus", base,
 					      &sun6i_dsi_regmap_config);
 	if (IS_ERR(dsi->regs)) {
@@ -1183,6 +1189,13 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
 {
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
+	int err;
+
+	err = regulator_enable(dsi->regulator);
+	if (err) {
+		dev_err(dsi->dev, "failed to enable VCC-DSI supply: %d\n", err);
+		return err;
+	}
 
 	reset_control_deassert(dsi->reset);
 	clk_prepare_enable(dsi->mod_clk);
@@ -1215,6 +1228,7 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(dsi->mod_clk);
 	reset_control_assert(dsi->reset);
+	regulator_disable(dsi->regulator);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index 257cca660da0..06cce0d0d3ad 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -13,6 +13,8 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_mipi_dsi.h>
 
+#include <linux/regulator/consumer.h>
+
 struct sun6i_dphy {
 	struct clk		*bus_clk;
 	struct clk		*mod_clk;
@@ -28,6 +30,7 @@ struct sun6i_dsi {
 	struct clk		*bus_clk;
 	struct clk		*mod_clk;
 	struct regmap		*regs;
+	struct regulator	*regulator;
 	struct reset_control	*reset;
 	struct sun6i_dphy	*dphy;
 
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
