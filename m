Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56533C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:33:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0593020818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BolQaNqj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YVyxgKDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0593020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ApRORqqNpdbUohKkKfVzY+AYwpUMMhP4B8QiSg0EUlQ=; b=BolQaNqjyRRArQ
	XEHXEDKlXGKgl/2JiWvhzxAiHknMkDXSSteDGYbj8n88zjCK6FU+8AQGhOaiRDNa6cLSw0FEFh9qU
	JQp0/+ikluC4nvStrMbB09XfvYHLius7ZNa1pNQrNTkToZXG9NkfG8ZGdXWiNIvL490e0k9XsllNl
	YndDuOt0api833HkMUEJmyeiRMq6z/pn/i7JA/sk1B58eP11DP51VsVaoG8m1wKSOg4tIpmAu61e0
	pPai93T/gsCj0bFDZtbaOmWqzJvUpvSW9uQ5iTY/n/DgaqU2gSxpR1fY4FlQ8YyxrW+GHQi+OjYpA
	la7w1ZiLy6Umn5hPbHDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAlY-0005k8-AH; Mon, 11 Feb 2019 12:32:52 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfT-0007VF-TH
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:26:54 +0000
Received: by mail-wm1-x342.google.com with SMTP id t200so17075932wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LSsrz2G02KfSWFioH0HpLG7LPLBDOMGfLy9Hu4/jNlI=;
 b=YVyxgKDku4pOuv5x0iSdo9blBgvFcAkZBq/8clZtlnq0GnolY9lQQkBxPuMYZ3tO83
 kVB6rLO+IumfcfA+pE/LHHXwRQHe3N14iLQQVfEQKIovjmr0XV90tYwbJHzeqOz4VWhk
 qeSdSOucO3WSIN/dNnqUh2vaAAUks94qHtRfEJt4goDP6tcC/S1AhtudJ2zmqN0vgu3V
 BySpDANYQtatLNdzSBLJrZz+S5u2URgcif4Pp+AMIcMcezH8e6gZCjncFya7ViJPrZD8
 eMFrSmuHXqCp2A+Mfkdd2MJ0Im/e9PQfxaeOI9ZC2jM1OFTxqnievCAPH86XgUDV90MD
 K9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LSsrz2G02KfSWFioH0HpLG7LPLBDOMGfLy9Hu4/jNlI=;
 b=n5STte9N9H3ylNEh00Ppk6ZIhzpRw7/FBxxRgy7lDY+CWCtJlp0WmTBUqd5qUVDZw3
 1hvEHNyhl/TqtynMGbRWckhXNdl8DRuVQaBYttT5gs5X0SKT+hW46+vpnVuN1ZGqPW4W
 PLpjwJ67a08e6bXBhltEbSBKrwZaHKDOPqCRd5Wcu+L5odFREhNVhZJEAn3toA2xkuaS
 MaIgTWxGSzySb9PHuqoWwy619O/rZ3656DxethKL9rOwXcnJxgr4ouDpgYM4fjoT0w/E
 5gS7nmkkTP3LAVlkQypdfuPMj4Duwfp2Swa5nPfXIVHlsFgYE9nGxWpFMNjJDF7qbOvW
 0O7g==
X-Gm-Message-State: AHQUAubgPxc+CswVadUpzNEziVvuMlgE0+E/Utmvcv7YQC69L+HisP4i
 bXyneqcVZzqnb7Zi/mq9aKSPeg==
X-Google-Smtp-Source: AHgI3IZkvzKlJatfCe8R3gyxkVLnX16n1tZtTLl1shVjlLpTu1MIksbdelkDfDQnOV8hJs28ZQtsQg==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr8854673wmh.86.1549887994484; 
 Mon, 11 Feb 2019 04:26:34 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:33 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 17/33] ARM: davinci: aintc: move timer-specific
 irq_set_handler() out of irq.c
Date: Mon, 11 Feb 2019 13:25:50 +0100
Message-Id: <20190211122606.8662-18-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042636_379784_EC113156 
X-CRM114-Status: GOOD (  14.45  )
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
index f5578abfc0aa..0f469c59acfb 100644
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
@@ -146,6 +144,5 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
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
