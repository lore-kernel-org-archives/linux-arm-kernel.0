Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32631C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:40:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F7E20449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r+/8qAnb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Str2ioU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F7E20449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=StwZhrwo2ZHzgbwoAk+VJjC4cyi2VwczPU2nR+1pQrs=; b=r+/8qAnby2xkLH
	/ljEEkqmYn+mI2w5wTyQBKRgqbkCYyo/xqxe7Ahb1wwR1EDpOTPuyfgg2PbQhOn9OELqY5JXbjkzU
	RjzVh7JeqBPdQWMJnzr7fDThHaiKgPHiUR6FSt9F317cH73PSEMUKUwEyxHOZ3s6G8yhlsz9rfQ1y
	rAynXeD7h2kIvyQnMVgnHJSw3+jdS/Bg9Vc5bQGJx0cRbNeZMIYnn4KBj6K0s+yXxj2E3zqjWq9UA
	v7nWEF/njNVBemUTc6KwBiC3sTI+2/sWanznrEGdLAMGT466Gjbqb/JiO3kmeNpGHB/pcKoQKu5+u
	cpkVhRl1rE4zccUOwPGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVUI-0008OH-K9; Tue, 12 Feb 2019 10:40:26 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVSz-0005u0-1l
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:08 +0000
Received: by mail-wm1-x341.google.com with SMTP id d15so2358938wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q5BrIZFNHo3k9uJAXBkzQcisHzLVezn4k1LAhO6mPdU=;
 b=Str2ioU3Zh9gjsHXjAh2cJusyAD5gNbOVzB/6DpqGjC8/sifLVx0LYSHkpMQcXetxS
 IzPC7xOawxM+gOfGMncjGW9A5tBNz/gKFg8PBjuLm515yTuNu14WT5zRkW2Le38aRHYb
 VDeLKCE7upuKYcBxLWteauoKft6Q7DcF8gokPXCZlRutffnZTSLNCIPIt6kw7ZbQmJdE
 x7oLft2qhARq21y1G30+1o+KN0b3V7Gw9WBxSymC4AjGAxOuBLWyo3YPYeBZqbH/sut8
 FTyJjLjI4S2vHluIz7wMUQEMqcKJd2St52y3hYN16jXxxNpkwe4WJF2kMVIcMmwZlWQP
 yc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q5BrIZFNHo3k9uJAXBkzQcisHzLVezn4k1LAhO6mPdU=;
 b=t+lIPb9b98tP3niouijcirGOJGma6HkOPOzlu4zxv6/fwmEj8gFxe+VGgS/rAW1sly
 tj8Z9PYWI6mMkJjXUtnWQ35HoC6ENePlMH4M1u8iZ4SBP6IKaFQ3FdRAvzuOVQcY94j1
 kKFMqj2vhZITF0MtPX+r9Cq080WrFOmNYRv/Cz5AtEDzlSmKJnW8ObPtrJDnIfB8NsUu
 6sDbZjUP/EnjgdEH+lkNGgP1y4/Ef2WDY0nrwHVShRNwaKwaxp7IVXmP9C5zRTmA3nij
 BRc/Yi5CJ0FwMayKU+tKyzZIfy6++PmLT5aIcN9tbW5oc8O9+oKCyR8n4PU7KBqiYEyc
 bGBg==
X-Gm-Message-State: AHQUAuYkkNxBfy2z5zjE/AAakiz8XjBZFI1RB/EXVuDkvXtbAwP8XYWK
 iLmboSpy87Tsq/yswWP/VJqSug==
X-Google-Smtp-Source: AHgI3Ibbbh/j49LejheZMR9ph96wZJUoYnBGVuhNa6CghozVfo8qNDRo/ykEXqF73l0qeHFSvMXczg==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr2237744wmb.136.1549967943292; 
 Tue, 12 Feb 2019 02:39:03 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:02 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 06/37] ARM: davinci: pull davinci_intc_base into the
 respective intc drivers
Date: Tue, 12 Feb 2019 11:38:04 +0100
Message-Id: <20190212103835.7768-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023905_290242_02C5DA24 
X-CRM114-Status: GOOD (  13.46  )
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

davinci_intc_base is defined globally in common.c. Define separate
local variables for the aintc and cp-intc drivers and remove the
global one.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/common.c              | 2 --
 arch/arm/mach-davinci/cp_intc.c             | 2 ++
 arch/arm/mach-davinci/include/mach/common.h | 1 -
 arch/arm/mach-davinci/irq.c                 | 1 +
 4 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index a87e158a709b..2850ae02aaa4 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -23,8 +23,6 @@
 struct davinci_soc_info davinci_soc_info;
 EXPORT_SYMBOL(davinci_soc_info);
 
-void __iomem *davinci_intc_base;
-
 void davinci_get_mac_addr(struct nvmem_device *nvmem, void *context)
 {
 	char *mac_addr = davinci_soc_info.emac_pdata->mac_addr;
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 19874f5ef542..4e293cde20fb 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -26,6 +26,8 @@
 #define DAVINCI_CP_INTC_PRI_INDX_MASK		GENMASK(9, 0)
 #define DAVINCI_CP_INTC_GPIR_NONE		BIT(31)
 
+static void __iomem *davinci_intc_base;
+
 static inline unsigned int cp_intc_read(unsigned offset)
 {
 	return __raw_readl(davinci_intc_base + offset);
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 34e48de92dcc..3d45b73b9a64 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -20,7 +20,6 @@
 void davinci_timer_init(struct clk *clk);
 
 extern void davinci_irq_init(void);
-extern void __iomem *davinci_intc_base;
 
 struct davinci_timer_instance {
 	u32		base;
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 2e3426ebfd97..b27b90dc269c 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -43,6 +43,7 @@
 #define IRQ_INTPRI0_REG_OFFSET	0x0030
 #define IRQ_INTPRI7_REG_OFFSET	0x004C
 
+static void __iomem *davinci_intc_base;
 static struct irq_domain *davinci_irq_domain;
 
 static inline void davinci_irq_writel(unsigned long value, int offset)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
