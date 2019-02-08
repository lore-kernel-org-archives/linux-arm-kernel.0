Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF75C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE9C218D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mc0mMRCO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MqZ0OHeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE9C218D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dBlqx6zfl4OrHFa9wH905Yd5FHHYlnVFQAmtZEYYo9A=; b=mc0mMRCOl0rRnT
	4gS0OhJcYvVWwZ8jN6Wj9THXf/84nzlWomiO3oEmddlzZ3xs15EngiJMQf/I7/iXw5Tib03CtBxcL
	V0wMfYOvZ0VtA31SRguPZVm71kN9wZkHX6biJqSp7lHQKNWsmaw8ioQhXy+/Srbfl1IY4fQWdigTK
	88ItHB6BuvPVyGdApEv+DND+3FKiA5s9/QcpZqQIuT4ZJw6H3OFoHP/QDMwFONEA3r8NS82Ia2Sq1
	rG+ALaIHDTEe1h34EcGBG+4yA11xJyMNt9MQFcIPwZ2qcVENbw7JehrAqqytqFXD//gUt4CwDZhCh
	U160+31cVEhoqH4Uy6eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsA4v-00005I-8C; Fri, 08 Feb 2019 17:36:41 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3U-0006pS-TM
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:35:23 +0000
Received: by mail-wm1-x344.google.com with SMTP id t200so4332411wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d84vosy0hzSE9kDbqRdSCRCT4mvEWw1x9RCjfQ9bpew=;
 b=MqZ0OHeQEmLHujZDVcJd3/KHMDFODs3nrF6nz+/Kk3D0dnkd3EFKelIhfUWHwgoSgA
 Aj25BFHUhgj6uCUcT1szz2M46+y04GukSx+6Qw45AMNPxW6Bra15QNlUshmxmPBQaWy7
 wEk34O8BhTmhTmB4JLqZ2ECR602ZuKt7r+bvry+gqdAlc8j1YuwdnX2fFjkMZ29pChLN
 tAeJfjT0BTM0Uq8r9QRndjR557d/Tias9PSY8RV7NC/ZiMBhxICLPy/6pIxqlheJtymu
 Cw1XCnh++GCmE+TtosNsdK2l4pwu1s/6/aHTE+Hu8DphX74JIPypsTZO1rqgNh0Kvlgv
 ZuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d84vosy0hzSE9kDbqRdSCRCT4mvEWw1x9RCjfQ9bpew=;
 b=n8ofV8KBlPf0QWiI4KP8LQjFZQLnB14XDiQwwqpUhyLuFIcLl7sHGUz8I0FBiWocZm
 boDOh1dcriNwNiel9lzwnWmZQWL0CmopOOEBcdZvUgeDXbSiZfBVOZg2nGAav3S/YnTE
 FER+SZr18J1MKU8LAbcLVtmPZNQOgpNfD9UGUXjTXNkAeaFwm6tX2LZVug59DnvNPQpF
 EIN40NMyxQS2dUghKVIxd65uJjxHK/NLBdXeTVhbORk7uRxoHz0BAIhO0ANuyxhsAyBh
 /b5nHd6FMffa4UzR5dWVO1ZRGO0uos5Q6pf375MCGgQFLh04F4FlbhR4ZKBWHE5nD6yz
 5HSg==
X-Gm-Message-State: AHQUAuYtGkSmB9vHpi6gtjxHi/gzG/aQ52D1OSMBLIz82lNbSwIH8E2u
 vXN31TA50ADUKQPLXaFP9ms2bA==
X-Google-Smtp-Source: AHgI3IZwFrE0FjkgL+F1KuER6uO308U2gwKoyhRHvgUGIdAzlsb3oMCimJrh7Ax/jaej38n++QWv4w==
X-Received: by 2002:a5d:4349:: with SMTP id u9mr18213780wrr.223.1549647311613; 
 Fri, 08 Feb 2019 09:35:11 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:10 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 05/33] ARM: davinci: pull davinci_intc_base into the
 respective intc drivers
Date: Fri,  8 Feb 2019 18:34:30 +0100
Message-Id: <20190208173458.4801-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_093513_431497_EAAF94B3 
X-CRM114-Status: GOOD (  13.43  )
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
index 2494d9b36966..19f17ef04381 100644
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
