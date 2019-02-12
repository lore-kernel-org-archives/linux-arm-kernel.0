Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A4AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:55:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6632083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qO60hb4Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pFms94Yn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hPGgxU2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6632083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=93pCb8fcPhz5n7aslB5nxBBWs6qEevfD5WbV+M9i/sI=; b=qO60hb4Y1IcdmI
	yXqtEcLGw5reKPcsS1/u2AX1W5SJSexjvZKZ2HKViBYFNgoMP2P4iCwdEqvBLPpwdk6XhaNU1aOzm
	pga1xY0ifSA4zdjBqKRd/VrAKn39EnZSP8H2mjqU91T02wlOPkRitaQltpitpAmnainUqMYDD/fSV
	7++XEuh/Zn4fDL5syqpuce45/VMWVzZHqTTGrqEBoGqdNB8jJUP0GlFP5Iy1YU5u7xVFhMRQ2vGpx
	KYB5Eqheh8NQOm/hJeumvT57SiGqOiVep+ckyDIFXL80PyYhmW4sxQ0Qs8DZXwXPN6zIV1orPJ2l3
	bcRvupKT8w7A2HiJ3Tww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVij-0003gb-Ta; Tue, 12 Feb 2019 10:55:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtViL-00029B-NC
 for linux-arm-kernel@bombadil.infradead.org; Tue, 12 Feb 2019 10:54:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EZWE16C9ZjEItVcQFpDaRLfJ9IzuvKc+mM7HSbjjb18=; b=pFms94YnOcnpswfJA3s5CfJQq7
 gtgobHlgYQi0KK7X+trqhawAVq7Puf3hYYmZ9Nth+tWxvD0x7ecboBBEvS4KfwZAyp2LhL71pRmrP
 yoKV87axbwPAgZrlifc/HMQLjyuuwWnGv8bvrHa8Eclpv5xSURs7jSKyuuoqfdEtLpvVoP2lNgRnp
 BVVGHhkJlfYUPV8XeStiHUY+YkV9C1Dot/d5yp35gbV4A3arqy7hyQYEyc+zYuLKXv4FElyedlk/a
 OwMSrwtpC2zSaLyX46c1BF7BX1UcAAgBWnNdhmJ58ubO/HixXtx5yRaFOVV2PMJVgyyqC3Q3tonDk
 qP4DvBdA==;
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTI-0003lG-2L
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:26 +0000
Received: by mail-wr1-x444.google.com with SMTP id x10so2069542wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EZWE16C9ZjEItVcQFpDaRLfJ9IzuvKc+mM7HSbjjb18=;
 b=hPGgxU2Js2SYyokYq9HKgTRwA47HaFl2Is22qWLxIZxMwAkfwRR1Y18AtQA2JAZ8oz
 gAGlDeBCOz+YHVydd0GP1UxC4f8jt15DAPv1cK14UnR0EogpLOWH5cEuYHuWZU+7ZRKI
 gvHnxaqlMv9H/qZaFI1QMCtwNR5Lpgd8JdMZ23x80jbW5AQ/hajLBByhVB/7S7IVzQu/
 Ek5cR+BgS4D3hbQoQVCTY3zNdA24jvHH7WXEhuFaqhxjuySTDSOuAqH+dpLVAaqjd6EB
 e4OyVTVRxB1l5fJitB6f0EdfL7y6L/xPnqTR/KLU+GG4y5GViFcSdwMgGCGd6nq4+E4/
 wbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EZWE16C9ZjEItVcQFpDaRLfJ9IzuvKc+mM7HSbjjb18=;
 b=tho1tARN5iWSfeYSdJhDpqdRNHN6TAB5RbnY1JrFBETuAICeJEv+JrwSEEkKlO4O6a
 VpaE5q3GTecJaE64S4Qzsh3lHSEdm+Yb7L8YgwhuSNawxqsc+bUyIjut2U8KpJ7XumPs
 QFmJCfn1LRzC/9RwhoIl6P+F40YgEvnfEmEXme2G18h/VBbi7q4yQ8D4epWFpONcJtO1
 Pt7LstKZ5EhqHK1bzPkv8ExOCkfakRU/njcklMvoVm9zA8lzyp+HMO/kvmivUHarUN9z
 Ic/GpoY3q6uDf/f+H+vZJxF0H0Gt5yM0856iBb25oN2/+zTlw8HpPvXMrsPJyqqAyeEz
 eosw==
X-Gm-Message-State: AHQUAuYEPvbMQIezFikUsgEszfEJamIMNNaeHekJZckN108VOL74UmsW
 3Kf2MwBOuXn2gCb/4+SyNdH6lA==
X-Google-Smtp-Source: AHgI3IbYM2rqm0YM3r7MLBUFL8qc1SjHfzy97ObZ/dGpWFsL0tgdenG0L/2Ejq2gdA4xcav0PD9Fcg==
X-Received: by 2002:adf:ee82:: with SMTP id b2mr2503527wro.185.1549967962650; 
 Tue, 12 Feb 2019 02:39:22 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:22 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 22/37] irqchip: davinci-aintc: move the driver to
 drivers/irqchip
Date: Tue, 12 Feb 2019 11:38:20 +0100
Message-Id: <20190212103835.7768-23-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_103924_201683_121C2223 
X-CRM114-Status: GOOD (  15.97  )
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
