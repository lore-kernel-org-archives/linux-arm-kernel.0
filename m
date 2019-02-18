Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED61C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:36:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594132089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xw55ge1c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UidRx6Hs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiFYjd/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594132089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8la6RfnjHOQlWLHh80YGHbRnZY7pVgDCUFvldra3TT4=; b=Xw55ge1ciNHPOB
	nUKsuIPobzVb7pzBDfNC1Dx2dLoYHxm3yH70CcD15HfqbFJXe2gHfEIpoEdZ4lrA9gGvCBlsuB78U
	KRVSlogp3dHMcm4/LVQOTV9H1XbZsjKOw1KJpgJphLp7McG2/mhPe50SUvILu/zmBvQDCovKJQK83
	IQVEi4/5HV1oLgluEguWlytS3bsIZQ48+CmtOg4rXWXlXpy50nbej+AKBYkSnMml/LGZPtou7zEpX
	Y+rinMGd05tGJw22PkwfQn3LgWr2YpiqNjZRYf8HAvElOhgCI/XTXe3TV6dkovyasMyEiFIp05RXl
	P+Egd11uB0Y+udway6rQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvWuW-0000x1-Ac; Mon, 18 Feb 2019 00:35:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvWuV-0000m6-AH
 for linux-arm-kernel@bombadil.infradead.org; Mon, 18 Feb 2019 00:35:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9FtVEGiGy9Eakv2EeSbS97SgOgiiipvDTd5Smr8Hxk8=; b=UidRx6HsKLwMEDxdvJv0pxQF7P
 ebDp3vdxfjePIMjrh5+l1A1twdzBf+myhNZW/gYcblalNasSqZohH9zyb7q7XXWW+HzbPpg/J+zDW
 i4AkQqT4dgv5O7VuCYy+4woJzCiTYun9f+i6VAnuFuHoSPufk2O0NH7E8xpwwd7BKoAYcoCIlSqk/
 xGM4Oo9pK3mJIsbWYW3SqqpnJGhTf4O2EX5FyKsgmafKNw2Og0+q4vQUvCZeGTJOOXs8Yx3TwW3nY
 lQ7n36geEkUCuDVgfbNBNi4AN5If11priPGZBAX6zlXECFjy0FjhxGQrXSI6TLDg4ydEhFbIYJaxV
 mtAMuWbA==;
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvWfH-0002PW-1d
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 00:20:09 +0000
Received: by mail-pl1-x644.google.com with SMTP id p8so7831706plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 16:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9FtVEGiGy9Eakv2EeSbS97SgOgiiipvDTd5Smr8Hxk8=;
 b=ZiFYjd/DceJ32azEOGg3cEeCfivgoHOn5pSsHhx6DOzudxTGZgsSdpN91KqrwkcBoj
 JE8F+vmR/wGEYqfBK5hlpgRzxkouMwDbbQM5dwg6yIW0TbTsAy0zyTBGqRcWPHI5bzvP
 J+fSm2HPUAEfqtMHbagvT4XTvcCzN7p0jKLCXqm+N9kbvcgmHlv7EbDvl342ov6wbdQX
 bRul/abgCPNwWLohKJJEZKkEzVhJthIKSszAxtG2cyxiztZvcZm1Moc+n8kXY4KL5k1j
 lalO2xETJno5ZoqgKjRTHoqiPDjYBHfrl+XH55pGccOaElQduEsGfAcmuJSVA1KZzb9J
 eFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9FtVEGiGy9Eakv2EeSbS97SgOgiiipvDTd5Smr8Hxk8=;
 b=Dm6HDIGjb/zhGDtTGBHv01E0ZOgmBIEsIu5odz7uhQsWrrUqXiYKFoZ8pIdaNMKEvS
 LS8yEejENi952Zsz5ZwWeTtyDKW6OahNmtX649wL4K9nRp9AYiOUyvWHa/XAzcdtyh+o
 3DSASV4uhuyjRKJlxc9OHVfOSU+Ig4hWbXp7ekznWs/30/mIT+jXKavRPR1vtm6VFXBk
 fYzIvgyXUTMl/yg4OBtk72xIqOAlNs8V3pKRdMq+fKYFVGAdrl/ou9fSafiIpskPEJDV
 Il1pJGltsRvOdwmPzrWBuCPPx24vY1Y+La+2LkGsBlynIW1ARZRwgD3SH0OucFoXKBoj
 YPQw==
X-Gm-Message-State: AHQUAua4goaEw0PnGMfxyyqcl9yvLM7I2eBmahruWDoTad294r3WKOxv
 mu1A9r3s7G8mUuzal2v1FpZ9axUi
X-Google-Smtp-Source: AHgI3IYQ/SwO5F6rcNdfHclFv8bc9xGYpjbYXVBHjrn4VC4UNvGShKHQnUALs/pzHyCq3Fc5mml44Q==
X-Received: by 2002:a17:902:9306:: with SMTP id
 bc6mr2982099plb.59.1550449204193; 
 Sun, 17 Feb 2019 16:20:04 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id s73sm31518071pfi.124.2019.02.17.16.19.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Feb 2019 16:20:03 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 7/8] ARM: tegra: Support L2 cache maintenance done via
 firmware
Date: Mon, 18 Feb 2019 03:17:25 +0300
Message-Id: <20190218001726.16785-8-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218001726.16785-1-digetx@gmail.com>
References: <20190218001726.16785-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_002007_431694_53E9F729 
X-CRM114-Status: GOOD (  17.57  )
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
