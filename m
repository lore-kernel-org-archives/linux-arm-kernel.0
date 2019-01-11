Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10099C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:26:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF29120652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Adly4e1p";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zOAjB/wB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF29120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HGiHXqEDkVbhTiRGb0BUBFHmUCeAtQ7UTOE+OoHiUJY=; b=Adly4e1p5SxZIb
	S5EyUfa4vcKGgDEVtT+eIpj+34cS5GDikWw0hLu20olsiaTl7ILvCNWPY5wHO1RBeMLXMV/Th+Yd7
	4v+1wRmHU+oudjJeXdcShvpwA7y3uE0n1JZ8xCEHMn2q58BB6kSYWXQuhAsAMprEnrAvRbP/+twC+
	Moxt2njvTp1rj2N4qX/ZAvZduQamiuuo5Jwm/TxzWcxqupd0JI8lLJ08JyluWXTb9m2ap0h9fSpnz
	LAWowGX6+jO81Lc1eJYpE4r66aG90hzYtVqVuFNYLXpU2KYbAnGWNN8Zr1uygOYZZV/S1oC61RfIT
	xjUPXk0RWWH0d4QHg0zg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0ZY-0005jO-ES; Fri, 11 Jan 2019 17:26:20 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0VX-0000d6-9b
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:22:20 +0000
Received: by mail-wr1-x444.google.com with SMTP id j2so16083207wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JGCXdQbXQo6tBzBdWymV0+bJ83eVX08S8XI886KP7NQ=;
 b=zOAjB/wBMRgd7EDZtd47dht0yzVZBvQL9/GNV9wdO8oZFySafi2AHyLNcRC1aztdGA
 gG99aUituxdWmo0XA/VZ/KFJ87UL2PQfAXNA4s5WBBe6gH6kYFTK+cEEbOK4alCR/niA
 yOrsLtn9DXmGvHvtWOj5+J11pKhSujg2lXnt/KLTaiO7KQv+RPpzjiclOzR98kZhXaHt
 80JDC4KugKB9J6ftTIUo5kucvmHN+G6cY3BwWUDuuWFvMCaFdrg+LSNPcSUhRsaKwrmI
 Po6PdHYxOlvtdXow69UE1cBI1+/hM0caYqxrw4EPN6VdwhIYuPRGQJTHuqvEkZYcoOpr
 vkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JGCXdQbXQo6tBzBdWymV0+bJ83eVX08S8XI886KP7NQ=;
 b=bxAzuHOhAtpueFerTo99Ze9AOCQZR0qCZvm9e/dT5/aYaVMsHtw/KBro2+zP3NEzvq
 iucxTNLBx3saY0Y8GYJjLN8l/9EdxlvAUCUcJfjkajmxj6hqrXHC7O7Np3ibH6R9Kfr/
 hYVzHnZs9lMl0CcqI4h7i8sRQTajiM1jcqrY9bg2Kd5CqdGd1JSWOqrFCedRXHDHXtB6
 h1Ec/ChJSWOJEvK9n8pou4U6T2MuuUaHaCPytyoidrqdSmsoVDSU++wkCGiDLgmdcvey
 uFIssaQQyVYxyopGXhV22FB2rk/Caa00ub7V8+bj/R/GHeNaLG3fVjRODNB4c9VR3T8Y
 XSug==
X-Gm-Message-State: AJcUukep8aI4tQG4+2ojICj+Yp3KSERZGUckd4H+4tB1HkR2JHm4B2p0
 li/mR/n5UXSUBKBC9PMEF2KJaQ==
X-Google-Smtp-Source: ALg8bN4gtkI8QXFfIK0wr9LWfM3C/9/3Xy01+BZz8ZntqCPIkASRP0gdkz8suSUkugkgNfwOROssuQ==
X-Received: by 2002:adf:f149:: with SMTP id y9mr15412531wro.284.1547227329955; 
 Fri, 11 Jan 2019 09:22:09 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.22.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 09:22:09 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 16/17] ARM: davinci: dm646x: switch to using the clocksource
 driver
Date: Fri, 11 Jan 2019 18:21:33 +0100
Message-Id: <20190111172134.30147-17-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_092211_918369_E4E93005 
X-CRM114-Status: GOOD (  14.76  )
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
index 018315fa9aa9..b3412920da0a 100644
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
@@ -667,7 +676,8 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 	clk = clk_get(NULL, "timer0");
 	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm646x_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm646x_pll2_resources[] = {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
