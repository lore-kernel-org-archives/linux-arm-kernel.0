Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2EDC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:38:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F8C21A80
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ne224jVM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Oi01b9O2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F8C21A80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2t+oSgyHjm9G3iWvmw58RNsIxZKRNu+tdGNvj5Opa0Q=; b=ne224jVM7iHrGx
	7YRYnhOM4w+JHQdKG2xdv1+zaHgKkuC9uGWFAOPX+3eefPuBh4FrEF9LkDAZ5eOYMGGC0kwOLNbUZ
	mjdRC5s56nqZc4oW6CZrIQ36C8aKpkNkwzNrCpZLatRKqizw6ZdVJnwDMN/5r3x41um3FmVdUdOns
	YmWNpTU9hQGMqH11wnRN6Mm1dwtFDcOGfFnbX4OuNIHiJaAWcvwc1JOA1AKpXA86tMi1+YZwszOLj
	PNoa/ShPpfsXcp3eQCDcEH/1WKRB2ESGcXLaWAss2DWhEB1I1X2lrwxz5URJYO0chLVP9buDPmR8C
	5VvrxCW/JVQfcorb2g8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAqd-0001SP-E4; Mon, 11 Feb 2019 12:38:07 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfX-0007ZD-Cy
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:27:09 +0000
Received: by mail-wm1-x342.google.com with SMTP id b11so17503995wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2DeiZ8D7UiVmGGxb7P14iUU29iY/Sp7nuKJSfeun7aM=;
 b=Oi01b9O2eyTyX1bGRkpG8h3IZVJ+EgOpgzZ3ZFLpBndmmelie2v7Hbdhv680lkbfM+
 Go1MFymRNpZ58w3U8hGFRd3bPg2UoFfu40QbClVU04uxnM0NbnPe/b3ksjCImlMNDqf3
 anuWBVaQOwHlltiNdPh++VYEztepEUsM2TVsQfcAQhnrdqpGjijds+08I11HKejfkE75
 Po6WpeFKwo3HFu5K1yQDcDANIjVVBc0g+qbpQsQnxS1DvkkhIVJAEa7U/+ZPkofeMSSx
 cxp1YYydFJb4q3Wbz1mVLq5PXwait2/qgOpnPJwreNd6GoK41lxrFCWiban+KwiDrXKh
 Y3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2DeiZ8D7UiVmGGxb7P14iUU29iY/Sp7nuKJSfeun7aM=;
 b=kNBfbo+S9UtSMRFM2/d/+1Zw78m8o8BHePGA+i6dyWUsP9EhjOvTNQoefUwxvyDQo+
 gjsW3R4HwyOhRDn8GePoN+jg7k6ccEWyGiL8b5Z4vWyO0KpNsak9lIRiXObLJvYnhpa/
 wNssDxkWI7d5kFFOIN4Ax9G0rGClGJQZ+EzUxuZCTQwRNzJpkMD6QmLMl7TMMUNUWHhj
 gYhO8KCvxbCF+mzA3QdS3QBohVACic7h3C8zrlbW/XTQorzuGGPz/dijiooU1qtHDFtn
 7O+mLi8PgLeFhOdmGsmeQC/mjrQDDIhHQaQ0HIhcFdYh6begkuxsPEBQCeq2hCDsDtYH
 06QA==
X-Gm-Message-State: AHQUAuaRwAQMjmVXYOkdaQPX+YNbArdiuHXDthMV6JSa9/Ky4r+KtM4t
 gvZScJ2FjoHqGaOYZkvjJA2/Yg==
X-Google-Smtp-Source: AHgI3IYR5toDhsHO6CxbJVN/gsyX1utE6dp0DgyxwIuUVJucmQYHAF0h6V1SFwfxwROsESGFdTk9Yw==
X-Received: by 2002:a1c:c904:: with SMTP id f4mr741017wmb.42.1549887997853;
 Mon, 11 Feb 2019 04:26:37 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:37 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 20/33] ARM: davinci: cp-intc: remove cp_intc.h
Date: Mon, 11 Feb 2019 13:25:53 +0100
Message-Id: <20190211122606.8662-21-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042640_016177_25F7AF04 
X-CRM114-Status: GOOD (  15.94  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There's no need to have a local header for cp-intc. Move the only
declaration for a public function to common.h. Move all register
offsets into the driver source file and drop all unused defines.
Make cp_intc_of_init() static.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     |  1 -
 arch/arm/mach-davinci/board-da850-evm.c     |  1 -
 arch/arm/mach-davinci/board-mityomapl138.c  |  1 -
 arch/arm/mach-davinci/board-omapl138-hawk.c |  1 -
 arch/arm/mach-davinci/cp_intc.c             | 20 +++++++-
 arch/arm/mach-davinci/cp_intc.h             | 57 ---------------------
 arch/arm/mach-davinci/include/mach/common.h |  1 +
 7 files changed, 19 insertions(+), 63 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/cp_intc.h

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 7b8c4aeca096..f81c92b9cf07 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -39,7 +39,6 @@
 #include <mach/mux.h>
 #include <mach/da8xx.h>
 
-#include "cp_intc.h"
 #include "irqs.h"
 
 #define DA830_EVM_PHY_ID		""
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index b0814bd30a1f..1cc49e7bf128 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -46,7 +46,6 @@
 #include <mach/da8xx.h>
 #include <mach/mux.h>
 
-#include "cp_intc.h"
 #include "irqs.h"
 #include "sram.h"
 
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 8df16e81b69e..eb6a9465f229 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -27,7 +27,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/common.h>
-#include "cp_intc.h"
 #include <mach/da8xx.h>
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 94c4f126ef86..7f852722ff08 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -27,7 +27,6 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include "cp_intc.h"
 #include <mach/da8xx.h>
 #include <mach/mux.h>
 
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 4e293cde20fb..82110d332c82 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -21,7 +21,22 @@
 
 #include <asm/exception.h>
 #include <mach/common.h>
-#include "cp_intc.h"
+
+#define CP_INTC_CTRL			0x04
+#define CP_INTC_HOST_CTRL		0x0C
+#define CP_INTC_GLOBAL_ENABLE		0x10
+#define CP_INTC_SYS_STAT_IDX_CLR	0x24
+#define CP_INTC_SYS_ENABLE_IDX_SET	0x28
+#define CP_INTC_SYS_ENABLE_IDX_CLR	0x2C
+#define CP_INTC_HOST_ENABLE_IDX_SET	0x34
+#define CP_INTC_HOST_ENABLE_IDX_CLR	0x38
+#define CP_INTC_PRIO_IDX		0x80
+#define CP_INTC_SYS_STAT_CLR(n)		(0x0280 + (n << 2))
+#define CP_INTC_SYS_ENABLE_CLR(n)	(0x0380 + (n << 2))
+#define CP_INTC_CHAN_MAP(n)		(0x0400 + (n << 2))
+#define CP_INTC_SYS_POLARITY(n)		(0x0D00 + (n << 2))
+#define CP_INTC_SYS_TYPE(n)		(0x0D80 + (n << 2))
+#define CP_INTC_HOST_ENABLE(n)		(0x1500 + (n << 2))
 
 #define DAVINCI_CP_INTC_PRI_INDX_MASK		GENMASK(9, 0)
 #define DAVINCI_CP_INTC_GPIR_NONE		BIT(31)
@@ -141,7 +156,8 @@ static const struct irq_domain_ops cp_intc_host_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
+static int __init cp_intc_of_init(struct device_node *node,
+				  struct device_node *parent)
 {
 	u32 num_irq		= davinci_soc_info.intc_irq_num;
 	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
diff --git a/arch/arm/mach-davinci/cp_intc.h b/arch/arm/mach-davinci/cp_intc.h
deleted file mode 100644
index 827bbe9baed4..000000000000
--- a/arch/arm/mach-davinci/cp_intc.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * TI Common Platform Interrupt Controller (cp_intc) definitions
- *
- * Author: Steve Chen <schen@mvista.com>
- * Copyright (C) 2008-2009, MontaVista Software, Inc. <source@mvista.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-#ifndef __ASM_HARDWARE_CP_INTC_H
-#define __ASM_HARDWARE_CP_INTC_H
-
-#define CP_INTC_REV			0x00
-#define CP_INTC_CTRL			0x04
-#define CP_INTC_HOST_CTRL		0x0C
-#define CP_INTC_GLOBAL_ENABLE		0x10
-#define CP_INTC_GLOBAL_NESTING_LEVEL	0x1C
-#define CP_INTC_SYS_STAT_IDX_SET	0x20
-#define CP_INTC_SYS_STAT_IDX_CLR	0x24
-#define CP_INTC_SYS_ENABLE_IDX_SET	0x28
-#define CP_INTC_SYS_ENABLE_IDX_CLR	0x2C
-#define CP_INTC_GLOBAL_WAKEUP_ENABLE	0x30
-#define CP_INTC_HOST_ENABLE_IDX_SET	0x34
-#define CP_INTC_HOST_ENABLE_IDX_CLR	0x38
-#define CP_INTC_PACING_PRESCALE 	0x40
-#define CP_INTC_VECTOR_BASE		0x50
-#define CP_INTC_VECTOR_SIZE		0x54
-#define CP_INTC_VECTOR_NULL		0x58
-#define CP_INTC_PRIO_IDX		0x80
-#define CP_INTC_PRIO_VECTOR		0x84
-#define CP_INTC_SECURE_ENABLE		0x90
-#define CP_INTC_SECURE_PRIO_IDX 	0x94
-#define CP_INTC_PACING_PARAM(n) 	(0x0100 + (n << 4))
-#define CP_INTC_PACING_DEC(n)		(0x0104 + (n << 4))
-#define CP_INTC_PACING_MAP(n)		(0x0108 + (n << 4))
-#define CP_INTC_SYS_RAW_STAT(n) 	(0x0200 + (n << 2))
-#define CP_INTC_SYS_STAT_CLR(n) 	(0x0280 + (n << 2))
-#define CP_INTC_SYS_ENABLE_SET(n)	(0x0300 + (n << 2))
-#define CP_INTC_SYS_ENABLE_CLR(n)	(0x0380 + (n << 2))
-#define CP_INTC_CHAN_MAP(n)		(0x0400 + (n << 2))
-#define CP_INTC_HOST_MAP(n)		(0x0800 + (n << 2))
-#define CP_INTC_HOST_PRIO_IDX(n)	(0x0900 + (n << 2))
-#define CP_INTC_SYS_POLARITY(n) 	(0x0D00 + (n << 2))
-#define CP_INTC_SYS_TYPE(n)		(0x0D80 + (n << 2))
-#define CP_INTC_WAKEUP_ENABLE(n)	(0x0E00 + (n << 2))
-#define CP_INTC_DEBUG_SELECT(n) 	(0x0F00 + (n << 2))
-#define CP_INTC_SYS_SECURE_ENABLE(n)	(0x1000 + (n << 2))
-#define CP_INTC_HOST_NESTING_LEVEL(n)	(0x1100 + (n << 2))
-#define CP_INTC_HOST_ENABLE(n)		(0x1500 + (n << 2))
-#define CP_INTC_HOST_PRIO_VECTOR(n)	(0x1600 + (n << 2))
-#define CP_INTC_VECTOR_ADDR(n)		(0x2000 + (n << 2))
-
-void cp_intc_init(void);
-int cp_intc_of_init(struct device_node *, struct device_node *);
-
-#endif	/* __ASM_HARDWARE_CP_INTC_H */
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 14e0e1c40611..3f3f1169d47e 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -22,6 +22,7 @@
 #define DAVINCI_INTC_START		NR_IRQS
 #define DAVINCI_INTC_IRQ(_irqnum)	(DAVINCI_INTC_START + (_irqnum))
 
+void cp_intc_init(void);
 void davinci_timer_init(struct clk *clk);
 
 struct davinci_timer_instance {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
