Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FB6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:20:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1D0218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SukD6jZy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLDsfNsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1D0218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7WPvb8eTWBGVkUpINCwVjNSoRGFiesrw1+lu4TIgLxU=; b=SukD6jZyabzZWc
	38H7NR2kg1CDy4SGsSgyeYqWyzL9TySNujZvimfvsikt0JX6D/5/e0f3NVmqwXZWLB8Cv2TJEHQ1w
	fm9FkPVNpIFxyDyUqkSZktjobQDKdBtMAarZbhz9hcBo6d0I3jVFW8EWGI43LJ4QtFPttS6hYFhuT
	BhZHF9q8M+/aNzZUCOjewo7KIi3oMx3+WdZvmQaeRvowgNCmyQuu1a2hRPmCBfrt9etQkae3CmEeR
	mq6l4qJ4i1NfTC/eLl9N7mrW8B67TqadM2fnG5D/mG2pi7Zd2AuWXlcAqghC9/MkQOOWC5I/jdLIj
	t/GSMpDv0FTtaP0Pks2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvWfg-0003k2-Se; Mon, 18 Feb 2019 00:20:32 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvWev-0001io-LI
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 00:19:49 +0000
Received: by mail-pg1-x542.google.com with SMTP id y4so7509224pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 16:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AfjyKjJ4BPDlX5QQ+sFj1fRVuO9lVs7F3NH6shrTHtY=;
 b=cLDsfNsx13o5jVbpfVJM1rGKKUV/63W8NmOQz/8GkyEPs8GYLjJarohBh8aVUh5J+s
 qYaKYdoDeAymcZqFK7Y2dulSPWNelR3dY4eFhyXHpuWH+aSiaqP60pcyGK2DdCNEoe0R
 L6fb153r6bLrAUThs5k0InFu+iTYQPUwjffXXTIeZZJKSUqrrWPRsEfYYNvEuI/HBGFk
 020PIrw/pRWhdmcz51jjErVI7JZ640M5LPgWyvUQkeyFH4hre7sQm/EMNdhPixoeYh/l
 HO94JHYUQbAcnZhW40fwFiQmgym35S6ynrmeuLGf2d3pvs7IUxNb1YuHgnA3vCPyd56v
 W6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AfjyKjJ4BPDlX5QQ+sFj1fRVuO9lVs7F3NH6shrTHtY=;
 b=kEuTW7tWBfdAHAhVmNtYrrobgfqKu6i0aQPVZjgOhMsYlonDebYz6rxEqvc+ig9FeF
 mUeXUn5jvGHTESwUPRCLdTpKk9b13432+alM9otCGJG5eKGQ+aeX9EF9NI6hYmvq6ERJ
 Ixjz+gzrRj/FhZVXzAiRg1No1YjwfSqGxMPMs+luSh230E7RLOz2jBdEV3KW+iA5BQ4B
 eZdGcNx3zASFZwRS/u/MZB+GyNMECfiOUKqtW2Y+xsQADQPgSCVVpYwbJbbpX6mGQH5b
 sx7U56YYXEZC9gg3mFhqgFl9i4Ds/qNVyYQL9ktpA3pX0aruw9HyAOkQJd4JDbCPhb/U
 mOgA==
X-Gm-Message-State: AHQUAubYFDdJU+QKDTkqVSsYpxGu+lCo5H+6NUNki2V0WRHoFCOxGdww
 avmK5Wvy+ffnCE+5YTHQlog=
X-Google-Smtp-Source: AHgI3IZaCtIC5CyA4/pgD49BKesPmkzS/NPioMK8YCwl06w0fhCsm3mqwWP81/cedYiGA1P3nOfozw==
X-Received: by 2002:a63:8441:: with SMTP id k62mr15388177pgd.219.1550449185279; 
 Sun, 17 Feb 2019 16:19:45 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id s73sm31518071pfi.124.2019.02.17.16.19.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Feb 2019 16:19:44 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 4/8] ARM: tegra: Set up L2 cache using Trusted Foundations
 firmware
Date: Mon, 18 Feb 2019 03:17:22 +0300
Message-Id: <20190218001726.16785-5-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218001726.16785-1-digetx@gmail.com>
References: <20190218001726.16785-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_161945_770613_1E654191 
X-CRM114-Status: GOOD (  14.30  )
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

On Tegra30 L2 cache should be initialized using firmware call if CPU is
running in insecure mode. Initialize L2 cache and set up the outer-cache
callbacks early during boot using the firmware API.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index f9587be48235..67d8ae60ac67 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -38,6 +38,7 @@
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
+#include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -70,9 +71,18 @@ u32 tegra_uart_config[3] = {
 	0,
 };
 
+static void __init tegra_trusted_foundations_l2x0_cache_init(void)
+{
+	if (IS_ENABLED(CONFIG_CACHE_L2X0) &&
+	    IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) &&
+	    of_machine_is_compatible("nvidia,tegra30"))
+		call_firmware_op(l2x0_init);
+}
+
 static void __init tegra_init_early(void)
 {
 	of_register_trusted_foundations();
+	tegra_trusted_foundations_l2x0_cache_init();
 	tegra_cpu_reset_handler_init();
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
