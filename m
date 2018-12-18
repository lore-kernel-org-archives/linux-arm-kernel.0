Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDE8C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B9721871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hgS5mSte";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2jKzaF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B9721871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=mRuPZIVhsODrccUOYyarX62S5n984vMe9YxmSYrd8Ao=; b=hgS5mSte4pVTWDcpnMx+HSlP39
	HyDBTu1cBGTPXzJztDCqyv8rq2v/ihu6efsmJwLAamFRE37SAlNjUfNswXFQ4CU8SUMCEcyW7Srg7
	5oJ5VnebDzPNm1mHfmy0fO9of5haDpmoPOs6zYViz1GcsqvKG1yuJVqkNVCgkTJ7afvX1uH02RlDi
	soRDBWMVeHXWQdkmdpvvwvfK6gqUskyP06/pjJKerXvUX1OcAt6lZV0bVX/gCzktpYPGJc7DAdeg8
	L5kmVyD/weV8gMnsEt52+XvEDxqUF1PPE8a4LW3MhcpwlS5+4qWnKhBSLHOQ4a+fkcGyYOCDrj39Z
	59oG8ruQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZMwa-0002lN-39; Tue, 18 Dec 2018 21:30:24 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZMvd-0000ll-KS
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 21:29:29 +0000
Received: by mail-wr1-x442.google.com with SMTP id s12so16988163wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 13:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QXQVukJ1aLtElpReoZ9tNrJAaaXhnuBSyD1Rl2WDJl4=;
 b=k2jKzaF/bNv3wTIip3ycEdD1Z3KAdtfxRoEBAJcjSd0bKdy5w/gw2/dCG5Hx7HiOAz
 prRmpKvjcWlDnOLOshZEKrcTdsS1YxfFbzAVEPnkgM1nCREZCgZ2JFWD4sute7VcgEZ2
 /P5nzQHhT29oWEhoXqV5uZMKKH8+D3jxPwef4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QXQVukJ1aLtElpReoZ9tNrJAaaXhnuBSyD1Rl2WDJl4=;
 b=IQlqHQaSMmNZSISAQFj/P/nxObLoWC1jkY9p7sR8l2/e+++TMTVQwhXmC5ajUqTwo9
 WWCMe/MR0hao1lE/JBLqoMNvPnqNr/vJl7l/2Tv6xinPtTbRRZ6+pIm8TpHpcetkx828
 cY91R81bBNaJSWa8AGUN+YJYhKVqM3gWmpo+D81RlS5e5HJKGA8QACoOOYMq+alS2AUx
 H2Mz+V/HcP3MNVIaK5jQLT8I7HVoG2BpTe/JPx77RFzulK6k0jCFvwnTFdNNPkivIHyR
 7TfSOAwyMaZJ9yN4deK747a+dc2na8IaBB6EnYpksGlxtejKN5zok0glCoDSW5oNb74K
 Xg1g==
X-Gm-Message-State: AA+aEWYhCq13SC6B/0BAXAZUGBtIuUUhacCJNjNu7F8Cv2qG4UtKbFkX
 EpLYdsV7sbsVfxVXDC8rxsB6/Q==
X-Google-Smtp-Source: AFSGD/X1GJz/u/fFe1KBFZQp7KUMTk/clauN0G6yLfjvKeyyt6NucQLN3MOMHwl3GOi+qjMIK75fyg==
X-Received: by 2002:adf:8c09:: with SMTP id z9mr16257501wra.301.1545168553551; 
 Tue, 18 Dec 2018 13:29:13 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
 by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 13:29:13 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Subject: [PATCH 03/25] clocksource/drivers/ux500: Drop Ux500 custom SCHED_CLOCK
Date: Tue, 18 Dec 2018 22:28:21 +0100
Message-Id: <20181218212844.30445-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_132925_881508_640998F4 
X-CRM114-Status: GOOD (  18.19  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 "moderated list:ARM/NOMADIK/U300/Ux500 ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>, Baolin Wang <baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The two drivers used for Ux500 sched_clock use two Kconfig
symbols to select which of the two gets used as sched_clock.

This isn't right: the workaround is trying to make sure that
the NONSTOP timer is used for sched_clock in order to keep
that clock ticking consistently over a suspend/resume
cycle. (Otherwise sched_clock simply stops during suspend
and continues after resume).

This will notably affect any timetstamped debug prints,
so that they show the absolute number of seconds since the
system was booted and does not loose wall-clock time during
suspend and resume as if time stood still.

The real way to fix this problem is to make sched_clock
take advantage of any NONSTOP clock source on the system
and adjust accordingly, not to try to work around this by
using a different sched_clock depending on what system
we are compiling for. This can solve the problem for
everyone instead of providing a local solution.

Cc: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig               | 13 -------------
 drivers/clocksource/clksrc-dbx500-prcmu.c | 18 ------------------
 drivers/clocksource/nomadik-mtu.c         |  4 ----
 3 files changed, 35 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 55c77e44bb2d..64d5759ddf0e 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -163,12 +163,6 @@ config CLKSRC_NOMADIK_MTU
 	  to multiple interrupt generating programmable
 	  32-bit free running decrementing counters.
 
-config CLKSRC_NOMADIK_MTU_SCHED_CLOCK
-	bool
-	depends on CLKSRC_NOMADIK_MTU
-	help
-	  Use the Multi Timer Unit as the sched_clock.
-
 config CLKSRC_DBX500_PRCMU
 	bool "Clocksource PRCMU Timer" if COMPILE_TEST
 	depends on HAS_IOMEM
@@ -226,13 +220,6 @@ config INTEGRATOR_AP_TIMER
 	help
 	  Enables support for the Integrator-ap timer.
 
-config CLKSRC_DBX500_PRCMU_SCHED_CLOCK
-	bool "Clocksource PRCMU Timer sched_clock"
-	depends on (CLKSRC_DBX500_PRCMU && !CLKSRC_NOMADIK_MTU_SCHED_CLOCK)
-	default y
-	help
-	  Use the always on PRCMU Timer as sched_clock
-
 config CLKSRC_EFM32
 	bool "Clocksource for Energy Micro's EFM32 SoCs" if !ARCH_EFM32
 	depends on OF && ARM && (ARCH_EFM32 || COMPILE_TEST)
diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index 4054539fe066..51d53c4e646f 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -15,7 +15,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/clockchips.h>
-#include <linux/sched_clock.h>
 
 #define RATE_32K		32768
 
@@ -26,8 +25,6 @@
 #define PRCMU_TIMER_DOWNCOUNT	0x4
 #define PRCMU_TIMER_MODE	0x8
 
-#define SCHED_CLOCK_MIN_WRAP 131072 /* 2^32 / 32768 */
-
 static void __iomem *clksrc_dbx500_timer_base;
 
 static u64 notrace clksrc_dbx500_prcmu_read(struct clocksource *cs)
@@ -52,18 +49,6 @@ static struct clocksource clocksource_dbx500_prcmu = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
 };
 
-#ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
-
-static u64 notrace dbx500_prcmu_sched_clock_read(void)
-{
-	if (unlikely(!clksrc_dbx500_timer_base))
-		return 0;
-
-	return clksrc_dbx500_prcmu_read(&clocksource_dbx500_prcmu);
-}
-
-#endif
-
 static int __init clksrc_dbx500_prcmu_init(struct device_node *node)
 {
 	clksrc_dbx500_timer_base = of_iomap(node, 0);
@@ -81,9 +66,6 @@ static int __init clksrc_dbx500_prcmu_init(struct device_node *node)
 		writel(TIMER_DOWNCOUNT_VAL,
 		       clksrc_dbx500_timer_base + PRCMU_TIMER_REF);
 	}
-#ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
-	sched_clock_register(dbx500_prcmu_sched_clock_read, 32, RATE_32K);
-#endif
 	return clocksource_register_hz(&clocksource_dbx500_prcmu, RATE_32K);
 }
 TIMER_OF_DECLARE(dbx500_prcmu, "stericsson,db8500-prcmu-timer-4",
diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index 8e4ddb9420c6..19b336c9b417 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -69,7 +69,6 @@ static u32 clk_prescale;
 static u32 nmdk_cycle;		/* write-once */
 static struct delay_timer mtu_delay_timer;
 
-#ifdef CONFIG_CLKSRC_NOMADIK_MTU_SCHED_CLOCK
 /*
  * Override the global weak sched_clock symbol with this
  * local implementation which uses the clocksource to get some
@@ -82,7 +81,6 @@ static u64 notrace nomadik_read_sched_clock(void)
 
 	return -readl(mtu_base + MTU_VAL(0));
 }
-#endif
 
 static unsigned long nmdk_timer_read_current_timer(void)
 {
@@ -234,9 +232,7 @@ static int __init nmdk_timer_init(void __iomem *base, int irq,
 		return ret;
 	}
 
-#ifdef CONFIG_CLKSRC_NOMADIK_MTU_SCHED_CLOCK
 	sched_clock_register(nomadik_read_sched_clock, 32, rate);
-#endif
 
 	/* Timer 1 is used for events, register irq and clockevents */
 	setup_irq(irq, &nmdk_timer_irq);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
