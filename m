Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD20FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:50:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A01E20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e7ej/kG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A01E20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wPLyylzSKKa0Oh20pwcPKNGEqFUMCX5PIbwOPGAHl8g=; b=e7ej/kG6mbf8qT
	63RkF5xqqGTFDYp9loMfjAdlv0ZpaX1+Q3FpQkfWxEgt5nybk70pEyVWhTIm3JEubyFfPLKN1W1Zq
	Gwx73j79wfnypxBrmo8sXtCZVDBVgqly7SixMjHQAMjkl1Ug34M+3suVMnVe9bGxQoSRHdeKftDzl
	SiJAaJOYg8cG+GwXiezEsSLSJnfifYVJxf8zarf3eF4PE0qQdBy2PciQMUccoAJEU02RZf8vvaB0A
	mTmGcWGx/hgyMqEMKYftXdARn9RPIo/7ppCelS6F5O5zPtY+oMhcKDT3ETDUcNsigBYZYe1ZglB4C
	4qHKaX4o3DzJNmstj6wQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjnSM-0007iw-11; Wed, 16 Jan 2019 15:50:18 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjnSI-0007iN-F1
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 15:50:16 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 778D613F8B7;
 Wed, 16 Jan 2019 16:49:58 +0100 (CET)
To: arm-soc <arm@kernel.org>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v2] ARM: tango: Improve ARCH_MULTIPLATFORM compatibility
Message-ID: <48e3596f-4c76-8481-5cd4-5e8e79d31a09@free.fr>
Date: Wed, 16 Jan 2019 16:49:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_075014_656769_3B08CA84 
X-CRM114-Status: GOOD (  13.28  )
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
Cc: Mans Rullgard <mans@mansr.com>, Rafael Wysocki <rjw@rjwysocki.net>,
 Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Paolo Pisati <p.pisati@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Calling platform-specific code unconditionally blows up when running
an ARCH_MULTIPLATFORM kernel on a different platform. Don't do it.

Reported-by: Paolo Pisati <p.pisati@gmail.com>
Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
v1 was Paolo's patch: https://patchwork.kernel.org/patch/10573007/
Paolo: Sorry for procrastinating with your patch.
---
 arch/arm/mach-tango/pm.c    | 6 ++----
 arch/arm/mach-tango/pm.h    | 7 +++++++
 arch/arm/mach-tango/setup.c | 2 ++
 3 files changed, 11 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-tango/pm.h

diff --git a/arch/arm/mach-tango/pm.c b/arch/arm/mach-tango/pm.c
index 028e50c6383f..a32c3b631484 100644
--- a/arch/arm/mach-tango/pm.c
+++ b/arch/arm/mach-tango/pm.c
@@ -3,6 +3,7 @@
 #include <linux/suspend.h>
 #include <asm/suspend.h>
 #include "smc.h"
+#include "pm.h"
 
 static int tango_pm_powerdown(unsigned long arg)
 {
@@ -24,10 +25,7 @@ static const struct platform_suspend_ops tango_pm_ops = {
 	.valid = suspend_valid_only_mem,
 };
 
-static int __init tango_pm_init(void)
+void __init tango_pm_init(void)
 {
 	suspend_set_ops(&tango_pm_ops);
-	return 0;
 }
-
-late_initcall(tango_pm_init);
diff --git a/arch/arm/mach-tango/pm.h b/arch/arm/mach-tango/pm.h
new file mode 100644
index 000000000000..35ea705a0ee2
--- /dev/null
+++ b/arch/arm/mach-tango/pm.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_SUSPEND
+void __init tango_pm_init(void);
+#else
+#define tango_pm_init NULL
+#endif
diff --git a/arch/arm/mach-tango/setup.c b/arch/arm/mach-tango/setup.c
index 677dd7b5efd9..824f90737b04 100644
--- a/arch/arm/mach-tango/setup.c
+++ b/arch/arm/mach-tango/setup.c
@@ -2,6 +2,7 @@
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
 #include "smc.h"
+#include "pm.h"
 
 static void tango_l2c_write(unsigned long val, unsigned int reg)
 {
@@ -15,4 +16,5 @@ DT_MACHINE_START(TANGO_DT, "Sigma Tango DT")
 	.dt_compat	= tango_dt_compat,
 	.l2c_aux_mask	= ~0,
 	.l2c_write_sec	= tango_l2c_write,
+	.init_late	= tango_pm_init,
 MACHINE_END
-- 
2.17.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
