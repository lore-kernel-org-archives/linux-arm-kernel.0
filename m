Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE46C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:24:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2528920652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kst1knbr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lqIK8IKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2528920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jm1ojf2Q9/RYTwDufICZe16QSn/WaVwQbmkcA3fnphk=; b=Kst1knbrNzUEcr
	xP53zLxR7ffy4oPVZX4YRtugSY+Uvf/sQKOlq5Cvx8/AWNEKHfRJpONFvvAlRMRxHJRVTDfKIOU1t
	5U2xh2T6W5NUctvKTm9V2qW1gmat4rHaRk7LxbDsafwHp6x5N68ilhX1vxScDoJUxg+0lr0tLNoEd
	G5Ape4ZSyE6Tr+C07VF4PzVABoemv2Rnyfk5qkgJ5Yy5wpZgEv9QpRHnjwh9f/bE2yRkYM37BtiVH
	Ik1DSFMzfud7DWF3EF0yEl5HMe/KDVQFLXpmx3xp9vkcBluWgYO2G5bviasMGf/MTHbvL9//QFuzV
	qi4pol0PPzMBjqm8jRtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0Y2-00039k-Vz; Fri, 11 Jan 2019 17:24:47 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0VU-0000Zh-TK
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:22:17 +0000
Received: by mail-wr1-x444.google.com with SMTP id v13so16018947wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8uDRh+zfzHIczZUkwUu8zWkfC3Ym8OxzyS3iE5hQDh0=;
 b=lqIK8IKEc/qe+wnZ/U5o2f3zXE8BjI42VkuuKyTUkrN0Oq5RwKeqQiErfurC7yp6Id
 XuW2as02N7M3q34vFDl5FtHkQER1jAkXXcnvkCfTLJkmml412cxmFqwFB/jgLtAjotmY
 AYjNpANfTwNfNIFgxTdgshbpx8MDkIPyspNnIXc8ZOytHc1Bh8N7rbgAV61/3quR9we6
 MJA4lkdu6c3OWVSEmFSY20f0IbCiVJyPwaNLqNRBJlSoiEP3EhmuTHzfA6R3+hTJ/Iuq
 zZfC1qRlULIsI+YPdZ/O+w/OBO4LgtDbPzy6uieNXOzhfEmgCX57So3uK1tQ4n+Ou/We
 bkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8uDRh+zfzHIczZUkwUu8zWkfC3Ym8OxzyS3iE5hQDh0=;
 b=YGufyGsOYrl92yTYvcU7pl+U5Rgu9zMgjp0nKLO9kaFAm4B2EbRMSLfg3MzoiOU5l5
 cDrwtFonC5dfB3XOtKLCxQ+x+Sh2mrO39QkMHMHpRFbJqsqEgXYDysV048ylrIJWO8WX
 /EpJz545BsnHHqv+jIlFkUXffqRXt7DEz8T7r3TvcKTcHxXsXGusc3yPHl7LI099nIXD
 Z0NCKd6Qlpx/+pJFlAMNRQg7NrUd6hM23ErubCqod+XHhQkjm6gK5hUQBsAqobHOXT5P
 //LvaJyI3XgMc7xxritezEtsUrgEsqz6INKOTFM4C1kHHVSVfDYEYbE2Mq0iqftgKI96
 IKSw==
X-Gm-Message-State: AJcUukcu4aGMZosoYuIoTfJGRFJC+ExLWzTJzlB2kw1pvWwwIk9rrE/5
 pjm6W4efvozbVeIYJ0kHVPmYGQ==
X-Google-Smtp-Source: ALg8bN61524V+BNotDYTCh1j/dBf3aS0mwzUaWax/dfKlCzaQ1M5ahcNhRYrC9JW1oeJhFD7T5E4TA==
X-Received: by 2002:adf:f3c6:: with SMTP id g6mr14201248wrp.111.1547227327498; 
 Fri, 11 Jan 2019 09:22:07 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.22.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 09:22:06 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 14/17] ARM: davinci: dm365: switch to using the clocksource
 driver
Date: Fri, 11 Jan 2019 18:21:31 +0100
Message-Id: <20190111172134.30147-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_092209_509715_21562A3D 
X-CRM114-Status: GOOD (  14.62  )
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
index 842b7e706ba1..ff7754ce2bbe 100644
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
 
@@ -788,7 +803,8 @@ void __init dm365_init_time(void)
 	clk = clk_get(NULL, "timer0");
 	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm365_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 void __init dm365_register_clocks(void)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
