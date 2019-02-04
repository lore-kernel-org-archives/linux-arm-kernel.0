Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7621C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:21:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B718F20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="twTAlR1f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xB7T4utP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B718F20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AqwJ4ctbR/5GO+qwhcfVv9ABFh7l0gWo6iQO/2aLLCo=; b=twTAlR1f++QK9+
	Z5FtYosNVqCdAV/mlOetuu6pv14ArhkxxsTOIjzafV2++W11wyec0G/nDhQkjkrp6SSv/U7jNqONv
	UzvXX/koR4vMQnoL+Ema+Zb5hrnntWzd8rG+XGuaW9H8TCDCbU9nRCzJ6C0yss/PpcK7jkpDDXz1Z
	XZWvPTZpdFX91E0jDHYZJWxr/H/GmkSV/cOCZ4z54SeSCXrqLFv2oNHYrGL+g6HBMMTs5pmhF00Ep
	OPBH2oTwkirAzfOCAmCaW4ZSSVPH+8o3JFuchUapnJDN/byCGSgjgw1oe/7VPTg4AqBTrso9SOa/k
	QBliVa1MgokvwLMfiv9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhvn-0004MH-6P; Mon, 04 Feb 2019 17:21:15 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhsz-0000Az-Cj
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:18:30 +0000
Received: by mail-wr1-x444.google.com with SMTP id v13so691264wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 09:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s7f+IdClyq4iN+qevcxOTQ2pG6vC1lbkrjwR3WneXQM=;
 b=xB7T4utPO7HO4AgQ2QdEsSXWbt1pEVNOw4Cb/Dlp/6rNyrvRCtD0V0wt4ZSX00TIl4
 /yWD//aJMI1ccXMla8gTXTKUvQMGgWxbCn7NjYXtvRZUD/MGWDd0qWH3INPCo5e9JE9J
 5BrgzHYv+FWHfrycPNc6BJHPDAjONAvFcHHJTH6RrWU60FVampGZQKxcQ1x4BsR/Byqd
 YOBZxGNdMe8rZobnmVvTJdVc/qgZM6oI0xaX65gWIcSU35tJdQtfZNmZVuHMWEbchaV8
 2QupV1OU9fpu9e0itO3ZZr2H5xc1cmEh65bAuWfb9Eeui+7UnAy2pFVqZEo4x1GNoBCz
 sQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s7f+IdClyq4iN+qevcxOTQ2pG6vC1lbkrjwR3WneXQM=;
 b=ZOlo6E+CF+rIm0tlHEve9xTjxWy7w10MtoDlsyV5fCY/2x6CP5iBV7Rx1N92lnpkwY
 QMIuXu/69lOp8fSgklCeSHKw5Vwy5n3MdfJqJXQKbiJEYQWw34ZX6SqsMdJVcVFoxuXx
 gRRtSPFIn21NVFDxRwH/epHNAwfETr5iGUvAtrmUH5c//HUfu1yYpWZTITrQf1sZTrKt
 tBVs1vcWhGqcXJJbFlm+R1yC51zlnY/fxde59tCaAWwnS+sGQAmgQAzSNwah57R8NX6O
 iMnK5lbkGrGIPe7+Rx/ZyjEjAPj1TnLpaM3+cfaimCirJI5IN24qPnxaLFNhyhNHLKy3
 pINQ==
X-Gm-Message-State: AHQUAuaOjJ7EAbuD47xXfnkQlGyfdQ42y8Yi2zqahKt49pPq0N4lXkDK
 D/TI+vGGRI7b+rfrw/F969RqJQ==
X-Google-Smtp-Source: AHgI3IY5wRBd5q6xsZy6JU1b+L92KVhmLgZ8tQ/PhuvwVTPnJfV3QVd4pZz9wBrb/na5tLfkSO1H8Q==
X-Received: by 2002:adf:fac6:: with SMTP id a6mr340181wrs.53.1549300699783;
 Mon, 04 Feb 2019 09:18:19 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
 by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 09:18:19 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 11/12] ARM: davinci: dm646x: switch to using the
 clocksource driver
Date: Mon,  4 Feb 2019 18:17:56 +0100
Message-Id: <20190204171757.32073-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204171757.32073-1-brgl@bgdev.pl>
References: <20190204171757.32073-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_091821_918887_5A055D2C 
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
 arch/arm/mach-davinci/dm646x.c | 36 ++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 73a0f0226017..5058be123dbe 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -27,7 +27,8 @@
 #include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -498,16 +499,24 @@ static struct davinci_id dm646x_ids[] = {
 	},
 };
 
-/*
- * T0_BOT: Timer 0, bottom:  clockevent source for hrtimers
- * T0_TOP: Timer 0, top   :  clocksource for generic timekeeping
- * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
- * T1_TOP: Timer 1, top   :  <unused>
- */
-static struct davinci_timer_info dm646x_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg dm646x_timer_cfg = {
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
 
 static struct plat_serial8250_port dm646x_serial0_platform_data[] = {
@@ -589,7 +598,6 @@ static const struct davinci_soc_info davinci_soc_info_dm646x = {
 	.intc_type		= DAVINCI_INTC_TYPE_AINTC,
 	.intc_irq_prios		= dm646x_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
-	.timer_info		= &dm646x_timer_info,
 	.emac_pdata		= &dm646x_emac_pdata,
 	.sram_dma		= 0x10010000,
 	.sram_len		= SZ_32K,
@@ -654,6 +662,7 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 {
 	void __iomem *pll1, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, ref_clk_rate);
 	clk_register_fixed_rate(NULL, "aux_clkin", NULL, 0, aux_clkin_rate);
@@ -670,7 +679,8 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm646x_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm646x_pll2_resources[] = {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
