Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48052C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:01:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E5C2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QfZ0AOHJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="myxFxPMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E5C2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=TrKHTy4Ih91LQLxd6kvCBHQo2RvovGx3yfbZHwZZqVg=; b=QfZ
	0AOHJwHiXRBA/GheCETNzDDbs6KbUOV5k02UV7L1UyzCh1pW5c4J2GGUudm+kdj1lLq1dck69/FMw
	lkaWcKOpz/VI5Mwjl9Pj4SrNjAnMjqWB7Rk1oY3BYRytSJm/C9l0lkmepiUosHRcCCTMrSyD9wBDG
	qbLiuaKhYaM84XQbgRADJPaNrnEdPklWImk7Th/mV7AsP4RvW439Usxws88DLYYmsDuGr/DvQ6yTx
	xyDvF1OLuplXF2jxtvtR3NpuKA69Burked9SE7a6t/4H0w0JOmf7cCkRv+NnRs+C2WC0KmN6XIVI6
	/NBLiwQXo+PaqfRmMd+zOrQLuICQeaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpoN2-0001hj-J4; Sat, 02 Feb 2019 06:01:40 +0000
Received: from mail.andi.de1.cc ([2a01:238:43f3:0:615b:ee97:1f81:cbf2]
 helo=h2641619.stratoserver.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpoMy-0001h4-V7
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 06:01:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mjnVo9RxzXKkHISKFxWB5mdXJD6N2moKgDMpsvDssZk=; b=myxFxPMmQ3nxx11aOg4IlahlmL
 EcUIV4PBesDYjiyMQcvg65h6prAwGZKmgjDdBOVo4KIyt9G7iWYVfVkRNTsDiO+dcEjNBLZPDtpMk
 LIBVEIj+y3GngxMmeOcuYcIJQdYyG1/sdPtqrHRioMVnlrZeFPwlS6vHXKKxwfMUaIKg=;
Received: from x2f7f150.dyn.telefonica.de ([2.247.241.80] helo=localhost)
 by h2641619.stratoserver.net with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <andreas@kemnade.info>)
 id 1gpoMh-0004F3-GR; Sat, 02 Feb 2019 07:01:19 +0100
Received: from andi by localhost with local (Exim 4.89)
 (envelope-from <andreas@kemnade.info>)
 id 1gpoJy-0003Nx-2a; Sat, 02 Feb 2019 06:58:30 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: tony@atomide.com, linux@armlinux.org.uk, khilman@kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: [PATCH] omap3: give off mode enable a more prominent place
Date: Sat,  2 Feb 2019 06:58:27 +0100
Message-Id: <20190202055827.12956-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_220137_304310_E9FBFD37 
X-CRM114-Status: UNSURE (   9.02  )
X-CRM114-Notice: Please train this message.
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
Cc: Andreas Kemnade <andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enabling off mode was only reachable deeply hidden
in the debugfs. As powersaving is an important feature,
move the option out of its shady place.
The debugfs file can still be used to override the default.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/mach-omap2/Kconfig    | 8 ++++++++
 arch/arm/mach-omap2/pm-debug.c | 4 ++++
 arch/arm/mach-omap2/pm.h       | 4 ++++
 arch/arm/mach-omap2/pm34xx.c   | 7 ++++++-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 5e33d1a90664..8305b94c0e57 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -231,6 +231,14 @@ config OMAP3_SDRC_AC_TIMING
 	  wish to say no.  Selecting yes without understanding what is
 	  going on could result in system crashes;
 
+config OMAP3_PM_OFFMODE
+	bool "Enable Off-Mode"
+	depends on ARCH_OMAP3
+	help
+	  Enables deeper power-saving states of the SOC, so that hwmods
+	  do not only go to RET state but to OFF state. This option
+	  is overridable via debugfs.
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 5a8839203958..3474027112c2 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -37,7 +37,11 @@
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
 
+#ifdef CONFIG_OMAP3_PM_OFFMODE
+u32 enable_off_mode = 1;
+#else
 u32 enable_off_mode;
+#endif
 
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index c73776b82348..cd5f98f4d28b 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -55,8 +55,12 @@ extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 #ifdef CONFIG_PM_DEBUG
 extern u32 enable_off_mode;
 #else
+#ifdef CONFIG_OMAP3_PM_OFFMODE
+#define enable_off_mode 1
+#else
 #define enable_off_mode 0
 #endif
+#endif
 
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1a90050361f1..d7d83a09013f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -416,7 +416,12 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
+
+	if (IS_ENABLED(CONFIG_OMAP3_PM_OFFMODE))
+		pwrst->next_state = PWRDM_POWER_OFF;
+	else
+		pwrst->next_state = PWRDM_POWER_RET;
+
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
