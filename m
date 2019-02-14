Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9E6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:11:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CC3218FF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nc/QavVl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qDQIwUd3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xFxgMtI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CC3218FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2t+oSgyHjm9G3iWvmw58RNsIxZKRNu+tdGNvj5Opa0Q=; b=nc/QavVlu/Cy1a
	gbxYVhNYLhzzRyFCx1kP1UYfEm7qgJD7LURTJ66YAFHz02gUb3unl8Kab/SMDTxxiV/0Dm5qXELur
	cqpt4mjOrqHtBFoAgqMVFBFkbBszLuL7CiBN6zLr/P4IzuQzz1MqA2t/nyCYnaXRIQvY1bohDOgxY
	5aI+eTh/Tv+meu62RCS/gBaNycisgv1Npn1Gyy+kiQmdp8zyUIJ8IK31ZwVXbNWTPskWgjy6/tonf
	hWhAM/tr/dl4Mpvh2NqAS+9InhAjCDu4IOLRmRE3ruEhD8VPVMesFlH/TIQgkCxzUksOjh0HJqeaY
	2UxEVuNbPJr7OMWweVhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIfI-0003LX-N5; Thu, 14 Feb 2019 15:11:04 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIex-0002yt-PZ
 for linux-arm-kernel@bombadil.infradead.org; Thu, 14 Feb 2019 15:10:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2DeiZ8D7UiVmGGxb7P14iUU29iY/Sp7nuKJSfeun7aM=; b=qDQIwUd3ritg490n2f80IPqVju
 nDBuxQNZAZhwGQsZx+rLPJaBxYdcd4ghQGm/pwzX8l2UJ/IqEmedx+NRHp0rhQEMzjAQEqLKdrtTg
 a18DlEHbnKLrXuo2tDwsGg9puCfUclJnBiPW8TJAzyhadVaYzqJamH8ZBMIHyeGTzWWDSXrmWIO23
 y7PIt+/HZrU7CxUzcyPBlS7x4JC/arbA0k01fcaYh09LOZIFYUYOgSlhIov7fMGD4o2f8ATJiFJWy
 zC2/5aGA6cQR9/zq0JR37Le9nyQj3puIrbBfgkiqIHGz/2Gr89PuvVYoiEYSdp4gl7uFC7/LNsesE
 PBgTb2gw==;
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIO0-00060o-HW
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:20 +0000
Received: by mail-wm1-x341.google.com with SMTP id f16so6377269wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2DeiZ8D7UiVmGGxb7P14iUU29iY/Sp7nuKJSfeun7aM=;
 b=xFxgMtI/hszP7l26U7gZsptViddGHhwWiNFBsQFQZyWkcfsNodCupCe8LLIGiYnhml
 Ac9Nn+zEFzWOE+Y0OneQvcX49ZpDeQciCJLY0SYprRNLBCzOc84SlEICqOv/EgdHdvU6
 q124rwSGhCoERs8iIcxJA2YlARpPVFA43R9bK3TUtWq7e85yvITpdQ0pmFx3R10o6Qma
 SYeE2qXXt3+llmwLnOIPeXsfwtD8yzRZMHL27R/GOB6TPiD1Zepb391S5B4w4vyqoByt
 c7b9mrdvYdlAbLEmdVA9giKFIYmlvEceWipUHf7lm8iM5tSlXJjnZ48bfEiReWn2ezT6
 DSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2DeiZ8D7UiVmGGxb7P14iUU29iY/Sp7nuKJSfeun7aM=;
 b=U+k7JUoBpHhs663oAQNG+y8a69sVtAkMtilkEYzRxGUNbcsPn04p8T3ehQ3RNQ+yyk
 DZI2HjHYGaCIC9wxjcyL3RY0qRTcZSmLJ4/R/h84Ydbd+ISavXe/1qKatkDXtRI0t5jb
 kTXz5lNNRKQUwMLkSTmQ7TNZpGdeXjD1RaNdPPruWa2gipXS5r8BHSr8Meeh+I6CE6fM
 smORi8/HV1lpBlEIBJcwj2LaRKIOKoALl/Z9qjv2SN8dXCGH2FYQgTnsayWchQnD23qZ
 iwEkeb26qkqwGZ4xKpj5W4eNEIhwkJlfv0qfuYudo/KSjkijWPljofHYXeNPUcRScEnA
 ncow==
X-Gm-Message-State: AHQUAuaHKQbFXnYrBSPMp5zOEEAy3muSbHIgU5zgvYPiYefZ8CQu1vrM
 MzSjEk4wWoMXkU9zj+CTy9p3dw==
X-Google-Smtp-Source: AHgI3IY42Lw4wsVpj3DXVfjvxsXO49Sdg1UiTsHOVzwnNhqCKFetnJo1H93Ip4H7aOMbLTNq6cLaaw==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr2868844wmb.48.1550155990511;
 Thu, 14 Feb 2019 06:53:10 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:53:09 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 23/37] ARM: davinci: cp-intc: remove cp_intc.h
Date: Thu, 14 Feb 2019 15:52:17 +0100
Message-Id: <20190214145231.8750-24-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_095312_661273_B6B5DD10 
X-CRM114-Status: GOOD (  19.79  )
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
