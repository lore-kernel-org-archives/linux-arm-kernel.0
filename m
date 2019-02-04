Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3940AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:21:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0932620823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZycANjIz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nafIKDY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0932620823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xubfA+Bds34D2EviXjZa2pX5wQ/M1aAAUgcgIcjgfs8=; b=ZycANjIz6APJ27
	ielnsfX8FUIDnbIv6IgMFyBssqY9ApS6ICoM/T8Qsbu5s5Jz7XKfkTZAWfdumuiYM2iyKPFiqzdDt
	vl6Lnrcis2RKijYgOu3BPlrsI25rZbATJQsNY7kSRKWGOYK2U3MQL38LqmGzIRR1NSYgG+XlwyxC3
	Xupu27E9wriANRjF2LZTEWJrq0Z6p1KYfo+uKB7RChJ7qclTB56+doF78TUs4Ytw7f7iWeMg9NTur
	37ATF3cCy9U2yEpp2di9pvuojsvJaqBx8vrpZJUkur6n22D7abWRpsSC4KtIDb+SYiWKM4JKJIMtm
	/HVZYPwgKR20jtHe79EA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhvY-000409-JJ; Mon, 04 Feb 2019 17:21:00 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhsx-00008C-09
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:18:29 +0000
Received: by mail-wm1-x343.google.com with SMTP id z5so714300wmf.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 09:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ePcYMiqf1jmPY58s/nmJfIEQ3ktJRw9TAoJLNQ425DE=;
 b=nafIKDY8pCEVmUC98rmOxBpM/YpyKHHfGP9xeNo+EyYdsy38YVOlGhFo8FYS0wCrZM
 sLPBVwTE6RjP29WcO7EjMdeICeedB1hb/wZA7aB5ChbNwW070SeFf8nAy9Zz/mVaO0/d
 2u7feGxz2AdcZkcIPdlDWWKcYu781PhELfWPfYWwDrk0K8R9uOBT6MNBdCjHP33LLhwM
 crlWZwnsQaK3D5mZE65/c7AwG8pJLftA1DgIikdxORG08YXU3SfhJEslVrgwdqsaamsQ
 6L99tPpoB3SRd55wC2dkS+CWJNhHP9F1uOWG2Lve874ZWVYgq4QPhizr971ksjbQ2bNc
 lzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ePcYMiqf1jmPY58s/nmJfIEQ3ktJRw9TAoJLNQ425DE=;
 b=hIFgi75grxo/lRZ7plZ/49rWzxD5609aqC6fLY36YJ6C9zJUA/bMCr9VglITpiwkWX
 GDGBW19BWm9bEASunq+oJR7yCr+h2PkSPCfYTCybw0Tx26TyCqEprq3aCLPmQywtnN4G
 3m/xJkIi2TS51SZ9LW80xEzs66/QQgor75bmy5fbOnnABmrk6+IRRc+hQSuE2bNfw7wt
 KNGkheDb8r22OUc6KfNejuLuIynE7jOgbNH+U/8NUHu2EWb3O7epRAHg2X5kCB9akRKJ
 hWfw+RgzVdhUEMgfIUe5ftPntx+TtI/vXtptvQO5G9z9RLqvdb0uyrQX3zIgr3aZ8O3V
 oAlQ==
X-Gm-Message-State: AHQUAubifs1g1mP0aOzzyGOsYRrBrGP4yxU1T4iU8vXAjU9uL28Qtdvz
 jrW1Y4ZqIoDAW9mczLJgzjgg+g==
X-Google-Smtp-Source: AHgI3Ib5QYB3nXGgHQVS/4uC3KoNV1vNd32LlwiCQomKz0AD+XT5L07NnNv2x2frRwV/HF3q8TBTUg==
X-Received: by 2002:a1c:a00f:: with SMTP id j15mr331650wme.84.1549300697431;
 Mon, 04 Feb 2019 09:18:17 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
 by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 09:18:16 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 09/12] ARM: davinci: dm365: switch to using the clocksource
 driver
Date: Mon,  4 Feb 2019 18:17:54 +0100
Message-Id: <20190204171757.32073-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204171757.32073-1-brgl@bgdev.pl>
References: <20190204171757.32073-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_091819_525552_244D6057 
X-CRM114-Status: GOOD (  15.78  )
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
 arch/arm/mach-davinci/dm365.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 68bd78dac293..fa83dec162e6 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -34,7 +34,8 @@
 #include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -658,10 +659,24 @@ static struct davinci_id dm365_ids[] = {
 	},
 };
 
-static struct davinci_timer_info dm365_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg dm365_timer_cfg = {
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
 
 #define DM365_UART1_BASE	(IO_PHYS + 0x106000)
@@ -725,7 +740,6 @@ static const struct davinci_soc_info davinci_soc_info_dm365 = {
 	.intc_type		= DAVINCI_INTC_TYPE_AINTC,
 	.intc_irq_prios		= dm365_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
-	.timer_info		= &dm365_timer_info,
 	.emac_pdata		= &dm365_emac_pdata,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
@@ -773,6 +787,7 @@ void __init dm365_init_time(void)
 {
 	void __iomem *pll1, *pll2, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM365_REF_FREQ);
 
@@ -791,7 +806,8 @@ void __init dm365_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm365_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 void __init dm365_register_clocks(void)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
