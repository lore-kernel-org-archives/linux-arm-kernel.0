Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83CDC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:20:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0E620823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GIwVqRQ1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="n97X88Tf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0E620823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fE7/ljtaHEzAOeI2yhTAamW0zVXSWmJgtKMpPbrdIVc=; b=GIwVqRQ1uCzUb7
	yfC1Rae/cQjKIHw4b4vwvEE6xEb8/o9g/EcKSfjwcGkA4dteB64FIselSboksbuhXjFe7KsJlH5dK
	HHp4UlQlLNeAXRxJSOwCmWzqeRRkSASargeft18zW46cddLOouZS6q2651/jVGBQLOfPvj7nr9aPD
	ITMhqW6uUVHFravkMvsu/v1Z6ST0CK9XyqXRUutbZ+VJdmmO7pVYOmFoupBE/dLr2q5DciaFNwCwJ
	CbsxEfuk+LnCZ8eByDlZ7nmF2/wAsHz29iL3smLiV5YuY/iaw4LhhXXd57bTRmGx2ghb7k+v+OigY
	OGa+vu3Ej3ykOZ7PAsIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhvG-0003ZX-Ez; Mon, 04 Feb 2019 17:20:42 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhsx-00009b-Vq
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:18:28 +0000
Received: by mail-wr1-x443.google.com with SMTP id z3so705870wrv.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 09:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=342TJAIzq0FojxH3IRoD/3JqW+OzNGquMTqCmzTMx4A=;
 b=n97X88Tflc/CoX9kL5MTs8i/rdGUyIHqdkOe0pwaHM+zariLoVmOXGbDphfU0VXWQ5
 u9eXr1rgIzDbvMMITmKuLNxwORgs9gxJ5jg7S/zbvpeSqaAGOyX9leVK4HmjbcslteE0
 gyuNWEdoyEfsr4gb8kB1W0m1LFkcXHhwPqz7BwoTIroMqfSiiISUU86RXDtQT9f1bfe6
 6P8FdftsskBD7a7BUGTSdEUj6X+f2qUqSsCqKmj3MeWqNU6SqDGeu2Vfqab0wDyZHzcl
 Ph2gOlsP3haMY5ABOj9hMUoYJouh9KP4QI/jTfra3kiwyU89Rd1n3cOzoVoCtiYWH2Vs
 oCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=342TJAIzq0FojxH3IRoD/3JqW+OzNGquMTqCmzTMx4A=;
 b=BpGh/hyqblS2wGQ5JECCd30SArrJ+2W7KCrLeUXivw98RJBup4SeXIDicThpAPx4cs
 YvqCTDfKvaDUncz4bZZcvIAtUu9LT3Cxyht36BbC49D34NRlgMop9yL9OHEsk4Y67bvl
 3DOkOqfraEjRP0pywcBKUoQgUronenPE1rCJsrmEo8BJZu2nW56WplM6pFBUghlARV5q
 /4e+QFymn5PWIgRzMn0SdjN4dXmW5OZMTJqxdYBUqqqhVJHoK23N7IJm25E48Pu72WSr
 XJAx+jVfZEiCMC+0iMvFkXdgaRhGiLG2g6Z615qrSm/6W7pzQ4cPQ/tgnSmDRfmM2aC9
 wGmA==
X-Gm-Message-State: AHQUAubqigIWeb57If4cSqDqVszMWPAdthCJkRKhOOWw024/fDHNkj64
 OQXaiT5nB1jAmxD/x2ox3Gaouw==
X-Google-Smtp-Source: AHgI3IaBumw6uiY+UQaRdb29WB2AOLfUPN+OEK5Mb90krRDXnrAh65h0mJ0AnQ+slltRxGcsNNd0sg==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr324094wrw.127.1549300698523; 
 Mon, 04 Feb 2019 09:18:18 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
 by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 09:18:17 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 10/12] ARM: davinci: dm644x: switch to using the
 clocksource driver
Date: Mon,  4 Feb 2019 18:17:55 +0100
Message-Id: <20190204171757.32073-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204171757.32073-1-brgl@bgdev.pl>
References: <20190204171757.32073-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_091820_320296_D1F5763F 
X-CRM114-Status: GOOD (  16.12  )
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
 arch/arm/mach-davinci/dm644x.c | 36 ++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 070660cfd93a..b80346954977 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -26,7 +26,8 @@
 #include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -558,16 +559,24 @@ static struct davinci_id dm644x_ids[] = {
 	},
 };
 
-/*
- * T0_BOT: Timer 0, bottom:  clockevent source for hrtimers
- * T0_TOP: Timer 0, top   :  clocksource for generic timekeeping
- * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
- * T1_TOP: Timer 1, top   :  <unused>
- */
-static struct davinci_timer_info dm644x_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg dm644x_timer_cfg = {
+	.reg = {
+		.start		= DAVINCI_TIMER0_BASE,
+		.end		= DAVINCI_TIMER0_BASE + SZ_4K,
+		.flags		= IORESOURCE_MEM,
+	},
+	.irq = {
+		{
+			.start	= IRQ_TINT0_TINT12,
+			.end	= IRQ_TINT0_TINT12,
+			.flags	= IORESOURCE_IRQ,
+		},
+		{
+			.start	= IRQ_TINT0_TINT34,
+			.end	= IRQ_TINT0_TINT34,
+			.flags	= IORESOURCE_IRQ,
+		}
+	}
 };
 
 static struct plat_serial8250_port dm644x_serial0_platform_data[] = {
@@ -649,7 +658,6 @@ static const struct davinci_soc_info davinci_soc_info_dm644x = {
 	.intc_type		= DAVINCI_INTC_TYPE_AINTC,
 	.intc_irq_prios 	= dm644x_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
-	.timer_info		= &dm644x_timer_info,
 	.emac_pdata		= &dm644x_emac_pdata,
 	.sram_dma		= 0x00008000,
 	.sram_len		= SZ_16K,
@@ -671,6 +679,7 @@ void __init dm644x_init_time(void)
 {
 	void __iomem *pll1, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM644X_REF_FREQ);
 
@@ -686,7 +695,8 @@ void __init dm644x_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm644x_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm644x_pll2_resources[] = {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
