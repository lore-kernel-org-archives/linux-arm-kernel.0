Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07C5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E53321855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BldUhEnU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Yg55H5xx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E53321855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q/SwaPUNeWPtwsGIH3jOe21HbPgl8Feur8fiTmMpSUw=; b=BldUhEnU52O1os
	XtHHA7u9Wr7frvx8X9uQnP2xG5k05x7q11x17+tRc3MMeh50gQXrBoByIY9Px1kKeDbxE2jbOhTet
	QBgDzqMgGmMfIgSodwLyJF9TUyxLRsQlhsiBtC1Kw+VNTPmj8ufzWPmhviODXbUcIsbdxds1hRYTU
	OQ/B1LkIJF0OAs54lVU87QyGafs5mvWSFi6yLzw7svVxx3B6JbSJXhqr4ngCMmXy8eGQ1SQFqbBoX
	9O6evftGuui7DTYlc3TZeWDkU6rQBoMU5S9Y+EGINFte/e7otk8WZN+7Ct4uWrxMfFrjcLDFmgynr
	5I0yEorn2ZyQ7AMu9IxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybY4-0003FK-A6; Tue, 26 Feb 2019 12:09:24 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybWM-0001Sk-6E
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:08:06 +0000
Received: by mail-wm1-x343.google.com with SMTP id j125so2022028wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 04:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mq3iJZVLpItIL4L4rsuKEvbRZu3sCHkA9qXDRFfgXBE=;
 b=Yg55H5xx5YhjgY3MfNPO+LrSNNTTZe9spRoCWEuDDgCXcmCYPjbT0h3VGDjtat+iUG
 4A5Cvw/bHkYhRHtER3sjJpxQZBZGZrFgIjjRhxx+r8Os+mUHvI4iH9WZ/A9xjCJaCv9d
 8RG5z75917QcFe46Dbq8tvLKck2y9tt55AyErLSt8bb37h20e7xlSgf2DT+8z7Fl2hHs
 86TiFkZhWOIHtmjL8YKjU1YJK1W1AK4CoYiEpTuBFBYhLbGwXLr/QYf1uZutP+pbzOkc
 fQp2jaQEdM/c81XSixW/0KxOb64dsefGr41o7STJc88syVwtBPX1wLy5zSbRe1q64whr
 0kUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Mq3iJZVLpItIL4L4rsuKEvbRZu3sCHkA9qXDRFfgXBE=;
 b=PZA64Fxb3CypS/GSInPO85/4T2JMhKmHyI9iC6PR5vOWyWD8c8tuVp46fLRN7Nc6ji
 HkbmU78S8jZdUT2ap0H/u9qRQFe8F7r+Pm20g5bC2IoxTvx+tlTAKxjO+SwRutl819kQ
 FOmmtU/DVp88pO4N/frYLlSqr2PL0uFwkdkqho8K/oDdo7OG+CRWcbo1rkm4g6iP5YW4
 kCwVUmgNmUnrqGdQN5d917qoekZb+wmPeAXiUKA2xuxbMiD9RaVPd1MM/3lccSfRnrdq
 POMzvuaRhucwBVp6GzJFa0oW8a3yNJj4xLrC0R9PfKRhs5VSPDFiBqTf4HSMYyqqzNzc
 i/sg==
X-Gm-Message-State: AHQUAuYiP8VyXRFv8m44SbL/482/xjQPferrr9gqcIpVLWCiH2Ooews9
 og3Z/2TCIPYuHIE/sWE1C30oZw==
X-Google-Smtp-Source: AHgI3IZUcWsjuYo/IPBUeCdntXwza4VrBzjGns5krnzXtz/df3rr37lXiqUAPUaw/1vNsd0omCJ7iA==
X-Received: by 2002:a1c:a98b:: with SMTP id s133mr2291528wme.129.1551182856266; 
 Tue, 26 Feb 2019 04:07:36 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 04:07:35 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 05/11] ARM: davinci: da830: switch to using the clocksource
 driver
Date: Tue, 26 Feb 2019 13:06:27 +0100
Message-Id: <20190226120633.18200-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226120633.18200-1-brgl@bgdev.pl>
References: <20190226120633.18200-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_040738_701022_DB2BBA70 
X-CRM114-Status: GOOD (  15.23  )
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

We now have a proper clocksource driver for davinci. Switch the da830
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da830.c | 36 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index d242ce06f7e5..1dd4c7273bd7 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -20,7 +20,8 @@
 #include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "irqs.h"
 #include "mux.h"
@@ -675,32 +676,18 @@ int __init da830_register_gpio(void)
 	return da8xx_register_gpio(&da830_gpio_platform_data);
 }
 
-static struct davinci_timer_instance da830_timer_instance[2] = {
-	{
-		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_0),
-		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= DAVINCI_INTC_IRQ(IRQ_DA830_T12CMPINT0_0),
-	},
-	{
-		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_1),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_1),
-		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= DAVINCI_INTC_IRQ(IRQ_DA830_T12CMPINT0_1),
-	},
-};
-
 /*
  * T0_BOT: Timer 0, bottom		: Used for clock_event & clocksource
  * T0_TOP: Timer 0, top			: Used by DSP
  * T1_BOT, T1_TOP: Timer 1, bottom & top: Used for watchdog timer
  */
-static struct davinci_timer_info da830_timer_info = {
-	.timers		= da830_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_BOT,
+static const struct davinci_timer_cfg da830_timer_cfg = {
+	.reg = DEFINE_RES_IO(DA8XX_TIMER64P0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA830_T12CMPINT0_0)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0)),
+	},
+	.cmp_off = DA830_CMP12_0,
 };
 
 static const struct davinci_soc_info davinci_soc_info_da830 = {
@@ -712,7 +699,6 @@ static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da830_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da830_pins),
-	.timer_info		= &da830_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 };
 
@@ -742,6 +728,7 @@ void __init da830_init_time(void)
 {
 	void __iomem *pll;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA830_REF_FREQ);
 
@@ -755,7 +742,8 @@ void __init da830_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &da830_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource da830_psc0_resources[] = {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
