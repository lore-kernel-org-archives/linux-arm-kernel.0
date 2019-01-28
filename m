Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3348EC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:59:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34EC207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="devPQO8p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="err1Fgtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34EC207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2F/5XWIx0dvI7ftbx2DVkCCSQIWhn3+LdETQf/IvO7E=; b=devPQO8pyLVLzk
	UjTaJuGwCS5gw9YhsStUFByhHGIcOr0EXGfWboBzklfhX5WeCLGzs3/HD3+C0tN+D0KVE1hkWL1dz
	OBu/dTt/ZbGMhKBwzmTLGqGazZ6wZk7yGLJapIzY6AqzLn+8yJkK8UbWmm7su+hSBgSBlyPxUrHcG
	RlRg1ML8dn5q7zfrdfMRxWgq3bG/BeZXfKiCLXIq7RF3kFhE2KasBqLTCcWhObc/gIWD68fYAlguE
	VjXkhisw+djn1l33KMVP7GjrVucB1l4S8XLLSgctBJwuE/ZaW8Ivkyf+RQjH6wruURrow+sorQEy3
	CwX+DSvXxh2jr7J1pTuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go2ll-0004y4-Uh; Mon, 28 Jan 2019 08:59:53 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go2lA-0004Te-QT
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 08:59:44 +0000
Received: by mail-pg1-x542.google.com with SMTP id s198so6957117pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 00:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z8VDizYWcDBY1PcHiFT6xo+JsUGwxuPfGjOUI9TV1l4=;
 b=err1FgtmG1fBSLcHxlRaz6SGJImdA51wKAt1OJwEKtO4t9tJyt0upcC1WHVW/0MHzy
 mHU7hdZ3+mNzWr3RKSL1E+xQrlxnDak4NU7bXWH2Rlf7iMBOEpQhb/rApAYPwILeQWhQ
 4XYjp7tei45k0byTsx7cmsb/iOyUqALF3t/Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z8VDizYWcDBY1PcHiFT6xo+JsUGwxuPfGjOUI9TV1l4=;
 b=R8qykM2ALLXNJenCdtYh+7kBfuHZ89k5uEj3gcEgW4/86a1jYudhQBM8GT22EqDJ6y
 HvQEoUhIMxcCPdjVDh042u/PTKfgc6hr81NKkTxCrpPykKTeDLEiBlLRM5S04SXzuAQu
 NjGEMrqp2nFYQf2sa9N+3k9O6CyrMDKR81riVhxI5ELUW6vvBeS48gp1TYP7o/orYKJI
 az+82DGGWnc5FRojVcmAtLrRv5tejUOD0C+B6lajvRRQH9jcslJ6Inp/lCvUiMK9SI/N
 yX1VohJRCM3SJ9JGeIHj7eMH2wqjjkc3iexXHdnyMDgTsG/35YOmvv9nIpRcSlKghOPF
 uj3A==
X-Gm-Message-State: AJcUukdzFrEQ2I1MLkKNH6F+foOUrtM90lGVrEouBkoOWj+0H9WTMCmx
 FBR0JPrjA4+WZcTNDYa1bKvltQRwuA8=
X-Google-Smtp-Source: ALg8bN5X3V3qfLnvHQjRDN0ccoS2WDEODgCbo7QWrN8XrPBc4OHQ95aJY3DFGiUhN8TOhOhbdkJ41g==
X-Received: by 2002:a62:5658:: with SMTP id k85mr20878597pfb.231.1548665956205; 
 Mon, 28 Jan 2019 00:59:16 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id o189sm60746245pfg.117.2019.01.28.00.59.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 00:59:15 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v8 2/5] media: sun6i: Add A64 CSI block support
Date: Mon, 28 Jan 2019 14:28:44 +0530
Message-Id: <20190128085847.7217-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190128085847.7217-1-jagan@amarulasolutions.com>
References: <20190128085847.7217-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_005917_611161_3AEF04C6 
X-CRM114-Status: GOOD (  14.91  )
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
 linux-sunxi@googlegroups.com, Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CSI block in Allwinner A64 has similar features as like in H3,
but the default CSI_SCLK rate cannot work properly to drive the
connected sensor interface.

The tested mod cock rate is 300 MHz and BSP vfe media driver is also
using the same rate. Unfortunately there is no valid information about
clock rate in manual or any other sources except the BSP driver. so more
faith on BSP code, because same has tested in mainline.

So, add support for A64 CSI block by setting updated mod clock rate.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index ee882b66a5ea..5ecdfbf9f6ae 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -15,6 +15,7 @@
 #include <linux/ioctl.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -154,6 +155,7 @@ bool sun6i_csi_is_format_supported(struct sun6i_csi *csi,
 int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
 {
 	struct sun6i_csi_dev *sdev = sun6i_csi_to_dev(csi);
+	struct device *dev = sdev->dev;
 	struct regmap *regmap = sdev->regmap;
 	int ret;
 
@@ -161,6 +163,9 @@ int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
 		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 0);
 
 		clk_disable_unprepare(sdev->clk_ram);
+		if (of_device_is_compatible(dev->of_node,
+					    "allwinner,sun50i-a64-csi"))
+			clk_rate_exclusive_put(sdev->clk_mod);
 		clk_disable_unprepare(sdev->clk_mod);
 		reset_control_assert(sdev->rstc_bus);
 		return 0;
@@ -172,6 +177,9 @@ int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
 		return ret;
 	}
 
+	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
+		clk_set_rate_exclusive(sdev->clk_mod, 300000000);
+
 	ret = clk_prepare_enable(sdev->clk_ram);
 	if (ret) {
 		dev_err(sdev->dev, "Enable clk_dram_csi clk err %d\n", ret);
@@ -191,6 +199,8 @@ int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
 clk_ram_disable:
 	clk_disable_unprepare(sdev->clk_ram);
 clk_mod_disable:
+	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
+		clk_rate_exclusive_put(sdev->clk_mod);
 	clk_disable_unprepare(sdev->clk_mod);
 	return ret;
 }
@@ -895,6 +905,7 @@ static const struct of_device_id sun6i_csi_of_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-csi", },
 	{ .compatible = "allwinner,sun8i-h3-csi", },
 	{ .compatible = "allwinner,sun8i-v3s-csi", },
+	{ .compatible = "allwinner,sun50i-a64-csi", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sun6i_csi_of_match);
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
