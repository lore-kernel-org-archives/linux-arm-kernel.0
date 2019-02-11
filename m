Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EEDC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:32:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3288520818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FiGY3+TQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HhVHzi8M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ChzDAc/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3288520818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OGCrbOSYJbN17+JiNRarATcO0pjOl6CQ1SzariXrFtM=; b=FiGY3+TQxsfLS0
	3ZwLhyY2fNCC8s9VNexijSsulr5HCLQtDeGwHqASnsONwAIRwtfd1ctRAL0Xw2ium6KfDOKicVmm9
	/M6mQumWG/GtAcUGBeiEHu+aLelj3X7NzIT4/ZEmBGvCcv1KWLJVJZUAvIO2iAuOY8cOSQzwodZn6
	T34bNwj40w0745wILXn9SIR4ZClL3gPitMPJZL5G5T79zPrNEecfs724GCjWs2wym7XRpvJfM2DIO
	Qvs54NUagXGCQuy2bGsVmRL1gqcUZrQp4+zlxXspNYNUea/oJg9+GFi5PH8JvRthp57Pl0I3z+6th
	Jtq1pZx9FwsiNo/x49Yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAlE-0005SO-Qk; Mon, 11 Feb 2019 12:32:32 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfi-0007ll-7Q
 for linux-arm-kernel@bombadil.infradead.org; Mon, 11 Feb 2019 12:26:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OE+68BkD2Gvi09w8U3xAg2OuU34U9g+A9X06DXSG8XE=; b=HhVHzi8MpcMHxg9hBT30l4Eo0+
 0M0ZnP80LT9ow1up/pn7PsBfhxYdhymsh25SUR+TO4VL42t4sY2kdprUDZzZmi+iVA4I7Lt/y5lbX
 sJECepzSo5X60SvAlF3WJK5TVaNa27wsoGL5m9bNI2a1V+lHa3YCT4JM5yBp0PzDwd87NeRurCtwF
 mh7jup/lgbdMFcWEXAu9UeRLClW3erhHXOG+Y+CjBlM4aaiUzI8vx5YZ1Umc2RULc+dYF3ZyK20N2
 rgYrkNwBFIVP/rIBbiQAIuyjoF1hxPJARMZM2tCuf4Xune9EHDR8YZ8LTBN02ojr9FeyzaOIIe0Bk
 fQgbmfbw==;
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAff-0008SY-At
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:26:48 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so4496156wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OE+68BkD2Gvi09w8U3xAg2OuU34U9g+A9X06DXSG8XE=;
 b=ChzDAc/nPzQ1itzXH8bi+m2nz+pQr+ANDOkVbdJzNc7verHaAZiMnVY1ACJSn9B+EB
 0eG1sXID3RmweoMqRSaA6WetZJGgdQCspz5gUmaA0NrrQZgS8KhV8r5fE2LkjyzL/E1A
 u1JQqwYVKRdctP1tUETQuGaaHbDKFKR06Wji/NFUhpvKB5hBClhtQx13udz2nfL5QN6F
 i/a8Ua+1BDAJyHV0I9EKJsNovC9NC23iQw1/rLE/bTgRDRcVqLR58YOm/MeTyy9Co+Ia
 RCx+LKzzgRVtVyhRFwMwqXXediW4BCRsP3jeO9TKdkbzIhXZKdohjY6oc2+gQvrZb8DL
 jg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OE+68BkD2Gvi09w8U3xAg2OuU34U9g+A9X06DXSG8XE=;
 b=Ja5H+GCi0AYlG5cp5C2J/MmnbqeIXLGXec+W1ehvTPYcSie+yOUqEZ+a16zKcLsFza
 ux2iVxQ7rjMkuwj/ip/95E9ziyu7rqEDQzHnJBmVf43L5QqhJh0uSMkuF+122+WbbpA1
 ALOmM9L/gAjeudBeaPn4bSEFhe8uIV6PUJ+Ijqmfoo51oKW1wy2mbyhBnCJjLvjMBxWB
 FEglTt5447vpa9wUb9DQC3VFsyGYGvD3tEHGv2spMR/MqzRrooyyxzqCJnIoKdZODeIW
 Fsf0Cy/I2hAWgSgFk2n42wg7t+qIQ3IE9Vp/qwlLUSZicJgn6YqXmgpV+BD+T2eP9Zpw
 v64g==
X-Gm-Message-State: AHQUAuYhRiGxj6OvtyHPfXeHMc6BTs82ec9TIqxveBciZ45n4WZo72Bo
 pzgNbsYt3SYkBbrXhPD5XSKyaw==
X-Google-Smtp-Source: AHgI3IYhvsmFc5p/2tuDLQwk9Olw42LLTml9psi0oQ82E7mg48NLA9SQ+agB+U+msqGAabTiH8HDkA==
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr28496782wrw.304.1549888001474; 
 Mon, 11 Feb 2019 04:26:41 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:40 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 23/33] ARM: davinci: cp-intc: add the new config
 structures for da8xx SoCs
Date: Mon, 11 Feb 2019 13:25:56 +0100
Message-Id: <20190211122606.8662-24-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_072647_394431_DB01390B 
X-CRM114-Status: GOOD (  14.28  )
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
