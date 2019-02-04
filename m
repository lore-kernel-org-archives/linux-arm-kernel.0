Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C032AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:19:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A572080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VEK7Mt07";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="N60yUjql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A572080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZbFa43SPqdGd6lQ7x1fLyHEzgRuJUmot2vMSoj4ghTs=; b=VEK7Mt07VP6F87
	QsfORVzs6oeuj+lE747CAuEv5rdvM6iIb+H1EvtDybWIh4LhsoBLFOi5EJ2UiWIXhGj02nkQQHsor
	Puv3QIVrPjwTZ4d49aqI1u7Yb8eQ4FsxwcelKJW8Z0flG0Q3VFqCdI7v6P8qLLbOl0SQJBqqBug7D
	5ke+fj2W8D9gJ+4To/mU/erRxp6W+Uryoy0XHo2IC7Qwd8eh2wgDsHCFVDeOu+kAhO6fu9JR+Mi/z
	8qNKVUAzIlxVtcQyAGkCkpiLgEFMdt7tvCaPusMADHNFyFPgO7SM7djW8auXt9bVEEU/vmUzbO/dm
	EYRxT8iV17eHk7ml0lDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhuB-0001H4-Me; Mon, 04 Feb 2019 17:19:35 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhsv-00006w-TJ
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:18:22 +0000
Received: by mail-wr1-x443.google.com with SMTP id f7so721986wrp.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 09:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qpMztC/tOJf5+QsMCzCmhQH4ifnfU5iOLhYPcU1sS/k=;
 b=N60yUjql8P/xPeQ2RX4uC+GxwRGxv+y9VAoPlTJb5gqqjxqvTZmKwwVJUs4dR/vh8Y
 vh08NvqKe1z4AumUksN0QVbUwtoVaUr/OoSieFpVBo6YFULEMcdXZ+9Xa0nd+4yk3h3f
 OK2S8UCRywsigEttgXjxwxqv95N1AvFEHP70H+AYTPakIlLZiQdTPk/HfceAuylX9/iw
 p2q7lxEsnXa9mxJ02GebC6FrxPd/Ih3yJD2vfuN1tlOE6N9aVU9EA3/DgvhWE+ZCoCZj
 Jlxo7kjmqM85fk7Nls6nEKYiKZN57YAZBMrSauoTDGVC8SB7lloPNDxESKpryuwc7Yc9
 Zv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qpMztC/tOJf5+QsMCzCmhQH4ifnfU5iOLhYPcU1sS/k=;
 b=o36xQcpLFJkb2PPnk2+CSEHUfJsawpJXXwc2k01TYgYL6xA6pgD72VHHtm1kOrL26W
 pZ73/PySDJWoZRFkuAHscsD5Ae78yM1asA55CnHS1mDOCrfg2H3ZfE1o+xFaoKKQP3c6
 9iASFaDW1dPBQGG4CaxSw4eJoZh0O6iXb0FqDwGaYJyXRSWQtal5RXkWKKvhvXDoQgCg
 xCzAHawLqKTDHJktXH8tUw3ItZ1lFho4aJSC6eivjrPXD0Wx6HGTDW/xFz5PFty0JUut
 AfYHwGKq8qCczm/kpwC8DdS5yPEKvgHLtqkbryct6OKdJPjFmiqCWKoMj0jZgi4OxTSR
 23OA==
X-Gm-Message-State: AHQUAub8kNvJZVBlLc2q6C2RGYsD/zQoMmZy9mOXG3RJCfaDYgjbX1uc
 3Zm/OMcwctzr63Qvm57EW+GcbA==
X-Google-Smtp-Source: AHgI3IaEujR7yHemQo982hkrrZo+rex7RFBzwzAFZhCaaOtpbF+cCER7nfB9KzSpiOWboFneEbOa0w==
X-Received: by 2002:a5d:4d49:: with SMTP id a9mr396470wru.50.1549300696294;
 Mon, 04 Feb 2019 09:18:16 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
 by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 09:18:15 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 08/12] ARM: davinci: dm355: switch to using the clocksource
 driver
Date: Mon,  4 Feb 2019 18:17:53 +0100
Message-Id: <20190204171757.32073-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204171757.32073-1-brgl@bgdev.pl>
References: <20190204171757.32073-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_091818_618786_C370E564 
X-CRM114-Status: GOOD (  16.31  )
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
index 2a523fa7c716..287cddaec67c 100644
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
 
@@ -750,7 +759,8 @@ void __init dm355_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm355_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm355_pll2_resources[] = {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
