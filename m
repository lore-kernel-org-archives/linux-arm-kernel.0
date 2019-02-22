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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9291BC10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:36:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C2B020700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JpybNUQu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQSTOIEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2B020700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MaSs8fPvzvDTYT6H+jAzeSShLPMyp9jNa/p76Fuqfsc=; b=JpybNUQuf/R6+m
	U1juwaG3N7tXY3YGIYVpx9qZDFkkwpcQfu9Vo8/WN2LYZR414OhtCIwjN/O9vzyJTfdSu375tywlD
	fxhaUuI7EyYJOTZneFZWFDeojVgJnhtljiaTw/k/QFvZ+IIH/4A1ZZ6glZaNtIomnBa4IWgLVh015
	QDb76wt1zmxia4+ypWzfkcs1NlXvornmlgH1Alf+1OgsZL11lY2LSDVKi4TA/zJquWfnZRRzWXQnL
	XGvFU8td4/ANePSxp2ocfvZOrXZlblIeDA88JmbkV9pWAntE6RBDix7K5EfZrgAJEZaciDXWTJrz9
	dzPvzqbLaTd3TQZaAcQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxGc0-0003ok-VE; Fri, 22 Feb 2019 19:35:56 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxGbn-0003YI-50
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 19:35:44 +0000
Received: by mail-pf1-x442.google.com with SMTP id h1so1543202pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 11:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FgOYxchHGlJHFmyyLBfbI94R8PKLM3DDEZqKom9TK2g=;
 b=LQSTOIEVpCycnBnVFTGzDZy2oq5Q4gymcQHesjT0EFkQM3UeGupDz+JVmdqT7tGgvD
 Mz9sPmEkQndNpPNgKGs4HE9a/qxYQeGT5VD3wcwlLJlch446BahDBzc/RIB6ay3DrUFn
 5+wcH7cN3aOQMq/eNDhtkbvTzJbjw6dd0qjmzdyLeAJ58FsGos+mtvm0ZY9nme8sgh0v
 cerjrC4ApQ2b7mRV5CgECDhpcMvfqRS5RWbN2j5vXfilPaKRygoA+cL4I5bV5k5K6pKS
 +tJjt2ks8e61tyD8crrGW2JJZfvk2UTOstaWQMosa04cnKpC1oM01Aa0PP4+DuqSYuoC
 vxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FgOYxchHGlJHFmyyLBfbI94R8PKLM3DDEZqKom9TK2g=;
 b=H+iuD6jQhN0tTHTftFkVa8OJVZwlSnMjfm2jW4arsTVBL+yQXGZo6Qfsy0O7y0nxjr
 LgB7mMGFp7vgVMDPivyxACoFxwC6QRNP9l7771Jj2Exr+Rvn8IKUtWSJNXJWyE3L6d0v
 D7uet49H4TrJvOfP/0AJUC3ZCLInE758r6JeBvBW8aH+XpyfqQES8sDUQjf5KSY9nwy2
 zXV1QdnGp9Qbtag6izvQLBgSHHn1Yct6Q3iQiPsqQk0KVs4vrzCPX7oqX4OBXnlVlFEC
 kombCfZwoTmI5j6yDCktVMGEBPiqavLfQxIDSgKH5gVjufTokaD2fVH+h3kmXx273bbv
 tJlA==
X-Gm-Message-State: AHQUAuanZBmXKdE6p6IST6ARP9CdmyohEMDp107igXvK0cHiXpGtwfqM
 nuKhG07iAFnHwqeVV/+6exU=
X-Google-Smtp-Source: AHgI3IaU16gryTzWR/vuqPmm1olJoyDg7cwK95e9EBb2/r0KeYwOWl7k+Zuq+vGzaCOssSDLbmffoQ==
X-Received: by 2002:a63:104e:: with SMTP id 14mr1590390pgq.185.1550864142612; 
 Fri, 22 Feb 2019 11:35:42 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id e21sm7687190pfh.45.2019.02.22.11.35.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 11:35:41 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v6 2/7] ARM: trusted_foundations: Make prepare_idle call to
 take mode argument
Date: Fri, 22 Feb 2019 22:34:21 +0300
Message-Id: <20190222193426.10747-3-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222193426.10747-1-digetx@gmail.com>
References: <20190222193426.10747-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_113543_236661_6EB64B0A 
X-CRM114-Status: GOOD (  15.51  )
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

The Trusted Foundations firmware call varies depending on the required
suspend-mode. Make the firmware API to take the mode argument in order
to expose all of the modes to firmware user.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/firmware/trusted_foundations.c    | 29 ++++++++++++++++++++--
 arch/arm/include/asm/firmware.h            |  2 +-
 arch/arm/include/asm/trusted_foundations.h |  6 +++++
 arch/arm/mach-tegra/cpuidle-tegra114.c     |  3 ++-
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index 3bf61a5933b9..c496f4cc49cb 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -67,9 +67,34 @@ static int tf_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 	return 0;
 }
 
-static int tf_prepare_idle(void)
+static int tf_prepare_idle(unsigned long mode)
 {
-	tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S1_NOFLUSH_L2, cpu_boot_addr);
+	switch (mode) {
+	case TF_PM_MODE_LP0:
+		tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S3, cpu_boot_addr);
+		break;
+
+	case TF_PM_MODE_LP1:
+		tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S2, cpu_boot_addr);
+		break;
+
+	case TF_PM_MODE_LP1_NO_MC_CLK:
+		tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S2_NO_MC_CLK,
+			       cpu_boot_addr);
+		break;
+
+	case TF_PM_MODE_LP2:
+		tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S1, cpu_boot_addr);
+		break;
+
+	case TF_PM_MODE_LP2_NOFLUSH_L2:
+		tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S1_NOFLUSH_L2,
+			       cpu_boot_addr);
+		break;
+
+	default:
+		return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/arch/arm/include/asm/firmware.h b/arch/arm/include/asm/firmware.h
index 34c1d96ef46d..6698272bbcbf 100644
--- a/arch/arm/include/asm/firmware.h
+++ b/arch/arm/include/asm/firmware.h
@@ -24,7 +24,7 @@ struct firmware_ops {
 	/*
 	 * Inform the firmware we intend to enter CPU idle mode
 	 */
-	int (*prepare_idle)(void);
+	int (*prepare_idle)(unsigned long mode);
 	/*
 	 * Enters CPU idle mode
 	 */
diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h
index 00748350cf72..cdd48ab7d191 100644
--- a/arch/arm/include/asm/trusted_foundations.h
+++ b/arch/arm/include/asm/trusted_foundations.h
@@ -32,6 +32,12 @@
 #include <linux/cpu.h>
 #include <linux/smp.h>
 
+#define TF_PM_MODE_LP0			0
+#define TF_PM_MODE_LP1			1
+#define TF_PM_MODE_LP1_NO_MC_CLK	2
+#define TF_PM_MODE_LP2			3
+#define TF_PM_MODE_LP2_NOFLUSH_L2	4
+
 struct trusted_foundations_platform_data {
 	unsigned int version_major;
 	unsigned int version_minor;
diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index e3fbcfedf845..3b9af4766cdf 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -24,6 +24,7 @@
 #include <asm/cpuidle.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
+#include <asm/trusted_foundations.h>
 #include <asm/psci.h>
 
 #include "cpuidle.h"
@@ -46,7 +47,7 @@ static int tegra114_idle_power_down(struct cpuidle_device *dev,
 	tegra_set_cpu_in_lp2();
 	cpu_pm_enter();
 
-	call_firmware_op(prepare_idle);
+	call_firmware_op(prepare_idle, TF_PM_MODE_LP2_NOFLUSH_L2);
 
 	/* Do suspend by ourselves if the firmware does not implement it */
 	if (call_firmware_op(do_idle, 0) == -ENOSYS)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
