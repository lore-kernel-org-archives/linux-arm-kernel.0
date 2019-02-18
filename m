Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1129AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:20:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF855218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CnxlzYVJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS5UQLQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF855218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MaSs8fPvzvDTYT6H+jAzeSShLPMyp9jNa/p76Fuqfsc=; b=CnxlzYVJhxmREy
	hGV/YN39sCI0WiGk5K8tWYTGwMQ1IA6Jy0xLgKP0VagXNbkFBaPfx896qNGOtFD9obkLmHtZe9wNL
	5MCeXdzQ9Jy/QVA5Gj0NvL44WaS1lM7tCEjZ6yGsk3EjnS2yeCvZdRxovuLCOXQg42EYEdGnc5AVv
	KEl8IAbGT6qJnLQCsRuNWAunR5jJLKoipZwV/1uJ4LHD+Pznna7JSaEWIn7c/TzyLrgltW5m/pRta
	BTaCxyNMFVZ0XkBteC4Bz2GJk/z6XvEjtSN43Ubr6AsvBNL+qLUscCJyRcrkP7gO/7+irQuHXus0O
	uViNwixEziYfB8ALHAAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvWf7-000215-BU; Mon, 18 Feb 2019 00:19:57 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvWej-0001RD-DO
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 00:19:41 +0000
Received: by mail-pg1-x542.google.com with SMTP id r11so7513891pgp.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 16:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FgOYxchHGlJHFmyyLBfbI94R8PKLM3DDEZqKom9TK2g=;
 b=NS5UQLQLQLnVdisz184ynUBPb5jurc2gGJ46g1wTWkq4XXVfHiP7dbzoRj+Yss+iSD
 hDWE5WKgP36YGvs8FcEd2NRQVWCERfX2iL7OXUyJovTDzhcIgtPJD6MMV7CFsUKPIUpE
 YpiK2h9YF4/akO34hglLcEVt2Wb2qAmwmaByQuNW3cP8qyOw6Ru1bReg/++yvsmnI0EA
 0TXZ/MD7G1VV020FYg/uJl1U3gO+zDhVq6FLoM1tW75isRuDPIPj8hGvBbKp0ti5yj3f
 d3bsQoxkH71R3f7U5TFWOcugPiHJ+qsHwj4z5vUBxt27udtYRcz9IDmiqnaHpvyrtaBM
 oBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FgOYxchHGlJHFmyyLBfbI94R8PKLM3DDEZqKom9TK2g=;
 b=B3haY/6ZKuB/oNjAxm4VdS1h60rpxEjgFJu2FhnV+6A1ymP4ce4A1/VnBuLpkmrah1
 CKl2eBobS2bF7GQc7kZbFzuIGmYRl95de8+2gD32JYUXJIZV5LZnq7LY7AwOi8ob15Lk
 JAWNwwrQKMxHhd7wqV2KJ/M7dM5eKGWEgX3MaoBuqLKlyX6h1be3aDoKNFqs4XSyL0gr
 HJoJpbQT84OINhudMcfJWoz0u5Si9yE6F/DTBnmWiXCIzFVSNquKui6RN3SnH18hIiPT
 cbSpeRoYoHgZefsEE4CXQVjWm6zex/DwEuJHdXT+m186+ZI9YczurhJgohmp2lFe1Ytd
 oshQ==
X-Gm-Message-State: AHQUAua++iwKgr5FS/PBMf2z3YGyRs61AWu+3hsOm4Dz1AY1hnKW5Pcv
 R+GwD9BcdFEi3RSH8+bDSPY=
X-Google-Smtp-Source: AHgI3IZQ6O64Nq7/2GBz/Y3eRYdRdWVu8yS3s0nflN81yZpH/5ZgUXWZY5xdo39MBHm1qrLPsTMPRA==
X-Received: by 2002:a63:a11:: with SMTP id 17mr16168904pgk.310.1550449172622; 
 Sun, 17 Feb 2019 16:19:32 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id s73sm31518071pfi.124.2019.02.17.16.19.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Feb 2019 16:19:32 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 2/8] ARM: trusted_foundations: Make prepare_idle call to
 take mode argument
Date: Mon, 18 Feb 2019 03:17:20 +0300
Message-Id: <20190218001726.16785-3-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218001726.16785-1-digetx@gmail.com>
References: <20190218001726.16785-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_161933_959982_F436C220 
X-CRM114-Status: GOOD (  16.02  )
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
