Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07918C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB4372229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DLQp51qn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UIMRCs2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4372229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=StwZhrwo2ZHzgbwoAk+VJjC4cyi2VwczPU2nR+1pQrs=; b=DLQp51qnltNeuS
	Ye3InxWvXa1kxcnN0CCH3OqV7jnKiyZd+s9AhE1Mu2wDZzrPLoUbCixDdw59fmEgc+VheodxNatoq
	LFEk5R62kpfsX/A0EPqSvIdDjd6gG0+5FdI18Yw+cvRzRHeg2G+ZfGq+4si7u25U+/NcxmzVnGRyF
	1M0wVghqHryRyw2ekr6IRtB6lAV7sPnwL2cT/T5mH7CHgVw+a/DKf6u84jKufngVBOPzf6k4OS0nb
	tl31aBEhfwwJx2Ta99pHKh0kSG9mp9HiiL5CTQD/blHSYKZxXmoSkr1gegRSGpZ2EIwxEUEcQy0AG
	KoNhoOeRFj+2Ke1JmQsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIOU-00061G-Nl; Thu, 14 Feb 2019 14:53:42 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guINf-0004qz-8H
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:52:55 +0000
Received: by mail-wr1-x443.google.com with SMTP id w17so6751808wrn.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q5BrIZFNHo3k9uJAXBkzQcisHzLVezn4k1LAhO6mPdU=;
 b=UIMRCs2wrCW8fHpmWrbh8J2YNd4PN6gVHcAXkiPWvANvdFg0yw5kKUVm3XM/vONEa+
 6zpI3/5TRU6sCVpv/ihTO/bWllQYv7dszXPpzb9aSfye3NUe9qv4F7lkVaLZG+Z+nZPS
 F4zVNnUjgLaszlC84ZPoSBSGpVKtCEUTa+54LRig9iBNYsCduzLJ50z/E3Id8dwlZYtG
 jcc/FSRg20NKxuLS5v3tqM6vycTlRMZEVtCkzTKJcBrDRiHLhs8Do4MTCv5bniae32xF
 AuL7zH2ktLVk5tec6+U9qM8xES5Z6qFVNPeX0yQM1qhNYXcyuM+TWkdkaRiuGMGlvaC5
 wetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q5BrIZFNHo3k9uJAXBkzQcisHzLVezn4k1LAhO6mPdU=;
 b=SgeHVpjUUv3DT/Gnl1x0HMAWtJTvriHHuzDOY3vnGq94lF++syzhACCwWrSztkttwB
 dhl2a6iPnXMHTUZVa/hXwfC8QiQ57+KCr8RMzg7W1Tr3uF2AayVCR57n8gWt7MGs3zmt
 VT+4QN9eFc7lLw2OUU2tkgZnMc0Lt8OrmzwCQZh4SetpgPa9VegacR3k87LrU/nZoQzB
 eVL00ZZ0aT9n0OWrs/oC7EHejy3zbDadK2bYhD1rfDV0d68U/eA+jFw8qwnBjFVtRyXE
 lk1HGAA5sw11JQFxAald+uenVICxeExOaDnndthqyNIeTOPPAiLNOndJ4K4quQ4jMRi0
 zCZQ==
X-Gm-Message-State: AHQUAuaaqPwyFd80/CMOp18ErfdxSwmo1aNX8r2ik1g5yTQ3i23P+WUU
 nMUJqAvArc38rJKsE5n5zJBW+w==
X-Google-Smtp-Source: AHgI3IZLGLCe7po9IM8woAYyOn0/6rK3FUyEPly+FSXLQD+0m36qIDZML02akqI/VqRtLhpsiBmiqg==
X-Received: by 2002:a05:6000:1110:: with SMTP id
 z16mr3266178wrw.28.1550155969928; 
 Thu, 14 Feb 2019 06:52:49 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:52:49 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 06/37] ARM: davinci: pull davinci_intc_base into the
 respective intc drivers
Date: Thu, 14 Feb 2019 15:52:00 +0100
Message-Id: <20190214145231.8750-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_065252_432247_40C563B3 
X-CRM114-Status: GOOD (  12.75  )
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
