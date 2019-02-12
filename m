Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD62C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F82820842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NtMlC6gm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="scpWTfj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F82820842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZKmNiCIWfdNgoi3niEeLNGjYZXTS4fcc2M4PHlX+Zt8=; b=NtMlC6gmrBeehz
	gobmUECBrqDliIX05gxFJz9CNUU9U1J1VoZeGva/mo7NNHegiTFd3x1JAD6z7bOEB4KdfRL5yURmo
	wRKEJvJBYq2OvSHO1MEYh+TBvqDmrGk72DATGDMoGYreTE3JuZ87OXnwZiR3xfQC3mQs8C5WHuw2l
	K9xST2k1+/aFxsoemTrwuXxsE/4vVRwkIx3wPQuQlt6l56vLG9P7IrsrTkcdiwPEQRmRzrQkzeUSR
	CdFRgb8Z+tEzm+3ElFeKdfzl9j3hU/O5NqOVYMuZNAkhOEDs3q3eiG9zFUln1vscIKIVxuQkve7nM
	IvovLcB+kfeMd2D20iZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVUz-0000iz-RP; Tue, 12 Feb 2019 10:41:09 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVT1-0005wv-NK
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:15 +0000
Received: by mail-wm1-x343.google.com with SMTP id q21so2432535wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9eYjYNduzPZNy43v8Fvj91hRMMSatkg8sxxgZqtJcIw=;
 b=scpWTfj6AIQBsrq8qtg/D72R0kOYfWTl2M3Vvp5bUjnp/qum9J2pfmEIBevpiUovsm
 MSmcu/QNgWOiwSXY/zLgA96rWtHhM5D1ufut9HeM1AJYZEjByceCLAHqZRpzFQxCKpcf
 8GySpjQ8lnXivaupCSRuJU/OPD9qxYl1yX84rpHqIijckq4LiZs/lH/N9qjn17RnGTwI
 xaG4m/tO0INZkXkC43SVmv5lJjgIDMveY5CkKsytQUYes3kPa+cS3LlZbuTJzb+VcTh3
 RAiWmZnTJYxf4KOcOMAmRyBOBNxHON/jjXDTPxmFVCbwYC/b9orSqREl+oBNdO1fTwYJ
 VexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9eYjYNduzPZNy43v8Fvj91hRMMSatkg8sxxgZqtJcIw=;
 b=GzrEmfZr7ue8McGxrPUnksQHvRSsXcqm2nWemVAP5PNVClMljg5F43UzgnjF6Irc/o
 tW2KABDSX/dSjhMiKF9rbgIJ4RjZ4T1Ddd50eilhn8kBEkY9tljuiBrF+lNuru1kJGHl
 vUp2tFMgQzZuBR8tNkyW6OSMRNcWthFQDtWY1RcoNI8dHTbsElKZC0kyS+mCB7CRqhke
 bvdoAXjTZDNY7Q6cy69xJQUzLaf/eM3BGic8TXr428syd+QLLX45INISwso5AuVNLfVn
 UNq5qPfHSUZOt5Pox4kem/m6mKLMxZudya08kD3jaLEDdEHrkpmQS0be+IvcX4jx1rIi
 R6qw==
X-Gm-Message-State: AHQUAuZ72te/8sa/hSSNFE2+oBfHtgvCyw+X5M0knaWKei/VNz41nWgs
 UvK8NRh+soSRkxBePwBH5IZaog==
X-Google-Smtp-Source: AHgI3IZiMw2guHRj6ab24ZpqwfjDpkTeg7tEybiHDP7sfihCTVoIKU3lOk77ryJcZTvrBfatm6PHIQ==
X-Received: by 2002:a1c:eb1a:: with SMTP id j26mr2235754wmh.127.1549967946056; 
 Tue, 12 Feb 2019 02:39:06 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:05 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 08/37] ARM: davinci: select SPARSE_IRQ
Date: Tue, 12 Feb 2019 11:38:06 +0100
Message-Id: <20190212103835.7768-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023908_086416_023ABEC8 
X-CRM114-Status: GOOD (  14.43  )
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
index 80bf99c8fa55..34b0eec4de4e 100644
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
