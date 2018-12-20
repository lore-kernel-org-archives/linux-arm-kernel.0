Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE497C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:55:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C14F2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SjV5HSBk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FhO6jXCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C14F2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d1/zUC9GYtFtqiTXtf72R6jRD/j6FOrv6YhQRd6sIf0=; b=SjV5HSBkGTTQpQ
	oMIMqUnG403q82NxRh5vuYOVt/+X8PpooUh12alSLek8qbYGQL9Exaa3u1p7s2XDYd75p3n9iWUwp
	Dop5JluJSf3hOr9nqsBAHlAI0qEBBtmzgqt1nuYAGEsx0P7W5cX1c3mHZy8XVzG4sd8wv6A4xm7ac
	I/Dj02tLEWNd5kDBbHl9IBx/1PPR9HlEVRbpuLr1mgYVLqRTBqWzixNZeepHdvNeO9Pi1D+Hjn1y/
	PVyFnDLpum6P6fCdSZdaUu6DAFXhcr4NOG5hZqqTGlUjuFungctdaABLGV8hB7qk1gz2yYW0RdEAa
	10a+r/0gI1qbqC5Ael2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZxrk-0004Y9-AW; Thu, 20 Dec 2018 12:55:52 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZxqv-0002f3-Q3
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 12:55:05 +0000
Received: by mail-wm1-x342.google.com with SMTP id c126so2062494wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 04:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LrNl3IwBPVoOT7eCSWC64ChhCwwVumPx0DUceWWWdPc=;
 b=FhO6jXCTAOkYqprrUH7Dbw58ayINikQoRYAxUyV1kYB2NuYTVOokYSscoYmga9gjzL
 moqAL8CcrMrwkGTO8yZQyHL8JjJb4656N8ZALHqjRWbGpwnmRugK1npX3MtP0dqlYSbe
 ObVVNsaWJOGtpIJmBtKZzTDWDMlz1aYcq4+Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LrNl3IwBPVoOT7eCSWC64ChhCwwVumPx0DUceWWWdPc=;
 b=XsQcpJUH736AlJYNVcllAxbyRfTtOXuQ33wGRrEhlrS7evCer3qyvNqL/PfxRyNuqX
 Q+oJ70X67p1saYPOalm+4mXg64hKXGQ4KlyNMpzH978vSUdkl5MJUFeWNuI4i7dc/iug
 W/NynZIc+DGsGynWjnx2KVWCPyNq9UwB3/Pr0Pe91an6qiJ1PW1rWReJ/H6ebT7w2Jj/
 6atHHkxUCcpLEHgLwXFIB8+gWj1TTBrMBxLDOn9qzURNGfpYyXaSeZuLniKuS6sE52F2
 C6jLp4N0wVec3vvsYjyWvXarixWVLcGNrfLs1eGO0qw49DedbI950mI2d9FxCwIylmKO
 T4Yw==
X-Gm-Message-State: AA+aEWbKPD0+8fN/OCsrYRV7fCp6s0kmKc/8BssEFU2hRgcxSNYzMalV
 itvMer8+rar59f3t3yNJhZaNnCEY+38=
X-Google-Smtp-Source: AFSGD/UKw87i2Wm0RwmCPvyi3Kk9owBhff+Eq719ylOELjW2fIA4dcWzoEAsE1KXasnORldqPwfsBg==
X-Received: by 2002:a1c:d988:: with SMTP id q130mr11902264wmg.41.1545310491536; 
 Thu, 20 Dec 2018 04:54:51 -0800 (PST)
Received: from localhost.localdomain (ip-163-240.sn-213-198.clouditalia.com.
 [213.198.163.240])
 by smtp.gmail.com with ESMTPSA id o4sm8732756wrq.66.2018.12.20.04.54.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 04:54:50 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v5 2/6] media: sun6i: Add mod_rate quirk
Date: Thu, 20 Dec 2018 18:24:34 +0530
Message-Id: <20181220125438.11700-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181220125438.11700-1-jagan@amarulasolutions.com>
References: <20181220125438.11700-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_045501_867278_EA9E296A 
X-CRM114-Status: GOOD (  16.59  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Unfortunately default CSI_SCLK rate cannot work properly to
drive the connected sensor interface, particularly on few
Allwinner SoC's like A64.

So, add mod_rate quirk via driver data so-that the respective
SoC's which require to alter the default mod clock rate can assign
the operating clock rate.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 34 +++++++++++++++----
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index ee882b66a5ea..fe002beae09c 100644
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
@@ -28,8 +29,13 @@
 
 #define MODULE_NAME	"sun6i-csi"
 
+struct sun6i_csi_variant {
+	unsigned long			mod_rate;
+};
+
 struct sun6i_csi_dev {
 	struct sun6i_csi		csi;
+	const struct sun6i_csi_variant	*variant;
 	struct device			*dev;
 
 	struct regmap			*regmap;
@@ -822,33 +828,43 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
 		return PTR_ERR(sdev->clk_mod);
 	}
 
+	if (sdev->variant->mod_rate)
+		clk_set_rate_exclusive(sdev->clk_mod, sdev->variant->mod_rate);
+
 	sdev->clk_ram = devm_clk_get(&pdev->dev, "ram");
 	if (IS_ERR(sdev->clk_ram)) {
 		dev_err(&pdev->dev, "Unable to acquire dram-csi clock\n");
-		return PTR_ERR(sdev->clk_ram);
+		ret = PTR_ERR(sdev->clk_ram);
+		goto err_unprotect_clk;
 	}
 
 	sdev->rstc_bus = devm_reset_control_get_shared(&pdev->dev, NULL);
 	if (IS_ERR(sdev->rstc_bus)) {
 		dev_err(&pdev->dev, "Cannot get reset controller\n");
 		return PTR_ERR(sdev->rstc_bus);
+		goto err_unprotect_clk;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "No csi IRQ specified\n");
 		ret = -ENXIO;
-		return ret;
+		goto err_unprotect_clk;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sun6i_csi_isr, 0, MODULE_NAME,
 			       sdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request csi IRQ\n");
-		return ret;
+		goto err_unprotect_clk;
 	}
 
 	return 0;
+
+err_unprotect_clk:
+	if (sdev->variant->mod_rate)
+		clk_rate_exclusive_put(sdev->clk_mod);
+	return ret;
 }
 
 /*
@@ -871,6 +887,7 @@ static int sun6i_csi_probe(struct platform_device *pdev)
 	sdev->dev = &pdev->dev;
 	/* The DMA bus has the memory mapped at 0 */
 	sdev->dev->dma_pfn_offset = PHYS_OFFSET >> PAGE_SHIFT;
+	sdev->variant = of_device_get_match_data(sdev->dev);
 
 	ret = sun6i_csi_resource_request(sdev, pdev);
 	if (ret)
@@ -887,14 +904,19 @@ static int sun6i_csi_remove(struct platform_device *pdev)
 	struct sun6i_csi_dev *sdev = platform_get_drvdata(pdev);
 
 	sun6i_csi_v4l2_cleanup(&sdev->csi);
+	if (sdev->variant->mod_rate)
+		clk_rate_exclusive_put(sdev->clk_mod);
 
 	return 0;
 }
 
+static const struct sun6i_csi_variant sun6i_a31_csi = {
+};
+
 static const struct of_device_id sun6i_csi_of_match[] = {
-	{ .compatible = "allwinner,sun6i-a31-csi", },
-	{ .compatible = "allwinner,sun8i-h3-csi", },
-	{ .compatible = "allwinner,sun8i-v3s-csi", },
+	{ .compatible = "allwinner,sun6i-a31-csi", .data = &sun6i_a31_csi, },
+	{ .compatible = "allwinner,sun8i-h3-csi", .data = &sun6i_a31_csi, },
+	{ .compatible = "allwinner,sun8i-v3s-csi", .data = &sun6i_a31_csi, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sun6i_csi_of_match);
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
