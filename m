Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D871C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:24:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC6C20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D+pZet4y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BtzkJ6/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC6C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QgYwMjf0AI2eMDJgW19Di6G8uLSDhh2tkyeh2W56A5c=; b=D+pZet4yDy0gGN
	cgAodx2JM0UFXdtp6PhKqNUf5kx6eepT+ObWAXc/+LqlKdqJ5jhBQRVWd62NfavNv8P5kRd1JfSaa
	s3Z3Zw9EGeHk6sDuHWW2SYRppZYMCa9TA+JmXTacjagSaPoihtLS0hOeuTnQ3rZKG8537T7VihIiW
	15Jr2Wyul4JUzFTIQ5xg80ToNTJfZKpD3Lpk51ySNm/VZUvfCOK0vlRoQolmAF1241kyuH+jkpe8T
	rEk7nfRwVCgvIa/N1V2qql1YRbNNi4tKMEJLjz2VPdBgKiK9/uwPr5iA36U+dhot2kARUCZcoyl/E
	YWdd6RQoQVWNhUODrrKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0XP-0002aF-1v; Fri, 11 Jan 2019 17:24:07 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0VR-0000UU-5p
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:22:11 +0000
Received: by mail-wm1-x344.google.com with SMTP id n190so3142030wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hZYvMu846/Z0QmqxG01Wn3LSRT0rTSPDCgRe4LniEGE=;
 b=BtzkJ6/3A0SwgnbjCDhZ3G4MwbbOWQv6JowuXcDm5hO4UFAKWGed2bXqBxeEi9sIRf
 8eAnM0syaKXM/9ZhjU6IrR6RRHDcYndV6VXrGcbPQC0taQqlu3grD3OZdgfKtpFKDYp9
 bzUcup8bnppVjRHu5ysIZCXHVVf8lkawCSAm5MNetfFG1m0CpB/Cq1titbNNTmQGxaYm
 rlG/W0jb40s1Ycu9G8upS8rN02B+l47aN6E1X3LhKRdw4/qW7tvOvTiJ5eph04UjKBrE
 Y6iE1Ou+kLgGf37c+RPtAXNLLCiY55X6RrM92maDg3hhNMddQMt5uwtpngrPfb5gufk0
 FheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hZYvMu846/Z0QmqxG01Wn3LSRT0rTSPDCgRe4LniEGE=;
 b=XCjxBpcgFtXqxsuXzjyRJAphHKJa2QXJjLYTt2DRJ4pWQ5KL5d8yxDdKpu5Dr0314C
 cJci/gIRiF1yy2+eKLDULf5/+1fAavJpY8htNipd6T2e+tTISqs8EEXdeWIpZgZkUGdF
 qFOYPH33tF4k/9nq1GHh9gEM/JW1yg3yEwei9PILdsR1TTizdXhYHoSyutovU0SPTBby
 ia1tKdpVrxGucjg8DcUdMFwQWO3NDRSi3yGyUt9EgfVQoo1bHG3M3fRaBXHRgeRpOJpy
 YXr6eKJqMKzzUuYPOkaknrNKQGVGdLULZQj98vs9j9KXCfc4qLOv0sbnjXsUsQiCwzax
 OxQQ==
X-Gm-Message-State: AJcUukf5iaXzHb1hasaTwHX/kgasvj+b+hVVtVFJ4l6KguRdUqFf5rV1
 kAnIDsrildv2XjRWgmQJS28OqA==
X-Google-Smtp-Source: ALg8bN6amoytBObZvtBC50bXhCBvxij4ANwDjVqO5hxeMFk9O+OrNCd3yeoLA4M/NqLtD+iliNzO4g==
X-Received: by 2002:a1c:e1d5:: with SMTP id y204mr3058300wmg.65.1547227323828; 
 Fri, 11 Jan 2019 09:22:03 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.22.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 09:22:03 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 11/17] ARM: davinci: da830: switch to using the clocksource
 driver
Date: Fri, 11 Jan 2019 18:21:28 +0100
Message-Id: <20190111172134.30147-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_092205_706144_8A1C6437 
X-CRM114-Status: GOOD (  15.25  )
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
 arch/arm/mach-davinci/da830.c | 56 ++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index ceb0417f10f6..0d81a8fdd9e6 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -20,7 +20,8 @@
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/irqs.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "mux.h"
 
@@ -769,32 +770,32 @@ int __init da830_register_gpio(void)
 	return da8xx_register_gpio(&da830_gpio_platform_data);
 }
 
-static struct davinci_timer_instance da830_timer_instance[2] = {
-	{
-		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_0,
-		.top_irq	= IRQ_DA8XX_TINT34_0,
-		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= IRQ_DA830_T12CMPINT0_0,
+static const struct davinci_timer_cfg da830_timer_cfg = {
+	.reg = {
+		.start		= DA8XX_TIMER64P0_BASE,
+		.end		= DA8XX_TIMER64P0_BASE + SZ_4K,
+		.flags		= IORESOURCE_MEM,
 	},
-	{
-		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= IRQ_DA8XX_TINT12_1,
-		.top_irq	= IRQ_DA8XX_TINT34_1,
-		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= IRQ_DA830_T12CMPINT0_1,
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
+		},
 	},
-};
-
-/*
- * T0_BOT: Timer 0, bottom		: Used for clock_event & clocksource
- * T0_TOP: Timer 0, top			: Used by DSP
- * T1_BOT, T1_TOP: Timer 1, bottom & top: Used for watchdog timer
- */
-static struct davinci_timer_info da830_timer_info = {
-	.timers		= da830_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_BOT,
+	.cmp = {
+		.irq = {
+			.start	= IRQ_DA830_T12CMPINT0_0,
+			.end	= IRQ_DA830_T12CMPINT0_0,
+			.flags	= IORESOURCE_IRQ,
+		},
+		.offset		= DA830_CMP12_0,
+	}
 };
 
 static const struct davinci_soc_info davinci_soc_info_da830 = {
@@ -810,7 +811,6 @@ static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.intc_type		= DAVINCI_INTC_TYPE_CP_INTC,
 	.intc_irq_prios		= da830_default_priorities,
 	.intc_irq_num		= DA830_N_CP_INTC_IRQ,
-	.timer_info		= &da830_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 };
 
@@ -826,6 +826,7 @@ void __init da830_init_time(void)
 {
 	void __iomem *pll;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA830_REF_FREQ);
 
@@ -836,7 +837,8 @@ void __init da830_init_time(void)
 	clk = clk_get(NULL, "timer0");
 	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &da830_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource da830_psc0_resources[] = {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
