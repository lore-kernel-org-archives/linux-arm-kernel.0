Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4C3C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508562075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jjfSDyYE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr0jW989"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508562075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7WPvb8eTWBGVkUpINCwVjNSoRGFiesrw1+lu4TIgLxU=; b=jjfSDyYEfMW6qv
	6EPUE7yzbS1Bifbh5I/Eu68csfDRtIuwSkISELCmQgEAe2i66MfHMa5WmbjjYHdj7sl2DGv2dpwkZ
	VWmBrBKjjT7MvT0q7TQvwpdBWkyfwIiPLW8WbHM0HvBWco4syrC7UpDCXzuAEE50tld24WQb/9kcs
	UTCy9jMXqtF2DDg6M5jHlxsoG5KqvdHuulewNpuhp6PLmr4A104B+H9QjCac7KF0ogwOG6GX0Emye
	ti5yDnLCHr1T+Pjtj+Tcm11zc4AWg3uHiYCuBXdAnIqgYxsGm5kPOwPAA/y7zC7MzY6vmOkPlN5N8
	cyUetQuwlTXUP1A1CXyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFCg-0000aZ-IH; Fri, 22 Feb 2019 18:05:42 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFBb-0006k2-UY
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:04:37 +0000
Received: by mail-lf1-x143.google.com with SMTP id n15so2398332lfe.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 10:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AfjyKjJ4BPDlX5QQ+sFj1fRVuO9lVs7F3NH6shrTHtY=;
 b=Jr0jW989CtnvJYdr1+6TMimzDMHDAAoVRF14ZqAkbS+ynaSGXeM6MSV5Bkf53zo2sw
 cMcwDUVWDVkiUEtylnj+/O5tMTpvjcf4Rso0toLQr2iI9qoNbBLW/AtXg/PQMZyEe/4/
 EuQIHPIK4bBPh9MxEyyZLWLTS6bxhB70LMR9ucLfoGUZz0s2gqYG7XyaGMQxi9caGboz
 LTNntrRG9p2a/67XywcEtIC+NQH3CpVFC57sGgsOdA4MByGq/0nU6gALCPNIFm+n8k7I
 Ork95E6D+AX9YyWnHvHE0smBSThsaKRVD/oYZjBbXFIUIsmb18mNDWUfy37vlO71D9Qu
 7Lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AfjyKjJ4BPDlX5QQ+sFj1fRVuO9lVs7F3NH6shrTHtY=;
 b=ZLIRadPYevjoXVx6u2Z1wNb5wtH2IN/b2am5GtcLhA9QYRew1e3aFKYOjm2yvmbMka
 Wk8u4zfCfZwyBx3bim2ZWfZ8caFzDJWQywUGuhi0NavzTejr6XhEH9y8SYbwRVpa9/HN
 j04UjilDLFXke9oQnr01nJxr89MHTYni+ePnRqOMAyVAIbQRE5+olCpoTpifDZJG60ls
 u5g663u3Lg4ke+txnwfkVGcpu3oceHLSQ1BKz5PGHDPsu0QcBcD/fvG1iew6zgHQ1jv+
 T3plBrY6ApE3wqJ2fi3CPrOCcMXTiSeVoQj6Y/cgPNkaVSiOAV8mM6LTvxww0Nb1aqyf
 yImA==
X-Gm-Message-State: AHQUAuYm2WPBuwt6hb6VqfaC4T8+6kShfA3/3p+pe7qIKtaoby5Y7lqv
 z60mX7+ztfr79nqyyAkplVmlASpw
X-Google-Smtp-Source: AHgI3IaJEsj3kn9P0hVwEv0sUqUfRwmR3ypjSmWOVPZXz4x78Cav6WUvuG8rxDGy31MSk1v3oRIJjg==
X-Received: by 2002:ac2:424e:: with SMTP id m14mr3232954lfl.4.1550858673926;
 Fri, 22 Feb 2019 10:04:33 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id j12sm721202lfg.47.2019.02.22.10.04.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 10:04:33 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v5 4/8] ARM: tegra: Set up L2 cache using Trusted Foundations
 firmware
Date: Fri, 22 Feb 2019 20:59:22 +0300
Message-Id: <20190222175926.23366-5-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222175926.23366-1-digetx@gmail.com>
References: <20190222175926.23366-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_100435_980875_C7CE4CD2 
X-CRM114-Status: GOOD (  14.03  )
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
