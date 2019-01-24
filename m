Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2385C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:09:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E37218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N7xZUojj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NDnnVVg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E37218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MMt0OhqKOtRofYG/RLGcfKhQHpwjThwW6ffwpI80na4=; b=N7xZUojj7RXhmA
	EpJfyV9k+CqPVbW2y7R+FsAF+gTtDlnHQrmdB0OtQoFBUVWf7x/8dmam9C6QjOdBn3bFjcE8Auuay
	qWaclhrgJMMTfoF95ra+NkyvIjTPOfT4PzX4PHY8+mS9yS1f6raqzIpiAycMMxm0nOjxVUkZnysj1
	VYlhC9ixUG0RczeKybzvgLdY9yazOpctoLzf2N98zOOLhN/fw99jUVQ8NWDGlG0wplQnDIrXnFveB
	cWTnYn0vwjm4Rrwe79g8WMuQ6M+uNuouB6GTrxmdydfwM3HtHfYgrXhktodbosu66dTj0gKdxZXsF
	S8775uF2oIiomZerXbaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmjQp-0002GM-TG; Thu, 24 Jan 2019 18:08:51 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmjQS-0001uv-Pe
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 18:08:34 +0000
Received: by mail-pl1-x644.google.com with SMTP id w4so3257364plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 10:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UF0ie0AFcUOJKnp5dQnoc9GbuzcXmNAC6ctNdvT/vFI=;
 b=NDnnVVg9N0w5j1eh1QJCTCPhT7lwbq9Ao11qqMbunE5BM5940dxN0lbptZCCdXzKU5
 Z+Fkc6FcGLYcT/+cPt7sbICMX5UtfFR5j+Ie4Sdx+0YKgPE4+2fyzU8QTKl9ZDNFYbZZ
 wNgxqaNhvZdfWWIGu16fr+eEZkIyMttuBGx+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UF0ie0AFcUOJKnp5dQnoc9GbuzcXmNAC6ctNdvT/vFI=;
 b=d2QxT9lQwRBfcbh8y6rWLg3R3CGM1DnsL/0YTc4b+StuRNg+i6i1QAI+3RoQM5mwKL
 vr0A5U75I+b2BZVuC1FpxIahEWXGKyt6+MD56TLutRO/Nes5pLReEi3vMHODSAWpz4jY
 cNW6OnwFiQReG1fjgeqF0AerdCJskrFW2M8k1WiXl4Mu0H7uf5WTNu/MqJMKKOEOC0r7
 26IGe8NF/dcHHrSJOKXrzimkHlBmb4RhwOfokNMTbxx4L1z69UQOxnFuQJNFH3aGPltO
 +DcGGF+LnHOlbD6FaBrRBeFnPwEYvB0wMvxKacE0JNNM0nfFYqIt1iUQcgQ8t4k8q6mF
 F7lA==
X-Gm-Message-State: AJcUukdEJ/pQmEHStYMCuxtlNO8ZD3yJUZOMxXfx9PSL14RIpmxrvVUG
 HviZPisB/qHL6Pdtq9hFw/4sew==
X-Google-Smtp-Source: ALg8bN6gvz0ooTP/Bgag/ZsaxzHTDVYxLlAJYp+VPyEO8INABlTb5oDJjjG601prTqUveq9BY1KhUA==
X-Received: by 2002:a17:902:9a07:: with SMTP id
 v7mr2332887plp.247.1548353308049; 
 Thu, 24 Jan 2019 10:08:28 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id k15sm36141551pfb.147.2019.01.24.10.08.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 10:08:27 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 2/5] media: sun6i: Add A64 CSI block support
Date: Thu, 24 Jan 2019 23:37:33 +0530
Message-Id: <20190124180736.28408-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124180736.28408-1-jagan@amarulasolutions.com>
References: <20190124180736.28408-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_100829_534739_17E9C98E 
X-CRM114-Status: GOOD (  15.88  )
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
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index ee882b66a5ea..cd2d33242c17 100644
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
 
@@ -161,15 +163,20 @@ int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
 		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 0);
 
 		clk_disable_unprepare(sdev->clk_ram);
+		if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
+			clk_rate_exclusive_put(sdev->clk_mod);
 		clk_disable_unprepare(sdev->clk_mod);
 		reset_control_assert(sdev->rstc_bus);
 		return 0;
 	}
 
+	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
+		clk_set_rate_exclusive(sdev->clk_mod, 300000000);
+
 	ret = clk_prepare_enable(sdev->clk_mod);
 	if (ret) {
 		dev_err(sdev->dev, "Enable csi clk err %d\n", ret);
-		return ret;
+		goto clk_mod_put;
 	}
 
 	ret = clk_prepare_enable(sdev->clk_ram);
@@ -192,6 +199,9 @@ int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
 	clk_disable_unprepare(sdev->clk_ram);
 clk_mod_disable:
 	clk_disable_unprepare(sdev->clk_mod);
+clk_mod_put:
+	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
+		clk_rate_exclusive_put(sdev->clk_mod);
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
