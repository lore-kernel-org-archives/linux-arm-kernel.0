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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7380C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:06:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74EE92070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CrwWl1Sp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St7gh9wV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EE92070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8la6RfnjHOQlWLHh80YGHbRnZY7pVgDCUFvldra3TT4=; b=CrwWl1Sp0mCvVj
	Uaf/oqhYDvJCKUpHxtdLv0LP6I/MVCtxg70YbksLBWvbw4w6P4rNSj9fQHhBlhK5ushW0bYY6Aklb
	vl5AjWciUuCS/TGzF8cMBhkeuv44uJg/87SEFYwLnzK744vO/RRC1eioSIZiUqJrJSdfaY8JFHkWq
	4H2pj8DbB1aW9Pk7i9gtYgIorqbzthJylrS0Ch4LpYUqQwUI/Fe8bbU6VgR879hJm+Wg9aX+WZLX8
	W2HKwf2HyHvZyvzKJCRxRJsSMrsNnUtRv11rquE4sWPW13bLmX1Kayz7EFJimij9a9a3XLdtvZZeB
	gyptIKfXKcC+EQ8Ngbuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFDD-0001Kx-Or; Fri, 22 Feb 2019 18:06:15 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFBf-0006mR-2r
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:04:41 +0000
Received: by mail-lf1-x144.google.com with SMTP id v7so2403951lfd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 10:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9FtVEGiGy9Eakv2EeSbS97SgOgiiipvDTd5Smr8Hxk8=;
 b=St7gh9wVoFl5nVNEF7XevYlsh7CWBGCtaLEdD7i618b9+qT6ZKYKH1aF3ZNoluWh1/
 HqioaI3mtCa+LBdAGYg+Y6ki2uXGGJjnmvc7JjxBdYKK1JOb2m07Ex5Z7sdD4jBhk7Ty
 1wfRxkwATD0m0c1o6MsUCmwtCVIKuD0AkPszps7GRmTS020bzF9a4NhZoMqNrsu31ajq
 oEm/W1gcTortcteSaPulYUyovUzBm6LQKp5Lb5O04TJOvESBcfFJNCYWi+O4Ej8hU/rG
 RlWGG31HlM3sirj078bL5p+Z925LkH8EoVjdJHe2KZPXwwQpSL5f9nLB/WiabKELwMIO
 PNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9FtVEGiGy9Eakv2EeSbS97SgOgiiipvDTd5Smr8Hxk8=;
 b=uUaHKAogeqqK0O0TatomS6Tu5cC8TxByYklzhDai3Lz+64Cv/zMVhO18TgMNcTIXv8
 mQV0byR8S30zsQgBH3v/pEUUq7Md4oJ53ntiNaijMhu/JNQKdU8enZM+g0Y1R8gWa5l+
 AXiHPNwC2VZQPH5OIvDhTRrijIpJw9m8JjqHS57bvK4ehyZLs5O4qvnylwlPLwEVefx2
 J8j1P5V+l3CqkOoprADbgvVB06hpAuJ5kqGRtNuD1aXMj8qW0NdWFN2MY0tLdFOdRJWC
 5A46nGnG6NWcMuIdJrGh2VLupmKhpR+qvi5RpW3jtfDlztQw3SF00kJ4cbsUvc7KpvJh
 ZgQw==
X-Gm-Message-State: AHQUAubGrQoSxaHwEee7u48AiSXiM6N9HqFI6cKrZSUHxdcceqF4mHrn
 jhC5OUnSKy95BVL/F2n3TEg=
X-Google-Smtp-Source: AHgI3IbY8A/8QovN6qa3sHWXJ+thDxhwQ85F6eCMCyU2yj8xr8inGqSF7SAVgFFwCFHHXISKtNlDGA==
X-Received: by 2002:a19:5611:: with SMTP id k17mr3144398lfb.168.1550858677334; 
 Fri, 22 Feb 2019 10:04:37 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id j12sm721202lfg.47.2019.02.22.10.04.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 10:04:36 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v5 7/8] ARM: tegra: Support L2 cache maintenance done via
 firmware
Date: Fri, 22 Feb 2019 20:59:25 +0300
Message-Id: <20190222175926.23366-8-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222175926.23366-1-digetx@gmail.com>
References: <20190222175926.23366-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_100439_391005_DFDD5AE1 
X-CRM114-Status: GOOD (  15.41  )
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

Trusted Foundations firmware require MMU to be enabled for L2 cache
maintenance on Tegra30, hence perform the maintenance early/late on
suspend-resume respectively.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c    | 36 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/sleep.S | 11 +++++++----
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 1ad5719779b0..66c8cd63dd86 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -38,6 +38,7 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
+#include <asm/trusted_foundations.h>
 
 #include "iomap.h"
 #include "pm.h"
@@ -195,8 +196,27 @@ void tegra_idle_lp2_last(void)
 	cpu_cluster_pm_enter();
 	suspend_cpu_complex();
 
+	/*
+	 * L2 cache disabling using kernel API only allowed when all
+	 * secondary CPU's are offline. Cache have to be disabled early
+	 * if cache maintenance is done via Trusted Foundations firmware.
+	 * Note that CPUIDLE won't ever enter powergate on Tegra30 if any
+	 * of secondary CPU's is online and this is the LP2 codepath only
+	 * for Tegra20/30.
+	 */
+	if (trusted_foundations_registered())
+		outer_disable();
+
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
 
+	/*
+	 * Resume L2 cache if it wasn't re-enabled early during resume,
+	 * which is the case for Tegra30 that has to re-enable the cache
+	 * via firmware call. In other cases cache is already enabled and
+	 * hence re-enabling is a no-op.
+	 */
+	outer_resume();
+
 	restore_cpu_complex();
 	cpu_cluster_pm_exit();
 }
@@ -340,8 +360,24 @@ static int tegra_suspend_enter(suspend_state_t state)
 		break;
 	}
 
+	/*
+	 * Cache have to be disabled early if cache maintenance is done
+	 * via Trusted Foundations firmware. Otherwise this is a no-op,
+	 * like on Tegra114+.
+	 */
+	if (trusted_foundations_registered())
+		outer_disable();
+
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, tegra_sleep_func);
 
+	/*
+	 * Resume L2 cache if it wasn't re-enabled early during resume,
+	 * which is the case for Tegra30 that has to re-enable the cache
+	 * via firmware call. In other cases cache is already enabled and
+	 * hence re-enabling is a no-op.
+	 */
+	outer_resume();
+
 	switch (mode) {
 	case TEGRA_SUSPEND_LP1:
 		tegra_suspend_exit_lp1();
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index 5e3496753df1..0a8086d5a47a 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -132,10 +132,13 @@ ENTRY(tegra_shut_off_mmu)
 #ifdef CONFIG_CACHE_L2X0
 	/* Disable L2 cache */
 	check_cpu_part_num 0xc09, r9, r10
-	movweq	r2, #:lower16:(TEGRA_ARM_PERIF_BASE + 0x3000)
-	movteq	r2, #:upper16:(TEGRA_ARM_PERIF_BASE + 0x3000)
-	moveq	r3, #0
-	streq	r3, [r2, #L2X0_CTRL]
+	retne	r0
+
+	mov32	r2, TEGRA_ARM_PERIF_BASE + 0x3000
+	ldr	r3, [r2, #L2X0_CTRL]
+	mov	r9, #0
+	tst	r3, #1
+	strne	r9, [r2, #L2X0_CTRL]
 #endif
 	ret	r0
 ENDPROC(tegra_shut_off_mmu)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
