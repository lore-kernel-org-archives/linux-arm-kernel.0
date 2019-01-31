Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1664C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:59:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52C0218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EDIYrdVI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZvTF2X/M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xq8rAAuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52C0218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=93pCb8fcPhz5n7aslB5nxBBWs6qEevfD5WbV+M9i/sI=; b=EDIYrdVI8p75/J
	SfGAwg9bIxkqgzUl/G75yU++ht5Ux/K/lqt5kYErezxX1s1pPZQ0KQ7/TG366KrpPnvGLFcRtPqes
	uHiZycDYbehtKQ/5E+5XIhenQzwRbx9eJFkPeA/Y1DHFRc3RZSx8eZpGJJ7oTcF7kcGrfwbkb6xnd
	WtWIb3IvOR9lxYefKzuaHFKwznWZ/MAiP6MSjXp9BVZkDE3LgB6CAQUJLsXgxOqaQBto1O4xdt/mf
	RCOllS+fXMFf/b/KIt50iqYIeC8GKuLnaHz6uB88GF34qCGzBLrixzNXO0joGAUvuOhn/KlFejCMZ
	mtq8JtWoxr5J91ayajgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCsR-0003Zv-Hi; Thu, 31 Jan 2019 13:59:35 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCqv-0002L9-Fn
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 13:58:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EZWE16C9ZjEItVcQFpDaRLfJ9IzuvKc+mM7HSbjjb18=; b=ZvTF2X/MDbPdrEvpTox/z8uWnx
 JIMcpcfnwKNw1cXENkzN//QYpPeMBYNHc/5m9EBb+GqsCSRHMRZt6jyIxW051UKO/AFjWF2d0YmyJ
 pqn/eUb6STiLntH071sBAYbdRjhOS9eSKctU/4wKjKOr2kYdA+oWe5X505JcTcTYoW3EOQXB2laSs
 Rskg44H/ACHJGo/fICA8WBjvQ/PS7K+0D+ifh8KMcLSF4KLGEi7zluc0KwiJfxH2kuWuTdnGxQ0XY
 rLP56dHcbEA/YVih5Ke21PP1eAqjcyP00igWe3Ncd5dTUxTa3pMDsJwvPpcKfLsnM5qE3T2fzL771
 hxx4Hz5A==;
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZe-000674-KD
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:11 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so3330425wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EZWE16C9ZjEItVcQFpDaRLfJ9IzuvKc+mM7HSbjjb18=;
 b=xq8rAAuP7npyHn8R0kNkdMt3Sf4drHt66DxX5WT2pL1S4Txtdf87yJF2EfZ/0Xt9BK
 SNpfOKS/8Y40aQGDMLDIALGZteFlmc9CZTMpAGXVNE6NXMxcKmYw0UqCP5jRlIrLW+HU
 X6XT61MjiTEEL7cn41ZBoX9DkIkz5rZtfg4uGDHbDb0SkBZiLExNaJcJqlC7GXjxHf7L
 +BS57iw5LkAurIsFklr0D+S6tg0BtToJTbz79TZbz3jOxVtd2IlzYWS4CKZhZ6UEnWAa
 UxhGsUVXorlWYYfMW7cYgVRjdqncNtGYH7ZRpN1BW+l8nDcqZXbGEO3+kdqSQU4kVxjq
 8mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EZWE16C9ZjEItVcQFpDaRLfJ9IzuvKc+mM7HSbjjb18=;
 b=Q5a0VjxS0Di/PBjdQBytUouTncdRYdOkU+hqod9oZrkXoc7gfqQRgjHgVTdutI49FQ
 Hdvzbh4qIapWeZhpMsE4fzH8XNy9j3/Rg8zKADLDuZ5B3EoC2WWeccZyZJSC7ZtVIJZv
 rKdQaneE+lEtLJAwSZT6LeAydIZ/a7i5LiNWc9xS/dn8mTKwde1GxzBqomVokizLdLth
 lblMWp6pfQrP8YCXOh+IoQXlIbpGYAUPqlb/DQAJqyE+3bVWD+ybM1XISEY58vUKSoO/
 qPrR5xb2CVxPYBwrQ3tY9ERIl+TZliSe+TvSIETgEsLp+h11SjxctNl+srlky5aX5P7z
 6edA==
X-Gm-Message-State: AJcUukcrJOIKWIETirDqOliwMrO51I/aZwpNWT2XX1tUm2Pze0vZsiWv
 hDtb2M8LTK7HgkyBCJw48ye7JDKM3AA=
X-Google-Smtp-Source: ALg8bN5MhaTExPvjAOqlg2O5V8JNQzbh0rpvhyT+zq3Mlbz7GzmMXRY90WRUTk/pmZG0TppB36mKsg==
X-Received: by 2002:adf:d4c9:: with SMTP id w9mr34463680wrk.119.1548942003051; 
 Thu, 31 Jan 2019 05:40:03 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:40:02 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 18/35] irqchip: davinci-aintc: move the driver to
 drivers/irqchip
Date: Thu, 31 Jan 2019 14:39:11 +0100
Message-Id: <20190131133928.17985-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_084010_674445_EE6DC70D 
X-CRM114-Status: GOOD (  13.71  )
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

The aintc driver has now been cleaned up. Move it to drivers/irqchip
where it belongs. There's no device-tree support for any dm* board so
there's no IRQCHIP_OF_DECLARE() - there's only the exported init
function called from machine code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/Kconfig                         | 11 ++++-------
 arch/arm/mach-davinci/Makefile                        |  1 -
 drivers/irqchip/Kconfig                               |  5 +++++
 drivers/irqchip/Makefile                              |  1 +
 .../irq.c => drivers/irqchip/irq-davinci-aintc.c      |  0
 5 files changed, 10 insertions(+), 8 deletions(-)
 rename arch/arm/mach-davinci/irq.c => drivers/irqchip/irq-davinci-aintc.c (100%)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index da8a039d65f9..71a4d875dd39 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -1,9 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 if ARCH_DAVINCI
 
-config AINTC
-	bool
-
 config CP_INTC
 	bool
 	select IRQ_DOMAIN
@@ -17,17 +14,17 @@ comment "DaVinci Core Type"
 
 config ARCH_DAVINCI_DM644x
 	bool "DaVinci 644x based system"
-	select AINTC
+	select DAVINCI_AINTC
 	select ARCH_DAVINCI_DMx
 
 config ARCH_DAVINCI_DM355
 	bool "DaVinci 355 based system"
-	select AINTC
+	select DAVINCI_AINTC
 	select ARCH_DAVINCI_DMx
 
 config ARCH_DAVINCI_DM646x
 	bool "DaVinci 646x based system"
-	select AINTC
+	select DAVINCI_AINTC
 	select ARCH_DAVINCI_DMx
 
 config ARCH_DAVINCI_DA830
@@ -49,7 +46,7 @@ config ARCH_DAVINCI_DA8XX
 
 config ARCH_DAVINCI_DM365
 	bool "DaVinci 365 based system"
-	select AINTC
+	select DAVINCI_AINTC
 	select ARCH_DAVINCI_DMx
 
 comment "DaVinci Board Type"
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 93d271b4d84b..983865a99616 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= dm365.o devices.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= da830.o devices-da8xx.o usb-da8xx.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= da850.o devices-da8xx.o usb-da8xx.o
 
-obj-$(CONFIG_AINTC)			+= irq.o
 obj-$(CONFIG_CP_INTC)			+= cp_intc.o
 
 # Board specific
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 3d1e60779078..ea0eb82bf1d2 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -129,6 +129,11 @@ config BRCMSTB_L2_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
+config DAVINCI_AINTC
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+
 config DW_APB_ICTL
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c93713d24b86..623e0ec5f9d0 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_ATH79)			+= irq-ath79-cpu.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
+obj-$(CONFIG_DAVINCI_AINTC)		+= irq-davinci-aintc.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
 obj-$(CONFIG_FARADAY_FTINTC010)		+= irq-ftintc010.o
 obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
diff --git a/arch/arm/mach-davinci/irq.c b/drivers/irqchip/irq-davinci-aintc.c
similarity index 100%
rename from arch/arm/mach-davinci/irq.c
rename to drivers/irqchip/irq-davinci-aintc.c
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
