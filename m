Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CFBC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:32:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB85320818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AqeVKIoH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="f6BueJ6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB85320818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XHVPDqaUZWiBLglp95JGYgjyBfxxE9hPmM452B7sdJo=; b=AqeVKIoH95oM2C
	MdR2w0D5oz5Zz1IXTbk7NZK2RgT+CB+DxprgghqFfW21n5Zx4qS5lNSlUzvAJQUdL5AS/WsxdcpFn
	lldZZbeod+7PG58ExkVaorR9eAOfx9VK1wQHwQrA0rigrtog4HA0We8G6dKQJ/qGhwk17uMSt+hK0
	w4xnWgx+VQ3tM5zgyN4gNk2gy3+jtEqwqkRLcAizPJ+v/MA3hjw117aEZS54b6bL7qzLFIuolNQaW
	kN9qwA51/L33I8tWmMeNfJw6Sl4aUUzJUjL0EEO255aqnh7EJMqAF+5OSox4m4eZgQUSvF6sjPzCR
	TyNw6aws/mPD/3ghcasA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAl0-0005Fo-8a; Mon, 11 Feb 2019 12:32:18 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfR-0007T1-Bl
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:26:50 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so4475099wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gQeA7phzsYQZFK2JLuLMFYmsphbl1nQUs0emAC/KfyA=;
 b=f6BueJ6BOK9oLFyCBYPbIADru/jrnmkBirHhnVRLs0l0/5Bw+1U5U/CWOHGQb5EnnB
 9BmjbUFDCu+lweCgRlp4R97RAiODEjMxcwFINz419QntkA4Fc2O7uJ6eZ/HQ9iOi09L3
 5PTQR7GPzIRdqNGDlEY65cG/iYfeoWYIX79Kt5BycDG3IpMsg7bPQyyeCt6/jYDwJHCh
 HSH2WPf2929SIrhb5o+qXabEpWfP5IBP5gZQqMPTtTdzJ1cn0Fh6WBSYsQddSkbDM7ei
 5kxqs+flE+vDrLUUX7chPJ9cPiBMSDcvYPcLXFOMTIhfz5DR/3GK2NQUrNMFhUl1+Brb
 9zRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gQeA7phzsYQZFK2JLuLMFYmsphbl1nQUs0emAC/KfyA=;
 b=W/ZJIeNx6JPBLNAYJmfpFRyPRWWEUBKKE84BnNZ0+eiA5aK4wKeDazMHgLQL86AgkI
 KjhzYeytYYpVlG/0OvzXhV/eniebjPPeYhOT/VWph3FPe/lYGrFq+hyMVGdufIbgzsrh
 9HW7YSiyS5B5uEbcV1VAaeHfBX+3N4YceKpnG5+xZV4wNCMAItW2tVMh06v0F/EnPkVB
 zJLmL6ZdewkxufXeMmW7t50ErBlcyN+iRZ1bzLONm6GG4s18d2ybMkZGiRNADTNA+A+e
 msp3YpXDU84dXBPkpObS9p2p4tLEXpxx2vck6cswmQ4XnTjK1wrUmWKIfc5XoNI0w819
 q8zA==
X-Gm-Message-State: AHQUAuZXvIBIFDMnK0wfmTYv0kHKnxmRXBcjG563V/5MFelmlHMFMSSD
 9TgQPOfhLV8lToHswTgUwbC5xw==
X-Google-Smtp-Source: AHgI3IZZumDciarp2qItixE4HVmaqTz69o0EU+778s9wNX+6VfYKcFuRCgW6DwdGSZjup1gle7YQeA==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr5036119wrn.198.1549887992073; 
 Mon, 11 Feb 2019 04:26:32 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:31 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 15/33] ARM: davinci: aintc: use the new irqchip
 config structure in dm* SoCs
Date: Mon, 11 Feb 2019 13:25:48 +0100
Message-Id: <20190211122606.8662-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042634_022526_499298D2 
X-CRM114-Status: GOOD (  12.31  )
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
