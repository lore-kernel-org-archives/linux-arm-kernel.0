Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4E6C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED9F218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N8w8VWs9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="E38t3rXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED9F218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dlVy79ZTMTxu0ago2wq0d7hbzHR1olayCFPDCOJ2zXM=; b=N8w8VWs9lI8ucy
	FbDI8h4um/3TM3DAk5uaSvy0BSiH0I4sln1K3/C2aqGu3QNQm8ZrEwwWWuoMUNcqB2tEMdPnjCUoy
	4e8J9VS5R6wwkubVQZIWsGicP8YPUJRrS+rQQjuYH1SCY65L9bgnsSR7F0YHY1ylQ3NNuWuNjB2He
	CvYloChl8mncIhXzS5rb49qBDnRbqCWgFV65D3krNOTVP/Lu8X8N1oz2tOtpHTHZsYTr8Yq13Xl6v
	XwF+3BZwTR3l6LeTBKN6BA2sROdOaKEJXYGxafA4j0GZFnvlPt+ARJyjF4jH1bIIeJDmQmxrabsTx
	xB2RE9/QIYGCag3+OVeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCaW-0006oR-Eu; Thu, 31 Jan 2019 13:41:04 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZH-0004Wv-82
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:39:58 +0000
Received: by mail-wm1-x341.google.com with SMTP id t200so2634209wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MTJcyASTfjESmwjpiKMY5IRrOr8j9890nwSQZijPI4M=;
 b=E38t3rXwqEYMCfiMuuw4AUZYZJVU+suUix6WOB/ONx+b47GSAOyocC75dTAg/3A2cL
 3RP5VeKWo9jC1V9iSHYJ/o/iJGG12UPN2pwbLoMS5Fh6jn9C3GjlZ1qT4LFAC0fi9y8a
 Aodz8VO9wmktqlSn02PrssdPMBnu/0CBSMJBYTSsAYmiPLuNDu2Z7+xJ0VCLX0UAiItu
 U3BIwbI4F+U0N0IREVn4+6j9slvFSSASHIr4WWH8mzapctrI2G+Ck2a4s3iv63F+9m5I
 PPoxncBJhf9pWE3nPKMXyQinrOpzcLv6LzVUf9p6cOyDP+12Niuwj4gcNJT2Owr6K9o0
 uYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MTJcyASTfjESmwjpiKMY5IRrOr8j9890nwSQZijPI4M=;
 b=hBpNDdadIBz0WQJMg8HK+ganYtZP/fX3QXBZLPHyBdla+yMrDwpnDZpTmSjYiV9q53
 DpYrwRqDmHYPDWhjo6nwPD5pHsX3TCc4GW/psu+zzNgTlFLn+BzcH2m+EAaHJZ06UuQ1
 lrtyQPtbyeROkskIL7JIMkyKe2YjxpdvuAlh8zR1JiIN2YBenaTx3ZxfDb/5Ynoa+smZ
 HZLuX3VGRNVtf8sA973F5pgs0K1baK7e2w4WR8sgaGRIuMbaOxXtvyc/woTbojIPcz00
 plmlME5xgclwBxQK1HEOaSwpIkISDnyTTjLPweKgFPsa1GgQAZJNiFHatnGu+sMXw2C3
 3OSg==
X-Gm-Message-State: AJcUukc8s/eDmGQASHEq3T6zL+EtxWVoLQUKI1FROLm24QLGa3gWM9LP
 uvUUuWHRKm7YwlyNQEYTfdxbQA==
X-Google-Smtp-Source: ALg8bN7v7ty/JFXRjSxxNNQVfvMj+rMkRFQJGHxWOmUDB8RyJBZPHgbMPaYEr9XCOBTVASd3TPaRqg==
X-Received: by 2002:a1c:7c07:: with SMTP id x7mr29821411wmc.82.1548941985516; 
 Thu, 31 Jan 2019 05:39:45 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:39:44 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 04/35] ARM: davinci: pull davinci_intc_base into the
 respective intc drivers
Date: Thu, 31 Jan 2019 14:38:57 +0100
Message-Id: <20190131133928.17985-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_053947_570223_21E099C3 
X-CRM114-Status: GOOD (  11.89  )
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

This variable is defined globally in common.c. Define separate local
variables for the aintc and cp-intc drivers and remove the global one.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/common.c              | 2 --
 arch/arm/mach-davinci/cp_intc.c             | 2 ++
 arch/arm/mach-davinci/include/mach/common.h | 1 -
 arch/arm/mach-davinci/irq.c                 | 2 ++
 4 files changed, 4 insertions(+), 3 deletions(-)

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
index fef39d5988d9..384b72fbefca 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -23,6 +23,8 @@
 #include <mach/common.h>
 #include "cp_intc.h"
 
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
index 3658235c8ee7..e539bc65d4ef 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -42,6 +42,8 @@
 #define IRQ_INTPRI0_REG_OFFSET	0x0030
 #define IRQ_INTPRI7_REG_OFFSET	0x004C
 
+static void __iomem *davinci_intc_base;
+
 static inline void davinci_irq_writel(unsigned long value, int offset)
 {
 	__raw_writel(value, davinci_intc_base + offset);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
