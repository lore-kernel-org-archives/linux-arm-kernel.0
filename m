Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEA7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:06:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5BE2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jw2+Sj/U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqEIwjj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5BE2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DV9QsJIjMiKyYqBH0tM0GKKziP7GamnRLWrUuNDdCCU=; b=jw2+Sj/UE1tpdP
	yUpa3yIPARFg17RMlzrBo9TrfxUttBz0Iyue8JjsZTMxSwmbix/NEtmutphw9A6libk3myDZiB/Vg
	mq9U64IEB4pIHDGFUfkn3KLClxb1HqFeGd09f1Td5BF5GqWm9Tti6xqXC80+GaySSQOWyMwCQ66Ui
	BVWyMHS8iFysQds0hfvcipUm7iLDnsZbyH8taC7SsgeRJ3X6w4rDmWYQeHzmMOHRMFg089F4C5Ptg
	tYZIuTV0xmKGNxtQYkL3ZW0S7XlW6EAQjckGoDeIEsvdqb4MGqoPOWc7LfSCsmzZUNpzS4r+r7GrA
	LEL0t9QXj6O+0po8W1mQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFDP-0001ZK-4j; Fri, 22 Feb 2019 18:06:27 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFBg-0006nb-2o
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:04:44 +0000
Received: by mail-lf1-x144.google.com with SMTP id t14so2392952lfk.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 10:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yYaQf2uE1bC7QPOkeoCbL4U6C9x9+VxaeGqL2OwsNgg=;
 b=DqEIwjj5N2Y9TVUSi9elZTTyD/zLlmRzx7F6oU+wkte7WdKEFHmcD+cHoOBrMnIu4q
 yPPU6ul+geqPDpHiNP9+tRz41f2UgkGzEBY3eTDBbTfkyK7LtP2ct3HBCeHd1xPaJ/u6
 ykpLTMpDEPbNBJLuv+47DJmph+UOGZi09a0pMDbuWultGp/hJDBEEtnXWiRzaUi81W+3
 xFi3ktCdN7IfTTu6DJjaNWMkEOy9KU692WyczHG1JQayse95kSP66EOXE3crMg/o9L/3
 gVy79DBmH/1ywHbkk9PtZXaojkP6qrfudiTkxbEcGOchYRDt7FQ2E2hKR+UYBw+ZIN9E
 hOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yYaQf2uE1bC7QPOkeoCbL4U6C9x9+VxaeGqL2OwsNgg=;
 b=A7RSb0xnq5keD/0QEpTqSL+RoUn3KJ5nKQDTu7Gh/4vzkRn0ZpWD+3DN71h8oExQR/
 zJ0L3Fd9yR33tEjodHUzbYto6gMU/uX3rBrJSRZuC7WRk08WuG1Blu2BPk7wL2a5oOyq
 vT2vVlzx+1nxkhwjnPhFg7SvvMAg4sfSMfUXiEKux1iunulqp87ZZQeaAbEybYoME67z
 wbcZvRoPLP/DdtNMgszyzzilrYFZlmGSjfXUECsN1JfQaN+KkfvcWRDIg2aCJXtBUVyZ
 zkzENokocpbX+6/dHISY7Ul07JUH+cDsBdCiJNaseJ3vbLnbucGB5HATeDbQbUngCBuk
 5yfw==
X-Gm-Message-State: AHQUAuYNgr2k6Krr01n718yDE+S0H2uedI5s9EQavppK4FdZjz/MfX46
 oRyWe2MpK/t+44arU5jEvBo=
X-Google-Smtp-Source: AHgI3Ib7t2qtKWzy1es0HVB0btxyzLqrB2Y2VD6MUU8P+E50U3FhtesCtG5Dl/NFX7+wEdf7hwg52A==
X-Received: by 2002:a19:f818:: with SMTP id a24mr3181709lff.58.1550858678430; 
 Fri, 22 Feb 2019 10:04:38 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id j12sm721202lfg.47.2019.02.22.10.04.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 10:04:37 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v5 8/8] ARM: tegra: Add firmware calls required for
 suspend-resume
Date: Fri, 22 Feb 2019 20:59:26 +0300
Message-Id: <20190222175926.23366-9-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222175926.23366-1-digetx@gmail.com>
References: <20190222175926.23366-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_100440_457117_F3B5F38F 
X-CRM114-Status: GOOD (  18.37  )
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
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In order to resume CPU from suspend via trusted Foundations firmware,
the LP1/LP2 boot vectors and CPU caches need to be set up using the
firmware calls.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c            | 53 ++++++++++++++++++-----------
 arch/arm/mach-tegra/reset-handler.S | 26 ++++++++++++++
 arch/arm/mach-tegra/sleep.S         |  3 +-
 3 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 66c8cd63dd86..f209f59e0daf 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -33,6 +33,7 @@
 #include <soc/tegra/pmc.h>
 
 #include <asm/cacheflush.h>
+#include <asm/firmware.h>
 #include <asm/idmap.h>
 #include <asm/proc-fns.h>
 #include <asm/smp_plat.h>
@@ -160,6 +161,28 @@ int tegra_cpu_do_idle(void)
 
 static int tegra_sleep_cpu(unsigned long v2p)
 {
+	/*
+	 * L2 cache disabling using kernel API only allowed when all
+	 * secondary CPU's are offline. Cache have to be disabled with
+	 * MMU-on if cache maintenance is done via Trusted Foundations
+	 * firmware. Note that CPUIDLE won't ever enter powergate on Tegra30
+	 * if any of secondary CPU's is online and this is the LP2-idle
+	 * code-path only for Tegra20/30.
+	 */
+	if (trusted_foundations_registered())
+		outer_disable();
+
+	/*
+	 * Note that besides of setting up CPU reset vector this firmware
+	 * call may also do the following, depending on the FW version:
+	 * 	1) Disable L2. But this doesn't matter since we already
+	 * 	   disabled the L2.
+	 *	2) Disable D-cache. This need to be taken into account in
+	 *	   particular by the tegra_disable_clean_inv_dcache() which
+	 *	   shall avoid the re-disable.
+	 */
+	call_firmware_op(prepare_idle, TF_PM_MODE_LP2);
+
 	setup_mm_for_reboot();
 	tegra_sleep_cpu_finish(v2p);
 
@@ -196,24 +219,13 @@ void tegra_idle_lp2_last(void)
 	cpu_cluster_pm_enter();
 	suspend_cpu_complex();
 
-	/*
-	 * L2 cache disabling using kernel API only allowed when all
-	 * secondary CPU's are offline. Cache have to be disabled early
-	 * if cache maintenance is done via Trusted Foundations firmware.
-	 * Note that CPUIDLE won't ever enter powergate on Tegra30 if any
-	 * of secondary CPU's is online and this is the LP2 codepath only
-	 * for Tegra20/30.
-	 */
-	if (trusted_foundations_registered())
-		outer_disable();
-
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
 
 	/*
 	 * Resume L2 cache if it wasn't re-enabled early during resume,
 	 * which is the case for Tegra30 that has to re-enable the cache
 	 * via firmware call. In other cases cache is already enabled and
-	 * hence re-enabling is a no-op.
+	 * hence re-enabling is a no-op. This is always a no-op on Tegra114+.
 	 */
 	outer_resume();
 
@@ -235,6 +247,15 @@ enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
 
 static int tegra_sleep_core(unsigned long v2p)
 {
+	/*
+	 * Cache have to be disabled with MMU-on if cache maintenance is done
+	 * via Trusted Foundations firmware. This is a no-op on Tegra114+.
+	 */
+	if (trusted_foundations_registered())
+		outer_disable();
+
+	call_firmware_op(prepare_idle, TF_PM_MODE_LP1);
+
 	setup_mm_for_reboot();
 	tegra_sleep_core_finish(v2p);
 
@@ -360,14 +381,6 @@ static int tegra_suspend_enter(suspend_state_t state)
 		break;
 	}
 
-	/*
-	 * Cache have to be disabled early if cache maintenance is done
-	 * via Trusted Foundations firmware. Otherwise this is a no-op,
-	 * like on Tegra114+.
-	 */
-	if (trusted_foundations_registered())
-		outer_disable();
-
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, tegra_sleep_func);
 
 	/*
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 3bf202819534..19a609046547 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -20,6 +20,7 @@
 #include <soc/tegra/flowctrl.h>
 #include <soc/tegra/fuse.h>
 
+#include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 
@@ -76,6 +77,7 @@ ENTRY(tegra_resume)
 	orr	r1, r1, #1
 	str	r1, [r0]
 #endif
+	bl	tegra_resume_trusted_foundations
 
 #ifdef CONFIG_CACHE_L2X0
 	/* L2 cache resume & re-enable */
@@ -88,6 +90,30 @@ end_ca9_scu_l2_resume:
 
 	b	cpu_resume
 ENDPROC(tegra_resume)
+
+/*
+ *	tegra_resume_trusted_foundations
+ *
+ *	  Trusted Foundations firmware initialization.
+ *
+ *	Doesn't return if firmware presents.
+ *	Corrupted registers: r1, r2
+ */
+ENTRY(tegra_resume_trusted_foundations)
+	/* Check whether Trusted Foundations firmware presents. */
+	mov32	r2, TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET
+	ldr	r1, =__tegra_cpu_reset_handler_data_offset + \
+							RESET_DATA(TF_PRESENT)
+	ldr	r1, [r2, r1]
+	cmp	r1, #0
+	reteq	lr
+
+ .arch_extension sec
+	/* First call after suspend wakes firmware. No arguments required. */
+	smc	#0
+
+	b	cpu_resume
+ENDPROC(tegra_resume_trusted_foundations)
 #endif
 
 	.align L1_CACHE_SHIFT
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index 0a8086d5a47a..78c74ace98ee 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -49,8 +49,9 @@ ENTRY(tegra_disable_clean_inv_dcache)
 
 	/* Disable the D-cache */
 	mrc	p15, 0, r2, c1, c0, 0
+	tst	r2, #CR_C
 	bic	r2, r2, #CR_C
-	mcr	p15, 0, r2, c1, c0, 0
+	mcrne	p15, 0, r2, c1, c0, 0
 	isb
 
 	/* Flush the D-cache */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
