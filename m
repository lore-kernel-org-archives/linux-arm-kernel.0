Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8310C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FEAF2085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="US06iTLM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="brWI3BPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEAF2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sE65FvVfrcZXNieuu0mtn71UwjvpH8p+LmJbmFQtxv0=; b=US06iTLMkaHjiA
	ZyNnUi6Vh/fkaESZUIvQFOI8DL04Q+wTXMGjvzZ4uvcCoc5tIO47BCvwSZDnFA6nV7zLsOJEtMtPM
	dGqhecpPZUoXQVICB9Xu5I74TNc1DcOUYLZdwV9IQ2QFN9x3rxPIS79AHSCu0RxI/4MSOpKSan1ME
	l+JabbDJi7RwUICBVAeW6P+8YtTa1I7AzqssHxmW7Zz8ZSMpBYdaQ0QVvW2pKKTGF3x1syLyOfRYa
	c6Dg+BYPZAo1ftUOuCOceMJynZgEEVUaC9TAcjx2F4tWVTzQy2dYrN5JpVXdMFMpDUt978x0HsPnj
	ojckdE6DpS58Cm2Sf9Eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCam-00073R-4p; Thu, 31 Jan 2019 13:41:20 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZM-0004e0-UF
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:00 +0000
Received: by mail-wm1-x344.google.com with SMTP id p6so2603514wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SFgXQcpQR4vdt1SMIVPSBQQ8pz6BekA4S3eBHk0UlR8=;
 b=brWI3BPYpln2UJUSr1verribUHRv2VsT69CGVTL3vUAKKsnGH7XxRz/rQdnaNcLEDF
 eyk7A6/yCMU8XkK2MWZJWDfYbTb6pZ6wI4sKEP/hxjh7VqPdz6VeCp3k/5G+8xHbR8+i
 HKOVXI3CNiRNN2iZc2Fd8wu7PbYRu2x4z12eq7CVKESdGdrBur2lKJQQQq9Jqn/h4lfl
 W2SEcamaEemjeVm7Hqd6owEHwpE62SMczZy49MSG4GU7JBJmLSqq1o8Tdz/CXM0EZToM
 UEcTnxZu+qlk0arLSDdONSm1QNbuP04E0QJhIhrwURMrcqZQgUOtgbnCle4Pp96Y/BUy
 THLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SFgXQcpQR4vdt1SMIVPSBQQ8pz6BekA4S3eBHk0UlR8=;
 b=U68YjTyJyMhOxN21bOJfaaoF1dgRHH3SyKzDot6TEMHTSuEdCi3tBEMpop+HUbAfPU
 OVNpOwyKvYIA5LOn4wKbeDVwfzmxK56X7iqLhDyuHNG0Qzh69ief5OgqQDn+yU6rDLko
 phKbvqwvwiTUTM25I1gUlhS1jddESoMltLn/9K4GDU6ZYCf3V605nYNeSN5WVWm3W/o+
 zxv6OpG9hyDa/p1Y9w5NEznZSda4vtdpq3NI3xFp5VshYAPpvOAmbeV+1NdB5dqlh1T9
 563f+XejWj69htokrZXqOQCa5IcwaRVjh/UM3xbtnpqsQPqaiOXdmYV4AiSOQ3suYM/O
 x91w==
X-Gm-Message-State: AJcUukcWkLc63LCbxQu5Wc237u5glItlWw5nXsvdsuU8HwODpxjPuzHj
 q1I3z3EEZwHOL4uLbWXAJn0KzQ==
X-Google-Smtp-Source: ALg8bN6LWOAFnDr43FzopNmhCHyQIubos78XrOLxOa9Ydu1zfSe/y62SWHS8MD58VWZorZTbFlmmaA==
X-Received: by 2002:a1c:a755:: with SMTP id q82mr30630055wme.6.1548941991499; 
 Thu, 31 Jan 2019 05:39:51 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:39:50 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 08/35] ARM: davinci: select SPARSE_IRQ
Date: Thu, 31 Jan 2019 14:39:01 +0100
Message-Id: <20190131133928.17985-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_053953_463741_C8563ECB 
X-CRM114-Status: GOOD (  13.56  )
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

Everything is in place now for SPARSE_IRQ. Select it and set
DAVINCI_INTC_START to NR_IRQS.

We now need to include mach/irqs.h in a couple places as it is no
longer indirectly included after selecting SPARSE_IRQ.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/Kconfig                          | 1 +
 arch/arm/mach-davinci/board-da830-evm.c   | 1 +
 arch/arm/mach-davinci/board-da850-evm.c   | 1 +
 arch/arm/mach-davinci/board-dm644x-evm.c  | 1 +
 arch/arm/mach-davinci/devices-da8xx.c     | 1 +
 arch/arm/mach-davinci/include/mach/irqs.h | 5 +++--
 arch/arm/mach-davinci/irq.c               | 1 +
 7 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f7770fdcad68..1037f49e050f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -595,6 +595,7 @@ config ARCH_DAVINCI
 	select PM_GENERIC_DOMAINS if PM
 	select PM_GENERIC_DOMAINS_OF if PM && OF
 	select RESET_CONTROLLER
+	select SPARSE_IRQ
 	select USE_OF
 	select ZONE_DMA
 	help
diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index c4da635ee4ce..41f5a51fee9a 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -36,6 +36,7 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include "cp_intc.h"
 #include <mach/mux.h>
 #include <mach/da8xx.h>
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 44bca048dfd0..317f48560534 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -46,6 +46,7 @@
 #include "cp_intc.h"
 #include <mach/da8xx.h>
 #include <mach/mux.h>
+#include <mach/irqs.h>
 #include "sram.h"
 
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index b80c4ee76217..16ffed2525e6 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -36,6 +36,7 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include <linux/platform_data/i2c-davinci.h>
 #include <mach/serial.h>
 #include <mach/mux.h>
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index cf78da5ab054..65edd2aa9db5 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -25,6 +25,7 @@
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/time.h>
+#include <mach/irqs.h>
 
 #include "asp.h"
 #include "cpuidle.h"
diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-davinci/include/mach/irqs.h
index 14fa668d4e8d..317cbc42e5cd 100644
--- a/arch/arm/mach-davinci/include/mach/irqs.h
+++ b/arch/arm/mach-davinci/include/mach/irqs.h
@@ -27,10 +27,12 @@
 #ifndef __ASM_ARCH_IRQS_H
 #define __ASM_ARCH_IRQS_H
 
+#include <asm/irq.h>
+
 /* Base address */
 #define DAVINCI_ARM_INTC_BASE 0x01C48000
 
-#define DAVINCI_INTC_START		0
+#define DAVINCI_INTC_START		NR_IRQS
 #define DAVINCI_INTC_IRQ(_irqnum)	(DAVINCI_INTC_START + (_irqnum))
 
 /* Interrupt lines */
@@ -404,6 +406,5 @@
 /* da850 currently has the most gpio pins (144) */
 #define DAVINCI_N_GPIO			144
 /* da850 currently has the most irqs so use DA850_N_CP_INTC_IRQ */
-#define NR_IRQS				(DA850_N_CP_INTC_IRQ + DAVINCI_N_GPIO)
 
 #endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index c874ea269411..2b8b653aeb98 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -28,6 +28,7 @@
 #include <mach/hardware.h>
 #include <mach/cputype.h>
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
