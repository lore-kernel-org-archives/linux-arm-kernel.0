Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EBEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:24:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394CD20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HeFOJyeH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TegxTHJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394CD20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UuJQ6k1OV80Eip3rIhcfVnw+IRDgW7XjifVrU3u7kPI=; b=HeFOJyeHYpBX4O
	+BwngtasrjIxttFLbzj+GY3Ro4cuML3wGm8LaUUjF6KqCvS0Vfpou+aVioInR9tpW+n17CJezzniC
	Fq6+46NnoNUoorfll3ByujQG3qUWNX8lAD1O3xVceramT9cnbh4s1pSlp+YLsuOMdgRin/cqfZTNR
	GKVUcJpgIcbhODlm3FqY252cL+ICfDXFr4Q3oYya6KHUKsR/86ItEpotfBOr3NfUbc8P0ZZahIDsF
	7oXeDUf7LitxexfsdOexF9F8vBEvdJlo5I8mRtGuv5cW09OR3KeKZu3IhYbd8lXl9+cKtAt1O/tAU
	5Dg3xcpKI3mVfWy4pZsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0Xq-0002ug-Bb; Fri, 11 Jan 2019 17:24:34 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0VT-0000Y0-LO
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:22:16 +0000
Received: by mail-wr1-x441.google.com with SMTP id z5so15982365wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hfk3et7otLUxOjDItpbWy429zVa4HyUJDtZ/8CbR6Hc=;
 b=TegxTHJJI1X+1ffw9Ii0XYA3eoFOA4jPpjkQqX8Dx62H8alN7PomzfVaNMj/nZOJb6
 7yG/Nsco2tNE5UShk+929HPiIJ66AcS54hdYEk3eWFVZC2DtjIZWhkMlIJUTMCi0SDva
 OS1RJWntdvhyn277ihGVezT2c0epLzw6KjQMQMBD4q058CyCn7GhRZZiUT7ZqadYgWfW
 mk+DFDs6a269kM9HIcNa27XExT5hrs3NmPI/CzpiRXlJhnQUHYUmAA5DfeUeJ/k8uhtA
 HHZFGg1SUuh1mIlGiL79F4CbPt99CTWrjSw1r12Ry/LFiJA77pHpOBPW+TmiVDxcVfs9
 LYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hfk3et7otLUxOjDItpbWy429zVa4HyUJDtZ/8CbR6Hc=;
 b=Ux7f8C5T53ZNyMNDdbuc3YbkOGCeFFQtmSHSZa9Iwbx8c+GGewA1J2BymA9FT/5wgt
 SauLqGQVppuN0+gLitLaYhxWAiFk2vY2vo4MlclucPJOEYMqRGtQUHtM5zZOLnr27uCY
 nEHSzWhAy+N2HIv6qdKmGAWKIePPhiTNvuHzokMfeqskewQHZW3/DVFn5C0yWi5TUgqk
 cRE66Da0qqgXggkkoM3hk8DG08ojndUDbitlr9PSntUTpnnxt20ymFL2SKfSFVN5/T+n
 krXMZHkAm1wu7pwyWmgKosuvKTKN0AnMNd5pkO1gRK4bqCe0rMsyGQO/AdUiB/2/KU97
 WA9g==
X-Gm-Message-State: AJcUukcq//xDo+8fRI4E01L/QiT+bnxIValGssXLgjDeIhIDMl3YWD+E
 EfKM1Z2tmWxOMP+YsePprejpYQ==
X-Google-Smtp-Source: ALg8bN7ldJGoTP7K8GnOoSfkJScx5WGi/6liRkczax7q8ZHiAlb1NeBhfS0UyuGP05DMy3DwgmHk5w==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr14250045wrv.288.1547227326340; 
 Fri, 11 Jan 2019 09:22:06 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.22.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 09:22:05 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 13/17] ARM: davinci: dm355: switch to using the clocksource
 driver
Date: Fri, 11 Jan 2019 18:21:30 +0100
Message-Id: <20190111172134.30147-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_092208_232911_6B70CDBF 
X-CRM114-Status: GOOD (  15.14  )
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
 arch/arm/mach-davinci/dm355.c | 36 ++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 07ad9d6c9cae..2fd1186ceef6 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -29,7 +29,8 @@
 #include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -617,16 +618,24 @@ static struct davinci_id dm355_ids[] = {
 	},
 };
 
-/*
- * T0_BOT: Timer 0, bottom:  clockevent source for hrtimers
- * T0_TOP: Timer 0, top   :  clocksource for generic timekeeping
- * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
- * T1_TOP: Timer 1, top   :  <unused>
- */
-static struct davinci_timer_info dm355_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg dm355_timer_cfg = {
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
 
 static struct plat_serial8250_port dm355_serial0_platform_data[] = {
@@ -708,7 +717,6 @@ static const struct davinci_soc_info davinci_soc_info_dm355 = {
 	.intc_type		= DAVINCI_INTC_TYPE_AINTC,
 	.intc_irq_prios		= dm355_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
-	.timer_info		= &dm355_timer_info,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
 };
@@ -735,6 +743,7 @@ void __init dm355_init_time(void)
 {
 	void __iomem *pll1, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM355_REF_FREQ);
 
@@ -747,7 +756,8 @@ void __init dm355_init_time(void)
 	clk = clk_get(NULL, "timer0");
 	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm355_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm355_pll2_resources[] = {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
