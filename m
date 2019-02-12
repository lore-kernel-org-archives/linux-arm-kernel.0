Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70348C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:43:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3580820661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZjozBaq7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="n6eSnZEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3580820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XHVPDqaUZWiBLglp95JGYgjyBfxxE9hPmM452B7sdJo=; b=ZjozBaq7rudKTs
	kfzFWhXUTcVV8K54GjZW0F4yBCf1J/NRppR+t/mQZ7oMdzz/jHNlD6Nk59X+evIjAtLyrvsQf1ylw
	Lb2Fyp2JlC/MER0MHXK1tQGHc0ygF/8+LC3GzQM6KaNWaj//y/j+9mYqADBkvgtJBMuHO2TSDm5Pf
	lZsFiSne0ekWtkQxDAAHkW+jsf6XvuptuYeA9Czj5l7bdlqO/UKbZNIUZMlNL/t8BBqr2jngJ+jot
	jy1EJq/NRHPdDylh2xaxKAnRx0aCDa64JjVU2TsQQMCW+xO/05/ZEn4U85WUO/x50yJ2S2C8W8GJy
	Dn6y5E9yO9FU35LgAFfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVXd-000334-1k; Tue, 12 Feb 2019 10:43:53 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTB-00068R-Fg
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:36 +0000
Received: by mail-wr1-x444.google.com with SMTP id w17so2049864wrn.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gQeA7phzsYQZFK2JLuLMFYmsphbl1nQUs0emAC/KfyA=;
 b=n6eSnZENp5CA4dJTiQDUBwm3VA2l29r1aESaNnhRr7Zm9C6qxlg223GgRLvh6zWydb
 a4TWc1UZwaq1ky2AzLJBZUvCbw353k+/hkQc+Dcs1ZJm8048qV66q2vdWvWrwrKjCasi
 8ZJ4p6Nvl4MK+3J1K47N5pgaSz8TbzuB1mI0sweggpwZR2RlZCfFDd7/MWu6OtleK0uP
 pXianIdYG6+nfL9vP2kW6G+wEU4o0yuUU/3b33ckIKVqRYUWCxwEi4JQXkmfk9ZjiYTx
 aPvGW95WA7cgsQzwRXlWYeOZ5u+w7z4d5mmaISaz5sklUiLY+wQk43mbPU1bYM+WAp41
 gDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gQeA7phzsYQZFK2JLuLMFYmsphbl1nQUs0emAC/KfyA=;
 b=Ua6LwIR+DODakUxbHnatw7h7HaLoYgmQGCl55vU0i91N8cmV8++uzCYyDIJw9WmgKy
 zB9bQ3ZVT5H4f2jwK/84z/npP70gJZLdropo/ONFMhrOgkQ+kfB5vwFGwxyMp0YcVa7/
 Kw691sB4qCJnZBBk2VmaNbODRdf/TI+bXt9fNAGsQfjSOtSXGqRbtOvbLcG8DqKUbvqW
 cbd6FMCldp8IMxfvxn2LZ7VDXZwV0Ao201uBMi4tp6uIBthd714SVGTDISRvZdKAbpBD
 2iGZTBgreOJsR90LO60PI4DOXEoLm3ST9t40atyYwbdtRJab3eP9CIsDCWE0AmpB3Nrm
 gIxg==
X-Gm-Message-State: AHQUAub7oYPpY8OjvZj6CG7Qd0M+HSrOIZd1Bdbydy4kjnFnyAgZ4Hl7
 U9W1U2dMB84owQd7rMNif0daYqpM/Ig=
X-Google-Smtp-Source: AHgI3IYpO2OxLB58OzUo9B1D32+LXXFPNPp08t5/EChNC+BQ7zyhKHPsaGTIRoRkY9Lyr7d02fq6Fw==
X-Received: by 2002:adf:9f48:: with SMTP id f8mr2394414wrg.151.1549967955822; 
 Tue, 12 Feb 2019 02:39:15 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:15 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 16/37] ARM: davinci: aintc: use the new irqchip config
 structure in dm* SoCs
Date: Tue, 12 Feb 2019 11:38:14 +0100
Message-Id: <20190212103835.7768-17-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023918_730826_F707FB9F 
X-CRM114-Status: GOOD (  12.76  )
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

Add the new-style config structures for dm* SoCs. They will be used
once we make the aintc driver stop using davinci_soc_info.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm355.c  | 11 +++++++++++
 arch/arm/mach-davinci/dm365.c  | 11 +++++++++++
 arch/arm/mach-davinci/dm644x.c | 11 +++++++++++
 arch/arm/mach-davinci/dm646x.c | 11 +++++++++++
 4 files changed, 44 insertions(+)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index e2b680e9944b..ff79c1a17fae 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_data/spi-davinci.h>
@@ -792,6 +793,16 @@ int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
+static const struct davinci_aintc_config dm355_aintc_config = {
+	.reg = {
+		.start		= DAVINCI_ARM_INTC_BASE,
+		.end		= DAVINCI_ARM_INTC_BASE + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= 64,
+	.prios			= dm355_default_priorities,
+};
+
 void __init dm355_init_irq(void)
 {
 	davinci_aintc_init();
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 76507dcbcb3a..44dc3ca94dd3 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -19,6 +19,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_data/keyscan-davinci.h>
@@ -1051,6 +1052,16 @@ int __init dm365_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
+static const struct davinci_aintc_config dm365_aintc_config = {
+	.reg = {
+		.start		= DAVINCI_ARM_INTC_BASE,
+		.end		= DAVINCI_ARM_INTC_BASE + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= 64,
+	.prios			= dm365_default_priorities,
+};
+
 void __init dm365_init_irq(void)
 {
 	davinci_aintc_init();
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 27c73bc54069..0b0ecac36486 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -14,6 +14,7 @@
 #include <linux/clkdev.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_device.h>
@@ -728,6 +729,16 @@ int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
 	return 0;
 }
 
+static const struct davinci_aintc_config dm644x_aintc_config = {
+	.reg = {
+		.start		= DAVINCI_ARM_INTC_BASE,
+		.end		= DAVINCI_ARM_INTC_BASE + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= 64,
+	.prios			= dm644x_default_priorities,
+};
+
 void __init dm644x_init_irq(void)
 {
 	davinci_aintc_init();
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 98fc5e3815b9..4e871d00e4e9 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_device.h>
@@ -689,6 +690,16 @@ void __init dm646x_register_clocks(void)
 	platform_device_register(&dm646x_pll2_device);
 }
 
+static const struct davinci_aintc_config dm646x_aintc_config = {
+	.reg = {
+		.start		= DAVINCI_ARM_INTC_BASE,
+		.end		= DAVINCI_ARM_INTC_BASE + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= 64,
+	.prios			= dm646x_default_priorities,
+};
+
 void __init dm646x_init_irq(void)
 {
 	davinci_aintc_init();
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
