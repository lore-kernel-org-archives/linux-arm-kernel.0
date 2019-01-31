Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68661C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:47:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E452085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HFeh25Jo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="U1+qrDL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E452085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M9OwwoPJ791Y8zvrn2FQyDo+gMNo/B49/9ptA8s6RUI=; b=HFeh25JoedHBwO
	8Ev4PsTejepvutx/Pje5CyltdudcsLRcG8+nPKbDiBopL+I+xKFu7cVe4Y4+xwuQ1rBgTf1Jwjhz+
	QyxYlQnLtAwVJyvt37nc6trNdnfLsGHWB0d8YwI4NP+udmzuRY8Iob5N4luW4Ak0ghoTSvYLGP/No
	jlFlC8MxJpEqJu6nI76aU0+3Oz0hd+8frrrIgkaF48EyQFlItgSPVkwAWV75erGE9Y7Vk1jF0rMFe
	liU7ZJUDC13SptMcxdXfxzasTdgL5BMnP8HAEjww4d1KWKOqnP2Itroq8nnJZbN0TWd4NQBkWrih3
	aQ+u2FxX+RnnDI8pmxnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCgN-0003wW-PO; Thu, 31 Jan 2019 13:47:07 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZo-0005vQ-Vn
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:31 +0000
Received: by mail-wr1-f65.google.com with SMTP id x10so3322603wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=We2WlkoJ1lTjORWt1TBXuNoYiOgoaziyvmKKctGjQOg=;
 b=U1+qrDL1hKiJD95zrgp5kctoBSKJnzQuxYzATy98FMDtxrBxDlEsIZIqpNSB3Yito8
 /D4waT9v8hZEJVT0WC9RjTc4VowuB1m8+sU0HRbvwcdB+gBZCB6lE/OymwsJhZ//u5Bl
 umdcnRW3cqr3EfVX4OZrpNvxFslPNEl2i0AFXtLiXuk3AizJIEXDVGY8i+haR5qJSBbx
 V190OHH8rKABE7AS2eHoLHhIlNpjJiEty2xfaVIhecPKSUK2Cpkiks82YNRDivm5lzw/
 zP9hyAEDHeGk1A+L7aO3HruX9kxpsveLQUdy4E5rLMZDo5+uMeLUHEzWXHyyQy9QhQ1H
 Mgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=We2WlkoJ1lTjORWt1TBXuNoYiOgoaziyvmKKctGjQOg=;
 b=iFHAPbNrU2wZReBbEXs93t5i/F3uCNmZPENwZ8nyQkKbF3ofw08Hb1zj++Lc2p5dlh
 YZuLHwQ4n1oN19glc8rkVBL0WyZ5vjR6w78fE1dYNd3opEBlPnl45I4w1ZlmBIxc/ALk
 LCUCDgxN390D+mZ6f/a4fglXWJFMzWUiflndpUk/Gd0w/48Rn6nU0o3iEWxD9eObLvkq
 eUVS2USTZqquPRvODqSDFPRjHcT9cshC2pRDOxyYzPFSTe+9wDC6BtyxbDuYZSLTz9D9
 ++EDpoUO/+dMTvRZxHK1qLiZMqHIbjYO42V1ZcHe4jkBhuZXAkfF/hLkh9GxHzc8okh8
 2o7A==
X-Gm-Message-State: AHQUAuahTdq4KBB2vRe0pAfomvjEpRhdR08tAnoVL6N9dABw0I2sJzVF
 74/NRITsRCik1+EwVr/yRZgrzg==
X-Google-Smtp-Source: AHgI3IaJaNxLdLCLlO5UsDg7/jCPCCJbBa5eq5GrkHIjm+VHASnM8QiRabB7OiyD6WPN8apUEF7Juw==
X-Received: by 2002:adf:8421:: with SMTP id 30mr178924wrf.153.1548942019070;
 Thu, 31 Jan 2019 05:40:19 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:40:18 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 32/35] ARM: davinci: remove intc related fields from
 davinci_soc_info
Date: Thu, 31 Jan 2019 14:39:25 +0100
Message-Id: <20190131133928.17985-33-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_054021_133897_5D29EEDE 
X-CRM114-Status: GOOD (  11.48  )
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

These are no longer used. Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da830.c               | 19 -------------------
 arch/arm/mach-davinci/da850.c               | 20 --------------------
 arch/arm/mach-davinci/dm355.c               |  3 ---
 arch/arm/mach-davinci/dm365.c               |  3 ---
 arch/arm/mach-davinci/dm644x.c              |  3 ---
 arch/arm/mach-davinci/dm646x.c              |  3 ---
 arch/arm/mach-davinci/include/mach/common.h |  3 ---
 7 files changed, 54 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index bdbd66ffd2ea..9cf9b090efeb 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -624,22 +624,6 @@ const short da830_eqep1_pins[] __initconst = {
 	-1
 };
 
-/* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
-static u8 da830_cp_intc_prios[] = {
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-};
-
 static struct map_desc da830_io_desc[] = {
 	{
 		.virtual	= IO_VIRT,
@@ -728,9 +712,6 @@ static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da830_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da830_pins),
-	.intc_base		= DA8XX_CP_INTC_BASE,
-	.intc_irq_prios		= da830_cp_intc_prios,
-	.intc_irq_num		= DA830_N_CP_INTC_IRQ,
 	.timer_info		= &da830_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 };
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index fe370e85aeb1..b9ebdcde68eb 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -299,23 +299,6 @@ const short da850_vpif_display_pins[] __initconst = {
 	-1
 };
 
-/* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
-static u8 da850_cp_intc_prios[] = {
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7, 7, 7, 7, 7,
-	7, 7, 7, 7,
-};
-
 static struct map_desc da850_io_desc[] = {
 	{
 		.virtual	= IO_VIRT,
@@ -651,9 +634,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da850_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da850_pins),
-	.intc_base		= DA8XX_CP_INTC_BASE,
-	.intc_irq_prios		= da850_cp_intc_prios,
-	.intc_irq_num		= DA850_N_CP_INTC_IRQ,
 	.timer_info		= &da850_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 	.sram_dma		= DA8XX_SHARED_RAM_BASE,
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index a0bfb3602136..5573f53b47f9 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -651,9 +651,6 @@ static const struct davinci_soc_info davinci_soc_info_dm355 = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm355_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm355_pins),
-	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_irq_prios		= dm355_aintc_prios,
-	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm355_timer_info,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index eab575873255..6d9bf292f4c6 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -666,9 +666,6 @@ static const struct davinci_soc_info davinci_soc_info_dm365 = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm365_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm365_pins),
-	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_irq_prios		= dm365_aintc_prios,
-	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm365_timer_info,
 	.emac_pdata		= &dm365_emac_pdata,
 	.sram_dma		= 0x00010000,
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index beb97101c881..2f181b4149c1 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -591,9 +591,6 @@ static const struct davinci_soc_info davinci_soc_info_dm644x = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm644x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm644x_pins),
-	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_irq_prios		= dm644x_aintc_prios,
-	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm644x_timer_info,
 	.emac_pdata		= &dm644x_emac_pdata,
 	.sram_dma		= 0x00008000,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 70505c92d5fb..4ce2c8c6b945 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -531,9 +531,6 @@ static const struct davinci_soc_info davinci_soc_info_dm646x = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm646x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm646x_pins),
-	.intc_base		= DAVINCI_ARM_INTC_BASE,
-	.intc_irq_prios		= dm646x_aintc_prios,
-	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm646x_timer_info,
 	.emac_pdata		= &dm646x_emac_pdata,
 	.sram_dma		= 0x10010000,
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 9e06974c85bb..2b986d32049f 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -53,9 +53,6 @@ struct davinci_soc_info {
 	u32				pinmux_base;
 	const struct mux_config		*pinmux_pins;
 	unsigned long			pinmux_pins_num;
-	u32				intc_base;
-	u8				*intc_irq_prios;
-	unsigned long			intc_irq_num;
 	struct davinci_timer_info	*timer_info;
 	int				gpio_type;
 	u32				gpio_base;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
