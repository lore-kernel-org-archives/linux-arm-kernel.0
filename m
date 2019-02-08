Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA96C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3DFC2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mS2VjN+R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wZcv0UsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DFC2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n3onLKP+k8w2HfeRymMhsI5iTcNDE+5pBZVLoc0RxOM=; b=mS2VjN+Rt7wHvH
	IDYq9uhWtkuawqvb8eWQGgWoo3uHEBWPEaaSNETTMeP23onBZn2qTOoYNs/M46zKlU7vI5BbUhq+J
	pvIf7RhDmGW82gwGj4ZfQsqqXJH0u4WjAJepZI5lpyph7hxEKnMF0/LpCA9s66nBsqbwe3j4sTNOy
	bBkTLyWJi4Vac1x8iSybF4nJ7Wmysn1OSsig3bbh5t2Kca7zvt5fNJB57e6PWz3X/iql/0Z2VU52v
	kGMIsefQWCNhxaRg4wWLhsv7B0N0U5Ohux239ZbVdI6m+vo+48DCzKcrenyF10a2SGWn4P6MNmYd0
	q6ul+JZeju5/A7b+vnsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsA4S-00088C-Um; Fri, 08 Feb 2019 17:36:13 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3T-0006iV-BI
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:35:18 +0000
Received: by mail-wm1-x341.google.com with SMTP id g67so4269665wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N4ZvxsWPIQS6z2HA4tYsH8Z4d2SBAikrOTSiB8yQPNw=;
 b=wZcv0UsB7Av2h9SyLR6GJkCBeq6HoqIwJn6P5dTJXrt0Ntx/o8H3uHcRO4ruvI4Y1v
 kHDpo5Lgqw5Vk/Con5aCloB0jLbBoo+emxJ7bFWFa3kIq+kEsd+JhAyDSGrv/ISMLv/o
 6oW+2n0M6lt/9YG5J1A9vbRfukYfk/RgKdQ6QbBzGvg6spA7vWw6gX69QGZ4h5MYBQOq
 k2RtqFhVtMDtkuvsyk+92oCfu+3/eZ8yVYA06qo4qXmKmL+vBThVz/aCC/didwfZnIG+
 YikSfJPUem0yIsZNqVe6lNx7wQqe4gsw+9tDaNJRpTj75GW5uKoICXV76MtDESIad+Z2
 KJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N4ZvxsWPIQS6z2HA4tYsH8Z4d2SBAikrOTSiB8yQPNw=;
 b=BS+4MqkURcpZkL16MvrFHuiRDJKn9vT6uB/DW4u725+hSRbM5u8XwsQEqYEpiZ7Q57
 /4J57ISCQkylv0uXalT202txoqRWbc0T49utzBAUfNua3ZNayG6QM5gTq6wUL+RuZblQ
 gyNtcdzEubeN4YldF/KYXZrnhRZYjDxL6DdKA0OesE8zFMFYd+i9pLuFcasK36M2Jaui
 9F6qhkJ8vgH7ZRSu71YN2KTNix3iCeo0bqwZGSvywuTkKkrHqXlsvH8LUyxtbGwyTFYj
 DSN8CoJ/a4PdQP+vRxwDuGKihbbcUhxMZfBVO9Uy2RBMYyZJEVRdB/y7X1RODHmtH2vQ
 3Ugw==
X-Gm-Message-State: AHQUAuZkuB11zfgEUdD1kOyyNaG05HMy8utXddqRGYe+kNWK1Wp0165p
 MCdhWA8NpwN3Y+VuyZdDjd2M1w==
X-Google-Smtp-Source: AHgI3IZt0VxBYSuA568n5DKuuWQ9FXgFtAqmdWdZJrb2cUZajBgtlDgZ+lTbyHngCsmSP5y/rjmTYA==
X-Received: by 2002:adf:c7cc:: with SMTP id y12mr17989268wrg.52.1549647310023; 
 Fri, 08 Feb 2019 09:35:10 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:09 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 04/33] ARM: davinci: remove davinci_intc_type
Date: Fri,  8 Feb 2019 18:34:29 +0100
Message-Id: <20190208173458.4801-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_093511_879749_12D4DA36 
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now use the generic ARM irq handler on davinci. There are no more
users that check davinci_intc_type. Remove the variable and all its
references.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/common.c              | 1 -
 arch/arm/mach-davinci/cp_intc.c             | 1 -
 arch/arm/mach-davinci/da830.c               | 1 -
 arch/arm/mach-davinci/da850.c               | 1 -
 arch/arm/mach-davinci/dm355.c               | 1 -
 arch/arm/mach-davinci/dm365.c               | 1 -
 arch/arm/mach-davinci/dm644x.c              | 1 -
 arch/arm/mach-davinci/dm646x.c              | 1 -
 arch/arm/mach-davinci/include/mach/common.h | 2 --
 arch/arm/mach-davinci/include/mach/irqs.h   | 3 ---
 arch/arm/mach-davinci/irq.c                 | 1 -
 11 files changed, 14 deletions(-)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index e1d0f0d841ff..a87e158a709b 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -24,7 +24,6 @@ struct davinci_soc_info davinci_soc_info;
 EXPORT_SYMBOL(davinci_soc_info);
 
 void __iomem *davinci_intc_base;
-int davinci_intc_type;
 
 void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context)
 {
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 4a372add8cf9..19874f5ef542 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -146,7 +146,6 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
 	unsigned num_reg	= BITS_TO_LONGS(num_irq);
 	int i, irq_base;
 
-	davinci_intc_type = DAVINCI_INTC_TYPE_CP_INTC;
 	if (node) {
 		davinci_intc_base = of_iomap(node, 0);
 		if (of_property_read_u32(node, "ti,intc-size", &num_irq))
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 2cc9fe4c3a91..9e18b245266b 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -807,7 +807,6 @@ static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.pinmux_pins		= da830_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da830_pins),
 	.intc_base		= DA8XX_CP_INTC_BASE,
-	.intc_type		= DAVINCI_INTC_TYPE_CP_INTC,
 	.intc_irq_prios		= da830_default_priorities,
 	.intc_irq_num		= DA830_N_CP_INTC_IRQ,
 	.timer_info		= &da830_timer_info,
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index e7b78df2bfef..e823b89e2b7a 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -739,7 +739,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.pinmux_pins		= da850_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da850_pins),
 	.intc_base		= DA8XX_CP_INTC_BASE,
-	.intc_type		= DAVINCI_INTC_TYPE_CP_INTC,
 	.intc_irq_prios		= da850_default_priorities,
 	.intc_irq_num		= DA850_N_CP_INTC_IRQ,
 	.timer_info		= &da850_timer_info,
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 4c6e0bef4509..03ce5df28d87 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -705,7 +705,6 @@ static const struct davinci_soc_info davinci_soc_info_dm355 = {
 	.pinmux_pins		= dm355_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm355_pins),
 	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_type		= DAVINCI_INTC_TYPE_AINTC,
 	.intc_irq_prios		= dm355_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm355_timer_info,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 01fb2b0c82de..3e034f0478d2 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -722,7 +722,6 @@ static const struct davinci_soc_info davinci_soc_info_dm365 = {
 	.pinmux_pins		= dm365_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm365_pins),
 	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_type		= DAVINCI_INTC_TYPE_AINTC,
 	.intc_irq_prios		= dm365_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm365_timer_info,
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 38f92b7d413e..66bab4782c62 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -646,7 +646,6 @@ static const struct davinci_soc_info davinci_soc_info_dm644x = {
 	.pinmux_pins		= dm644x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm644x_pins),
 	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_type		= DAVINCI_INTC_TYPE_AINTC,
 	.intc_irq_prios 	= dm644x_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm644x_timer_info,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 7dc54b2a610f..45efa715a2c1 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -586,7 +586,6 @@ static const struct davinci_soc_info davinci_soc_info_dm646x = {
 	.pinmux_pins		= dm646x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm646x_pins),
 	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_type		= DAVINCI_INTC_TYPE_AINTC,
 	.intc_irq_prios		= dm646x_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm646x_timer_info,
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 944afd57ee38..34e48de92dcc 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -21,7 +21,6 @@ void davinci_timer_init(struct clk *clk);
 
 extern void davinci_irq_init(void);
 extern void __iomem *davinci_intc_base;
-extern int davinci_intc_type;
 
 struct davinci_timer_instance {
 	u32		base;
@@ -58,7 +57,6 @@ struct davinci_soc_info {
 	const struct mux_config		*pinmux_pins;
 	unsigned long			pinmux_pins_num;
 	u32				intc_base;
-	int				intc_type;
 	u8				*intc_irq_prios;
 	unsigned long			intc_irq_num;
 	struct davinci_timer_info	*timer_info;
diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-davinci/include/mach/irqs.h
index edb2ca62321a..03c446635301 100644
--- a/arch/arm/mach-davinci/include/mach/irqs.h
+++ b/arch/arm/mach-davinci/include/mach/irqs.h
@@ -30,9 +30,6 @@
 /* Base address */
 #define DAVINCI_ARM_INTC_BASE 0x01C48000
 
-#define DAVINCI_INTC_TYPE_AINTC		0
-#define DAVINCI_INTC_TYPE_CP_INTC	1
-
 /* Interrupt lines */
 #define IRQ_VDINT0       0
 #define IRQ_VDINT1       1
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 3ce821a06e52..2494d9b36966 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -99,7 +99,6 @@ void __init davinci_irq_init(void)
 	const u8 *davinci_def_priorities = davinci_soc_info.intc_irq_prios;
 	int rv, irq_base;
 
-	davinci_intc_type = DAVINCI_INTC_TYPE_AINTC;
 	davinci_intc_base = ioremap(davinci_soc_info.intc_base, SZ_4K);
 	if (WARN_ON(!davinci_intc_base))
 		return;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
