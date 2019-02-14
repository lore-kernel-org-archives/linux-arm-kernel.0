Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E932BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:57:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79DC222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TygpWwDo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jTAXyTPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79DC222C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OGCrbOSYJbN17+JiNRarATcO0pjOl6CQ1SzariXrFtM=; b=TygpWwDoz7sc1p
	fOlMbN3m9CqqwaEEporNibvO8Lf1UhSo8tfns6XMpfCD9nlz94SukPaxRBfq5I/n+cscy5qFyI8Fd
	Y4sFWdo6wE6ykkvOU2k6XhxIbP1ZYkGCASVK+waXEWDLNwlRAAo69iu0ZH9DkDxUk6us4p1ZO60kI
	Af56a+DuKZgRQgGklmatT+Gtukx1O3YkaU8jMbLfXPxuLwcNO+WNdR1f2k2OfVRvIIaLXDBYsOCG5
	b8gFA1MUbXAJA6xr/m+n4xsar/KlONLJ0Pm0gu7atJVYVgNlnK/Wgz/UVKTpbll3T90jyTTgIFOaF
	YCWTaZD02HoGjdrW3/ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIRu-0002lx-O8; Thu, 14 Feb 2019 14:57:14 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIO3-0005PV-Bz
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:40 +0000
Received: by mail-wr1-x444.google.com with SMTP id r2so6766636wrv.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OE+68BkD2Gvi09w8U3xAg2OuU34U9g+A9X06DXSG8XE=;
 b=jTAXyTPLTWqRzAtWn1anu+O6hZZ2wZzyOgCyW/hbQdl5Fh/Js5PA4Bl90yyqSRd6aw
 I6rM/rz4zLpk/r+vvkWumqm0p/9aD+wm44zty5cT8SGRurLl+oJq8Rii3YcGaALUnWeE
 gI1w03TYFz8z3OYWreBVwRWXXRBBz0E1Wk8IINsqIv0BtzmkGrv99TSx4i9F+BbcdZet
 M28ZN8zqqqCUqhfVqmTw4RZeki9ddO7XN8v5Emc6Ldn0GqbWDp471GlFkQ7Hr8kJWHw6
 ODcZLhUUuvcPU1kMRMrvE4J7p/DM3Pc9wTUgVralXVdzVAIuqC/ooI38uze2nbloO6mo
 O9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OE+68BkD2Gvi09w8U3xAg2OuU34U9g+A9X06DXSG8XE=;
 b=daf0ItnN3oykhKiMYgYlq4mqMnyttUJDUhrIRxKh0Mvzsd6r1RX8q2gvoCVB3IlHg0
 RSpkKCQ3E/RfyHdrWn9nz8UQ+CLFRlsYZkI3pyi4UX8ADtUiuYmIaygw//jtm/iFIwjU
 fn8ELEGGVNyw9Ba1qBoeJDMCpOOqWLzLaOEbl8PiTGHOUaPN5qaul6lR8r6Ev5BvY3UY
 SVyl4W06blbcj0JYGPdVE6lWfzx3Fa5/QJq+nqZhVSvEpw+kgtWjfeNlSzvX5O51GWS0
 G8VoWP+GmVRq80tlW1wwFoYEmKLbiAtaoLGhebUYQ8RorsgjO7pHhv8bIub9lAEc5JcH
 gDig==
X-Gm-Message-State: AHQUAuZms7/JzGIcpIUvFLUvzYwNZpFxIixbjZ8cf01feGHuJvUY2TxP
 CS+xsywILMrwFbQnseI6BQpZrg==
X-Google-Smtp-Source: AHgI3IbHAY2GwczLfThqqvZt9x46tlcD4f+vcadcSdLOv8SbxeW5ET9tG5negrKdNbd1b1KEZRCDLQ==
X-Received: by 2002:a5d:434c:: with SMTP id u12mr3249843wrr.14.1550155993849; 
 Thu, 14 Feb 2019 06:53:13 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:53:13 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 26/37] ARM: davinci: cp-intc: add the new config structures
 for da8xx SoCs
Date: Thu, 14 Feb 2019 15:52:20 +0100
Message-Id: <20190214145231.8750-27-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_065315_702865_E5EE623D 
X-CRM114-Status: GOOD (  12.53  )
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

Add the new-style config structures for da8xx SoCs. They will be used
once we make the cp-intc driver stop using davinci_soc_info.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da830.c | 10 ++++++++++
 arch/arm/mach-davinci/da850.c | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 5cfd30c57429..38af72be1a85 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -12,6 +12,7 @@
 #include <linux/clk/davinci.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/platform_data/gpio-davinci.h>
 
 #include <asm/mach/map.h>
@@ -821,6 +822,15 @@ void __init da830_init(void)
 	WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module");
 }
 
+static const struct davinci_cp_intc_config da830_cp_intc_config = {
+	.reg = {
+		.start		= DA8XX_CP_INTC_BASE,
+		.end		= DA8XX_CP_INTC_BASE + SZ_8K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= DA830_N_CP_INTC_IRQ,
+};
+
 void __init da830_init_irq(void)
 {
 	cp_intc_init();
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 6df6994c0f26..9a3ce68c0de4 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -18,6 +18,7 @@
 #include <linux/cpufreq.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/mfd/da8xx-cfgchip.h>
 #include <linux/platform_data/clk-da8xx-cfgchip.h>
 #include <linux/platform_data/clk-davinci-pll.h>
@@ -759,6 +760,15 @@ void __init da850_init(void)
 	WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module");
 }
 
+static const struct davinci_cp_intc_config da850_cp_intc_config = {
+	.reg = {
+		.start		= DA8XX_CP_INTC_BASE,
+		.end		= DA8XX_CP_INTC_BASE + SZ_8K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= DA850_N_CP_INTC_IRQ,
+};
+
 void __init da850_init_irq(void)
 {
 	cp_intc_init();
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
