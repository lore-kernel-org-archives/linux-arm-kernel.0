Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F90C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:19:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1870F2176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZJsGdN9F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UQagg1uZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1870F2176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2uXqXTKlGjl9SR46Skc4k4qjnlhG5Zj+GaGYQSnXPhg=; b=ZJsGdN9F3cePyl
	+0k59Wth0rSJc4Apt2WIAdzdcdsp/GHOPI2mB33CZgDbErlwOHmsw/nmbu9wnJ+wvolytHZmpX1GM
	wJ5L6To69dzMzrAdxvT7wb2Fe1a1YSIUbmJXHS0uF+TBdZMngnA/5dLiFcW9Zx+FYiu20K2t4Yrw7
	xD6fky5X5IRvAmENx4hy3VAskvct5u1mGZqFnYVYFmRxTKRA1FgG+WcvM1gvhdWZ/hkP7b1MC1QXK
	080cP0YRBJBiar59L6gPO1xhRy8JxePajKQkbJHFT+aunabBCiNIZ7jkf5n519wnIwVN/Te/kLwUH
	Q78UPeBOL9mKKeP54hsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhtb-0000my-SI; Mon, 04 Feb 2019 17:18:59 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhss-0008UG-Le
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:18:20 +0000
Received: by mail-wm1-x341.google.com with SMTP id p6so758947wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 09:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DBzMlLxKyj6J+r0jihNlaESKZhODSHFO165otMN1QtA=;
 b=UQagg1uZ9/j9k50lQD2u53EZ2MVxbMaTxndhGbYaeNe9qcGnR9dl/FJUOD09IiA8yT
 BOnd6pAmPw26W8svdPieHILKiru6I9XSaQ1yObux1IoADOIAmJ76X3Pw8tI7Z6CRjLjJ
 UWVLqwGsie+6bxGfBbVAQZ05834R6rEO8FVGefE8bUKpVAl69mwZ4/6v5Tcvw64JHW08
 oSOevBbIZbAquyyhcNBdwms0AGfA5vEEHURdqUYpP6s4H+d/reY2Np7bg0ov4WDVxpIO
 bDf4S8JceiHyeiLwVUV45oGEEJdk+RmCm7fL2av/u6iFglDgWubQBXMjIXkxUTuhZ9Bm
 w5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DBzMlLxKyj6J+r0jihNlaESKZhODSHFO165otMN1QtA=;
 b=PO2spsDXydGqI2McQEM27a9kYAuPvVfxGV3plzN0jtsYSNqLbwa4wEMf6olfTkcE+L
 WlSjWR69fXQRx0Uu2BXcVQR2gfSmXyc18NdtqBS+kY0s/VdDsg8H+Agr0qwh9eAPl8wD
 XpkgiumiqomT5x1gIxXJjFPfKjYNrTtzTm04FdLOKlD/iQ/g9jLf5jhSL5u14e3SYqlx
 X46CMTik3pqR6kM/D1ec60/Y7kPjHjQbo6tNGzX7+uHGrwIC7o2s+pv5A712EjcL8yiH
 CtUl3/zhWeGCNY8dmjgGgitRRZZffCvuR5wJ2cje4XWNMt2ruGFLaCoS8r3Phw3VJWME
 pfwA==
X-Gm-Message-State: AHQUAubJNvANPReh5FTHXX44ELsD1xR/gNoLxp7rPHV545n3+7ZZas3s
 yYclPWkVJ5uCvJpdODorf2/0PQ==
X-Google-Smtp-Source: AHgI3IYqJtSnQdsdM9P8LVJfp5z8YkudyPrHujmJS78IJV90O5j7bTOYVEOvwerbym02FTcQ/KKjgw==
X-Received: by 2002:a1c:e484:: with SMTP id b126mr288541wmh.119.1549300692820; 
 Mon, 04 Feb 2019 09:18:12 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
 by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 09:18:12 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 05/12] ARM: davinci: da850: switch to using the clocksource
 driver
Date: Mon,  4 Feb 2019 18:17:50 +0100
Message-Id: <20190204171757.32073-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204171757.32073-1-brgl@bgdev.pl>
References: <20190204171757.32073-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_091815_106950_1AEE7EF3 
X-CRM114-Status: GOOD (  15.77  )
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
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have a proper clocksource driver for davinci. Switch the platform
to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 56 ++++++++++++++---------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index beb34ee42e3a..66c2ffd4885b 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -34,7 +34,8 @@
 #include <mach/da8xx.h>
 #include <mach/irqs.h>
 #include <mach/pm.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "mux.h"
 
@@ -436,38 +437,24 @@ static struct davinci_id da850_ids[] = {
 	},
 };
 
-static struct davinci_timer_instance da850_timer_instance[4] = {
-	{
-		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_0,
-		.top_irq	= IRQ_DA8XX_TINT34_0,
-	},
-	{
-		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_1,
-		.top_irq	= IRQ_DA8XX_TINT34_1,
-	},
-	{
-		.base		= DA850_TIMER64P2_BASE,
-		.bottom_irq	= IRQ_DA850_TINT12_2,
-		.top_irq	= IRQ_DA850_TINT34_2,
-	},
-	{
-		.base		= DA850_TIMER64P3_BASE,
-		.bottom_irq	= IRQ_DA850_TINT12_3,
-		.top_irq	= IRQ_DA850_TINT34_3,
+static const struct davinci_timer_cfg da850_timer_cfg = {
+	.reg = {
+		.start		= DA8XX_TIMER64P0_BASE,
+		.end		= DA8XX_TIMER64P0_BASE + SZ_4K,
+		.flags		= IORESOURCE_MEM,
 	},
-};
-
-/*
- * T0_BOT: Timer 0, bottom		: Used for clock_event
- * T0_TOP: Timer 0, top			: Used for clocksource
- * T1_BOT, T1_TOP: Timer 1, bottom & top: Used for watchdog timer
- */
-static struct davinci_timer_info da850_timer_info = {
-	.timers		= da850_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+	.irq = {
+		{
+			.start	= IRQ_DA8XX_TINT12_0,
+			.end	= IRQ_DA8XX_TINT12_0,
+			.flags	= IORESOURCE_IRQ,
+		},
+		{
+			.start	= IRQ_DA8XX_TINT34_0,
+			.end	= IRQ_DA8XX_TINT34_0,
+			.flags	= IORESOURCE_IRQ,
+		}
+	}
 };
 
 #ifdef CONFIG_CPU_FREQ
@@ -742,7 +729,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.intc_type		= DAVINCI_INTC_TYPE_CP_INTC,
 	.intc_irq_prios		= da850_default_priorities,
 	.intc_irq_num		= DA850_N_CP_INTC_IRQ,
-	.timer_info		= &da850_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 	.sram_dma		= DA8XX_SHARED_RAM_BASE,
 	.sram_len		= SZ_128K,
@@ -765,6 +751,7 @@ void __init da850_init_time(void)
 	void __iomem *pll0;
 	struct regmap *cfgchip;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
 
@@ -779,7 +766,8 @@ void __init da850_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &da850_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource da850_pll1_resources[] = {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
