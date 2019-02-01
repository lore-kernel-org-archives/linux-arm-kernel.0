Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93815C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:46:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C4B20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O7ngpw4k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UCcTSHtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C4B20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qYZbQwaUxAVUOhZRgJWMxYxcTnotmDQVhHelHdiGyhk=; b=O7ngpw4ko9Kfor
	Po3IQ/SUZHLa7Z/yrwFN48fjeI961Dp85gqQHokfnSLhxh+fbbWGuK43CUuo2WacSo4mR0ek2qPko
	UtevchE+NLw4sOX8ryxQ5lMwA5+YhY0nNLPwvyTEmZkdFAXMJKxxCaiuWVKt9LV/a24Mud0WsGbJ7
	zsxXSs1ve5i5bjMxjBJzaH0tCFQvQRZ8YgUnAT01G0iiQ15h8HAMb6dihSbZu8HnBdrNFvg07vnux
	SfXI0PuRSgwKMM4m7EOVnGKFry5uePZHqpAFb4fq01xttxbApLiUQg1OwHPXWPHJ0Sbcq9M+kpfQU
	ZCmZoPx7n7e7/KCqTuOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb1S-0006mG-IE; Fri, 01 Feb 2019 15:46:30 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpayB-0002L4-Kl
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:43:17 +0000
Received: by mail-lf1-x144.google.com with SMTP id z13so5358930lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6Z4BLOysdiax7MmotMn3MzsppFr/+7u52EIpu5QtmCQ=;
 b=UCcTSHtqQyZnzSq/YCVjITgW9SL+rYOWamwIZt/a5GRcUvNWOJ5KLBekDrH+KyPWaE
 ROZmEU5+1wuoPb0TpLjEW9suvFeBv6eR2IRCFJMuBkouqkqNBTM98+nOSDHM+51yU9mT
 rgz821U034S3Ug+MUGsGWw2oGIQzV2Xt5nh50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6Z4BLOysdiax7MmotMn3MzsppFr/+7u52EIpu5QtmCQ=;
 b=QEdWz9vqTas9nxlh/HIM1D4ksEFefXe0VrfwG2JdDrsiWAGJ6Qw423KiJoIvTaBRkf
 Eq8ylAzVX3usbk80YBHpfmhwStvP++X+FsQFb9VLsULxiq2P5DZMUKg5+JLawxLSGhQ0
 stArCK8tmCEiaEWe2aDsHUBzvumNTC47kk/2qRAVbBKL7fHGQVMR623ZkgNeNVESGm/p
 lKHHRoUFXM6Zx+ENmtLipMFc2FU9Y7az/nQkys15o+puHEBvhGPIJhZv5alFeBHc7Jhy
 ka6x4fZmwq0tCo8ExGgUXhVwvx02f79mV0chgeSoVkNeowbAkcgdFD4GhytpLi+ZBagA
 zdmA==
X-Gm-Message-State: AHQUAuZp6RHUeW1hRbZXshbTT4474hRTL66PCAxktzUbsPDeY3d0fe6f
 5IhTYalDUOWHYyTWy/jRz1haGA==
X-Google-Smtp-Source: AHgI3IbtqSTHpuA1aj1DJ/6/kF0i3pJ6sxisD5EjqO/e0D8GaujIUdZrlwN79CvMYK7jeQLgGsFonA==
X-Received: by 2002:a19:ae1a:: with SMTP id f26mr373674lfc.86.1549035785900;
 Fri, 01 Feb 2019 07:43:05 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
 by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.43.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:43:05 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 12/23] drm/sun4i: sun6i_mipi_dsi: Add support for VCC-DSI
 voltage regulator
Date: Fri,  1 Feb 2019 21:12:21 +0530
Message-Id: <20190201154232.10505-13-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_074308_486383_CE376D8B 
X-CRM114-Status: GOOD (  14.45  )
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

Allwinner MIPI DSI controllers are supplied with SoC DSI power rails
via VCC-DSI pin.

Add support for this supply pin by adding voltage regulator handling
code to MIPI DSI driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
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
