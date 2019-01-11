Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B049C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:26:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C217320652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nkAwVKQA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MXc5ELZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C217320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BvyyNTyX9RJMxwc+HMjb+p2nm5P89J+E8jY6IFU/kQg=; b=nkAwVKQAbWYs3h
	dKvO7KUgqAGPB3h0Vcicgf78Bubm7G7M+7BU++01Sek7fPztcE3hEQm4NOSTxG6EYALNcYunLpPbi
	gRZn2tja+DgZDPWx8m8UHskeFLqrq5ER20o4VFNyjh1ztIdY41A0g1LYl+vsLowtorEO/BX3Ghstt
	VMd9uHNelMawS8ed5/RYA6SSGcDddOSHWNW0zrCGX2kHufaYW2Sos4LFqZUWGFbDRXyVeruMYsYeN
	ZE7zUY7oOWu/ZH/HBixprWcZjO36X+LrV6Ik3HM63CJ5iMiSXGnCqnJeDvmORrmilOQebdYvIem35
	DfwzVvP3w+ZUKYltGIaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0ZG-0005Pt-NF; Fri, 11 Jan 2019 17:26:02 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0VW-0000bO-3c
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:22:18 +0000
Received: by mail-wr1-x441.google.com with SMTP id v13so16019011wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xONpeqOZllu4lUrmjTAaVSXxrn2MUyb6d2vzr8hXNI4=;
 b=MXc5ELZhvYYlr2tqznZ2MXg3jugFD12iMsi4b+wou+JPyWns8XxQzyDQuSODLpqrfj
 9uPI67Dil0VkwPmDr52be1ru6yiYKAkrbD9PQFtIXdJ/0hLcbQ6TbJpK5naYp6PRuq2J
 aRnt44TEHTdwYBjweX1Xfo9Kaev5BB365S6oxHKF+8Kwf/zD04mi4+nyslc5fNn8Ee0h
 T39y/DH4emHPOmLgF4BlHxN2pqK+BxIDSz4F7YfVTvQOQ6tMg+M7tDVey3Wc3UiyGxPc
 H5u8qsYPce/yDQPsHVvX7bvEV6095HVTSMpWu5Cly3Bc1G3y/1W0L5y8Xzpj8kIKquPn
 2jFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xONpeqOZllu4lUrmjTAaVSXxrn2MUyb6d2vzr8hXNI4=;
 b=dZ17hAm5hW2zwc09hDhyS1/P/r84pI6jSAk8ibmodOW9pYdNLep5JRvRwi8Jew+j4D
 QROy65wnfOigfKD+WiGTYs06MD4etwXuxtM5877Iv/Oi+mQMd5/uUpd15ngUYtB0rEbW
 TlOInZlHXyVSgkX0kSYqdcKu/m+qTeDYqYEKHp98vK+iwfZ4Jv2zzap/xm24xThcbpdV
 vIVkj9TnljXhn0AEEl2ztSnLt7pnPXX9Fcl8v+nK+Zr3uU9Yc5fmEDI5JVId0N2A2NkA
 6d/N5gqtEiax8tpKAyStB+VHHib7gD4i8L2PdmjWKjh0ztmkqQPuoEZv68CYSmFsFtL1
 qdkA==
X-Gm-Message-State: AJcUukfB9VDlodT9DARO+oKEHFbSenGjRoXcZS4emCW8eQO2pzKdpC5g
 GbA8nLZ4VA5hwQ2bXV3zb3LZ8A==
X-Google-Smtp-Source: ALg8bN7Ubi/V2Kzm4Hg5H3ZW87JrSek0YbUnwMrl3V93xTA254vXrWQLBfOyR3Z7Yd/IKK8I/txzxA==
X-Received: by 2002:adf:ba05:: with SMTP id o5mr13870231wrg.325.1547227328725; 
 Fri, 11 Jan 2019 09:22:08 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.22.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 09:22:08 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 15/17] ARM: davinci: dm644x: switch to using the clocksource
 driver
Date: Fri, 11 Jan 2019 18:21:32 +0100
Message-Id: <20190111172134.30147-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_092210_601496_2B5E41F9 
X-CRM114-Status: GOOD (  14.95  )
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
index 85d69ac1bd70..adbcdefadee8 100644
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
 
@@ -683,7 +692,8 @@ void __init dm644x_init_time(void)
 	clk = clk_get(NULL, "timer0");
 	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm644x_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm644x_pll2_resources[] = {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
