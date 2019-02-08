Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C316CC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:52:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975FC20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tktVKs+D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PCwknzLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975FC20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xHSUWerZhI4JQ/AT5KgemtXfaNUuiUCuXPHNmNTK7r8=; b=tktVKs+DeeNWLX
	0bY99fcuyJA68QEE8APxmWZWDCr1+wykixGOslhxyknFkbRhnpxFdV/oqGtnr66Y+o4DrPu7YTfWm
	sWw1K6rtUIKEciwnuZFqNHt/3oK3AgRqQX2G6im23aPmc1s+/UHa1/7/hO8s1cuBEB2dFeivrTpn1
	je54mnh99YjVfltws8qtKw3AbfXh9wnHnMHdFsc6wUgGimom+tg6Z9P8qiivJ7fSiCnr0oUgrXcOc
	AxUggd4nKMOcuaeQg7Ch15PHIFB+MbY4K4q7qMwo8xyZ/gcu9hflfLFSxAXxtDASKqgGjB2HwGaxl
	olPxUAe+fiabCRHIgDbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsAKH-0005Su-6p; Fri, 08 Feb 2019 17:52:33 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3X-00072G-Rh
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:35:22 +0000
Received: by mail-wm1-x341.google.com with SMTP id h22so7334040wmb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3iFNXNJpMgxpSvLUlNs5UzXd58xkcnpCTcNMUIsP+iw=;
 b=PCwknzLrGE9EkAPzmVpHGom+Jc8LHmbEsx4Cq4MW/tXIpep5Tg0bDaMM7rPs9h+j2y
 kxhpyTJdg4+4ePwJv1rGxJFH5wLXc7ezkJuX4/tWZGyKihkikjxcXps2Lq5EOpFBB1If
 kkUD8xZEHUoxkLWwT8b8wKfM9dYJ673DqKQtGcGBbZXq8Y168lwxukjgP2Ba6vOWNp+5
 zOHUN9YKctkBJd9NWB11Vk3oqTtVJmEp0r8uDU3bcBbRErt3c7BIz45Ac3rqrkeQ84ld
 iDfJZUt6ZroVaPotuW50ctqZ2ki7OGCNhMrNPGHPV5deLUkfSl2HNciMzIH3VLubMTA8
 645Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3iFNXNJpMgxpSvLUlNs5UzXd58xkcnpCTcNMUIsP+iw=;
 b=DVF4vsb9Dwpc06n1ezgFPy9q/dBYLETicqZ1W2+/45nmOaNs6QKs1ola31r2APNftN
 DxjI0G2fTqiGrDvENCtlL48QcCQeHepDoxzGw3BU51Gne0sO6t6u+E0yntlxgbQ4dPzS
 01q7yUegUJv1pUYLKf7S5iOs0+OhV+ve7l/pf29wFJkCpJ8jQea0UH9BStOdWOkAN4Kz
 10FhNgverHTy/OWYmRjhlRaFZGMv74dbKjCTffs5mDoc4wBDPljbrTlKgxfSGr/caZ2Q
 i592GpBOpi3KJz7apbQWTVAxUt3envWGL2udM1xQQ/kvD/8Ut9NHpeg4/6SZqNv3PlHl
 hNAA==
X-Gm-Message-State: AHQUAuYVylWMWsqByDIH4z+amE5ibsC8QnUfFzk6xxqkY+nc16xtMbcM
 vDDd9ysWo5qGt+iO67++cGr35Q==
X-Google-Smtp-Source: AHgI3IaPVfW4ADR2MHJbxzRaNDN4otCcg/Z4V3FgMmW0ZYeHIiakaQ8iCqUFz2QmYgcW6mKWfmuw0A==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr17015431wrm.238.1549647314378; 
 Fri, 08 Feb 2019 09:35:14 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:13 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 07/33] ARM: davinci: select SPARSE_IRQ
Date: Fri,  8 Feb 2019 18:34:32 +0100
Message-Id: <20190208173458.4801-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_093516_218320_8BDE4E99 
X-CRM114-Status: GOOD (  14.59  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/Kconfig                            | 1 +
 arch/arm/mach-davinci/board-da830-evm.c     | 1 +
 arch/arm/mach-davinci/board-da850-evm.c     | 1 +
 arch/arm/mach-davinci/board-dm644x-evm.c    | 1 +
 arch/arm/mach-davinci/devices-da8xx.c       | 1 +
 arch/arm/mach-davinci/include/mach/common.h | 4 +++-
 arch/arm/mach-davinci/include/mach/irqs.h   | 1 -
 arch/arm/mach-davinci/irq.c                 | 1 +
 8 files changed, 9 insertions(+), 2 deletions(-)

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
index 298165095d31..3104a3eb2ddf 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -25,6 +25,7 @@
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/time.h>
+#include <mach/irqs.h>
 
 #include "asp.h"
 #include "cpuidle.h"
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index d840023eaaac..1ceed0345988 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -17,7 +17,9 @@
 #include <linux/types.h>
 #include <linux/reboot.h>
 
-#define DAVINCI_INTC_START		0
+#include <asm/irq.h>
+
+#define DAVINCI_INTC_START		NR_IRQS
 #define DAVINCI_INTC_IRQ(_irqnum)	(DAVINCI_INTC_START + (_irqnum))
 
 void davinci_timer_init(struct clk *clk);
diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-davinci/include/mach/irqs.h
index 03c446635301..8f9fc7a56ce8 100644
--- a/arch/arm/mach-davinci/include/mach/irqs.h
+++ b/arch/arm/mach-davinci/include/mach/irqs.h
@@ -401,6 +401,5 @@
 /* da850 currently has the most gpio pins (144) */
 #define DAVINCI_N_GPIO			144
 /* da850 currently has the most irqs so use DA850_N_CP_INTC_IRQ */
-#define NR_IRQS				(DA850_N_CP_INTC_IRQ + DAVINCI_N_GPIO)
 
 #endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index de31be42a394..16ac28833eb4 100644
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
