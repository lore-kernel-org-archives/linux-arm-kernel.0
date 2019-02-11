Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFB8C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:28:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795602075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MESuTHuJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YeTM9cV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795602075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xHSUWerZhI4JQ/AT5KgemtXfaNUuiUCuXPHNmNTK7r8=; b=MESuTHuJQb92Um
	CRKULihb3Sn9Ki2SSw33/dYmwKMonp2lOM33xOOzUQLCqaM/pcvrUOb26w/vpDzhtPBg1QymFs7OA
	w9NMfs26ck+mloghSzbb0z6FkIChyrHP4RNpfsORf4WU9b4yNqO8GvGk6Ps2HFlC0MaHv2aXhqQ7y
	pwbX0MnyUHRg/F/qtRYqa6uwN8oXML+RwYetHt2P3VvAyt/eaWmhEwZh5YMqgzESWcbD/Xbu5owUz
	lLl1S+PgkwIN9eJi8ADhSUu0Op7xLduSSVbYFAN+OlExBqxk6M4c9/Yeu9fjHB3q5kCUDoVF1Qi2Z
	8s8X5An9ylJ+HQgW095Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAgm-0000ZU-Er; Mon, 11 Feb 2019 12:27:56 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfH-0007H1-KT
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:26:33 +0000
Received: by mail-wm1-x344.google.com with SMTP id r17so17359564wmh.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3iFNXNJpMgxpSvLUlNs5UzXd58xkcnpCTcNMUIsP+iw=;
 b=YeTM9cV6nqL1NTA9+MrgptEjY8Ucimt72SqcFCuffw1TfHOW4xZK4qpg3XQBztVZzH
 CUC1iCP1Jl0R1Hquv3ZtYlhxouZ2Vivr31acjAqa+sJAWbrDGuLWuKVLDypM5dUqcaBN
 moNhNZ7/db745CjFyNcExXVpqJ3US6WTIkKlvKQxdS7vHLmB4hYqejAXd6xTmdJNne66
 Yf72DSBxwGomr5345ybVQnkKDZ8fyJGH4CpO9un6Q+SAzNwdfNSvKffqmpaphLhNxiDW
 u0hrFd52wTdKCwUeFW2vNH6d9FkWNzmjle2zebeRptWQ3cK2AHUzqBGJV6TtjMfhnY9F
 /o2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3iFNXNJpMgxpSvLUlNs5UzXd58xkcnpCTcNMUIsP+iw=;
 b=nzsouUo9IQ4k8QZS1jBThO+CZEgOt248bokvGcZTJomqB+68QNALW4Rqe8IqP5Vf/Q
 afGt6IZRFiHlyKcqW6NDUjrWZcnqkJGCWOIG+5wJ3Y0F3oSPPHaBF+y7QQYvBlXsG6RO
 UApGgmRiZW+iR6Tar+4zHl/gObJNthPaWqnODpff0eFv6vZVa+XE05AfgQ+i8LouRGMy
 aYIUwcrUy2pDyW4NrpMX9VXQDX+bnURmCTU6oslHtUBZWmApKyBSxxShbx5tF6eRpkjB
 mLeBuq4Ha61cEjI+EmND/lut11rTYZZAyu4ql6sog1OeyHctVCHb+4QOUx4y6OGDtt33
 8rDg==
X-Gm-Message-State: AHQUAuaXFkcK+q68vJnBR6DNsaKTm+76wfjJioRlnsK1FGjgzsXXmqNZ
 THrc/h2LohPU6WToj0WtGdMpSw==
X-Google-Smtp-Source: AHgI3IYX1HwJCSlNe3y1pwY0L0hmnxiwfLt1d4Bhb0pjouZsYnvUHpJf/LPIt1ovhK1966vUB6iIUQ==
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr7560778wmh.83.1549887982139; 
 Mon, 11 Feb 2019 04:26:22 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:21 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 07/33] ARM: davinci: select SPARSE_IRQ
Date: Mon, 11 Feb 2019 13:25:40 +0100
Message-Id: <20190211122606.8662-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042624_138245_E34E7858 
X-CRM114-Status: GOOD (  14.08  )
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
