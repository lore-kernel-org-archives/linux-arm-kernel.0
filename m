Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED79C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:11:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65AC42184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y92ePtQf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="13zm1kX9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="axedGr3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AC42184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BKHldQ7/rDgTdiy7QzUHYmcwh/BtXmqRmI1rexZWDbU=; b=Y92ePtQforzOSI
	hOhw7YfgBoI+a92kTBCzh7kdb22iVRID6ZafisNJz262/qL2C0Lq9q1b3tQRwhNcgYPrKBZpjAvbj
	1Sxl2ZbwR72jBmG7H6SHur4ZvvdxIAkTE5u2wq9pIRcqUs8TVdYaS+jFYqGmOGMLQ8RlUNSbtUSil
	eOZA5klU83ix2+gbciIC6WwP+fZ6x4OrKsIde+yDIBXa9WR4SBLsOrgJnxOgxoQ4yxrxh6YdNXCHB
	oxdS0DtfNKQ1xMBO67XLHIGxBuOtg8o1K15+4idkV46m5p18OsMJ0sfov+e1MBMsCXrt3vmaZhVBS
	E0YthzoxA/3buS+9pHzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVxv-0003SJ-JY; Tue, 12 Feb 2019 11:11:03 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVxb-00037j-Rp
 for linux-arm-kernel@bombadil.infradead.org; Tue, 12 Feb 2019 11:10:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aq10+lp6v2F+7BT6U8iiQKTET70oYlE3URFTZA4Hifc=; b=13zm1kX9PmE+wKBXB/cv/J/GDj
 xeldkHdcncivFMHPDdNvXmCFwMaABR5lBVvQEkbqODgp3NHYMWslA+0GWmrYC/tK8H8FCL8HHCZmp
 EBL2W1nFdUfHlrIppyySu4tKKCTNxTuFphGnHHjVA9aGc5WLQzIgXmlv6J1FAWgLcm7lJFDDIZmPd
 XjEEljTiVFifcH8LE9zZyABKkb02bwnFE9m4OQ0iN3MJdqlCPCzgc/etGddZ/vfftuh5GP1iuabtk
 jluw//zyGbr5xa2z2uzNhZeUQxpqzzDyA8TjlaNwH9KbEs4gsrr2BpD2z+eh+LMrgnNegc74BZFCq
 XDGGZY2A==;
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTK-0002En-Is
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:28 +0000
Received: by mail-wr1-x443.google.com with SMTP id q1so2079408wrp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aq10+lp6v2F+7BT6U8iiQKTET70oYlE3URFTZA4Hifc=;
 b=axedGr3VKUoULid2kydrcOdlkVYMhI0sCXXnEjaZMk1jOabjECRuUvCSr73GCOgPWt
 30otKyOx47h6zsUHEXDqeKd+Zec6uXAJgdMC3zAxTUjnlkVsdGEhFDf1UIewOU3KBTEy
 oXFSbAAOgkEJbGDAnGgZn5nNNV2vQZoVrMx1yg/IVQNW76kuYz/Wxz+utP4gk5/hEy1h
 +ZijJx18YfEu9hbScOtRRNuSwLARbTW9IV+a7JBUzBQ37bIl/zIEBRcGgKa3a/C3AqQI
 /JEYHe8sv1EhdLUkDOUs+LynKKI3ftSlt1s0F6pmpdOqtNJ3zTf2YYwnKOX34ebFCQNZ
 7MMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aq10+lp6v2F+7BT6U8iiQKTET70oYlE3URFTZA4Hifc=;
 b=Yq//nDrKQPZMvbcdOmv4y2BKOnmURto8kEbt/3ho8srJ8662SRwgwTu7zLyh46jnLA
 9xG+WIEa6gMxE+PtUPf98jMaVyqmtLt+TNWjLIWro8t+u+5cSoknOc2M14tXiVY2E0Oe
 Sv+6x1a1acvRulSl8aXtljrydO9cBoVFgD4vO90MZzD2IRRNa96dXDB7dqH4QDdZdc3F
 tN+Rn0Wf4RZqCYGwVunKtLDuWBMPzpzxIYGnV1Jy45uIN5RiYFMAlTWbIudvn+pA+BMg
 gbLHiimZq/htPYiCuAKe/3XXU8QcUcKWPsXNADu4zHafbipNY04H6yUTTwQxbZc5uver
 iOvA==
X-Gm-Message-State: AHQUAuZt1/beyAeL1hKVIhQdwy0rMe/Armry7Q1HmacqYAE1etz6AmhT
 N9uTLqu8N6Qy7nMAlgNtFFUkgQ==
X-Google-Smtp-Source: AHgI3IY+aQ72VNrbcnyhZDLspEKHNoYxzMp3S9Dplvpq/FjDHwyKZeMXMXI/zkqx0kKu2Spbkbr47w==
X-Received: by 2002:a05:6000:10c1:: with SMTP id
 b1mr2179886wrx.275.1549967960258; 
 Tue, 12 Feb 2019 02:39:20 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:19 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 20/37] ARM: davinci: aintc: move timer-specific
 irq_set_handler() out of irq.c
Date: Tue, 12 Feb 2019 11:38:18 +0100
Message-Id: <20190212103835.7768-21-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_053926_873695_A19AF51A 
X-CRM114-Status: GOOD (  14.58  )
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

I've been unable to figure out exactly why, but it seems that the
IRQ_TINT1_TINT34 interrupt for timer 1 needs to be handled as a
level irq, not edge like all others.

Let's move the handler setup out of the aintc driver where it's lived
since the beginning and into the dm* SoC-specific files where it
belongs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm355.c  | 8 ++++++++
 arch/arm/mach-davinci/dm365.c  | 8 ++++++++
 arch/arm/mach-davinci/dm644x.c | 8 ++++++++
 arch/arm/mach-davinci/dm646x.c | 8 ++++++++
 arch/arm/mach-davinci/irq.c    | 3 ---
 5 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index c7cd765114af..a732f2ea1d9a 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -744,6 +745,13 @@ void __init dm355_init_time(void)
 	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
 	dm355_psc_init(NULL, psc);
 
+	/*
+	 * Nobody knows why anymore, but this interrupt has been handled as
+	 * a level irq from the very beginning of davinci support in mainline
+	 * linux.
+	 */
+	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
+
 	clk = clk_get(NULL, "timer0");
 
 	davinci_timer_init(clk);
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index bde3c3b94cc9..79afde34cfbb 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -19,6 +19,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -785,6 +786,13 @@ void __init dm365_init_time(void)
 	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
 	dm365_psc_init(NULL, psc);
 
+	/*
+	 * Nobody knows why anymore, but this interrupt has been handled as
+	 * a level irq from the very beginning of davinci support in mainline
+	 * linux.
+	 */
+	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
+
 	clk = clk_get(NULL, "timer0");
 
 	davinci_timer_init(clk);
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 6d3498058283..007d979d2d64 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -14,6 +14,7 @@
 #include <linux/clkdev.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -680,6 +681,13 @@ void __init dm644x_init_time(void)
 	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
 	dm644x_psc_init(NULL, psc);
 
+	/*
+	 * Nobody knows why anymore, but this interrupt has been handled as
+	 * a level irq from the very beginning of davinci support in mainline
+	 * linux.
+	 */
+	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
+
 	clk = clk_get(NULL, "timer0");
 
 	davinci_timer_init(clk);
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index a0a8b336c1a4..a643d78ad644 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
@@ -664,6 +665,13 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
 	dm646x_psc_init(NULL, psc);
 
+	/*
+	 * Nobody knows why anymore, but this interrupt has been handled as
+	 * a level irq from the very beginning of davinci support in mainline
+	 * linux.
+	 */
+	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
+
 	clk = clk_get(NULL, "timer0");
 
 	davinci_timer_init(clk);
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 2b6943731af9..92b6e653d8cb 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -18,8 +18,6 @@
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 
-#include "irqs.h"
-
 #define DAVINCI_AINTC_FIQ_REG0		0x00
 #define DAVINCI_AINTC_FIQ_REG1		0x04
 #define DAVINCI_AINTC_IRQ_REG0		0x08
@@ -165,6 +163,5 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 		davinci_aintc_setup_gc(davinci_aintc_base + reg_off,
 				       irq_base + irq_off, 32);
 
-	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
 	set_handle_irq(davinci_aintc_handle_irq);
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
