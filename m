Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D78C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E113621B68
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lRjh8fTA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UJh8c6BY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E113621B68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oW8LLkVyssgv6CZ6lJo/O/z6YDKkX2X0RhOUxDz6bsg=; b=lRjh8fTA6hLkBj
	vTClaZTgpNJPPgDTKqytAt8UZZ8SbFDxyEsKtYsLiUE9szBdO23wz8yApTvPtwdCj0KTYEThY6NDe
	XxWHb3t7vJDAajxzhEuHfO1UYZQhZ6E2UjfjC+ouKNgE7K67k4Az2Y/stJeQlLa9u414U8aLMQA69
	1UnSxChsX6W+IzCxOzbWM9uFtXX9rCmBn/JBDwH1hPpb76epG+oliu4i1DY+fMDNRAX/TOtPBqld+
	xw+kKS4VmtU31Xla+CYtig1TH0bRsuxCbZRmTPSEHDf6Ol1ey4FaTtUbSE8YA2H4Ee0FlBzqzZaUW
	iwLS7vD6rtHZ65OzQP6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAfi-0007lR-U4; Mon, 11 Feb 2019 12:26:50 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfB-0007CK-MI
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:26:19 +0000
Received: by mail-wm1-x342.google.com with SMTP id f16so17033774wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=trIQtIIzr10xL3xuZKgdBn1lKngoT5UlbTmlmF/bYWM=;
 b=UJh8c6BY0dh+zg3fyjX4z4AG+BCBRlHEMcGLyWpNNcFjVZ5v7bcHosXog7VsBecq/M
 s52bUQt06drTUYg+WR87ABYf1okWHv+Lape0Jl6CkapMpHEN87UD7qOhRCdexvF42VQS
 gO1K9Xs+K8HKb/pEYJNr1RNGTVnYcaqEmEN+B7+WKGRCCO31A6bGv2nZ+ack+USirZUH
 3tPXto+/hjdrm60xckVHxalRyhY+aIT2QW1HGqZ3J4K8SBthQvWpFFMgGKss+Z02Ft94
 funQsg5cFRhokPQkk0JL5ZZk/2wYh6xS5KYhDfjBK2VjSPmjy2duGGQ8ipgwSyHhGNt7
 Z87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=trIQtIIzr10xL3xuZKgdBn1lKngoT5UlbTmlmF/bYWM=;
 b=WxFeRFJ0Tu3Bp1R5KuHRM0lQPSLsYjnyrdaT/0JNTWq8MAr0VNm97KJJiy3C3Ziwq0
 JpvAURDiG3zuB8uSc71EoyO+ANPbzCA/9BPCvTJMTZP9fuQp+Z7R+SIo7tBrTjfEUBGx
 UGQ9nfkgwN0EkCdIini4aTyu8u9fxeSZh1I7aD5OOeYTI8XC77u9SnE5v/OMg8fVIf4Q
 WemurS8Xq8BGqTkBTv+TlBusj6XYk+VFydp1pGPRfoc3m009h8lol5Ikt4K7Omctbh/u
 05XGq4syn8RVkXBaeTx56/wz0dpiZvXOioG9ODHkXA8m2o2rX88xFL6FNbUKx/j6SDOG
 y1pQ==
X-Gm-Message-State: AHQUAuZwZrOBPyv65+Lfgu+jwQ74Xdd9Bc3hf45jbJV7zSRV26LfQ2XF
 6uAAl2wwV6Kdh2bn7HAzUXalzA==
X-Google-Smtp-Source: AHgI3IbEmzia0q3JCYR/8CsRl3bCJRBvTRU1gFNY5fIKTIZ24u43YUZmP+qXuiKuLuStNObZ4N9vxQ==
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr8888458wmh.30.1549887976219; 
 Mon, 11 Feb 2019 04:26:16 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:15 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 02/33] ARM: davinci: aintc: use irq domain
Date: Mon, 11 Feb 2019 13:25:35 +0100
Message-Id: <20190211122606.8662-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042617_724125_6C678F4B 
X-CRM114-Status: GOOD (  14.84  )
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

We need to create an irq domain if we want to select SPARSE_IRQ. The
cp-intc driver already supports it, but aintc doesn't. Use the helpers
provided by the generic irq chip abstraction.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 952dc126c390..07d8ef8037e4 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/irqdomain.h>
 
 #include <mach/hardware.h>
 #include <mach/cputype.h>
@@ -40,23 +41,23 @@
 #define IRQ_INTPRI0_REG_OFFSET	0x0030
 #define IRQ_INTPRI7_REG_OFFSET	0x004C
 
+static struct irq_domain *davinci_irq_domain;
+
 static inline void davinci_irq_writel(unsigned long value, int offset)
 {
 	__raw_writel(value, davinci_intc_base + offset);
 }
 
 static __init void
-davinci_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
+davinci_irq_setup_gc(void __iomem *base,
+		     unsigned int irq_start, unsigned int num)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 
-	gc = irq_alloc_generic_chip("AINTC", 1, irq_start, base, handle_edge_irq);
-	if (!gc) {
-		pr_err("%s: irq_alloc_generic_chip for IRQ %u failed\n",
-		       __func__, irq_start);
-		return;
-	}
+	gc = irq_get_domain_generic_chip(davinci_irq_domain, irq_start);
+	gc->reg_base = base;
+	gc->irq_base = irq_start;
 
 	ct = gc->chip_types;
 	ct->chip.irq_ack = irq_gc_ack_set_bit;
@@ -74,6 +75,7 @@ void __init davinci_irq_init(void)
 {
 	unsigned i, j;
 	const u8 *davinci_def_priorities = davinci_soc_info.intc_irq_prios;
+	int rv, irq_base;
 
 	davinci_intc_type = DAVINCI_INTC_TYPE_AINTC;
 	davinci_intc_base = ioremap(davinci_soc_info.intc_base, SZ_4K);
@@ -110,8 +112,25 @@ void __init davinci_irq_init(void)
 		davinci_irq_writel(pri, i);
 	}
 
+	irq_base = irq_alloc_descs(-1, 0, davinci_soc_info.intc_irq_num, 0);
+	if (WARN_ON(irq_base < 0))
+		return;
+
+	davinci_irq_domain = irq_domain_add_legacy(NULL,
+					davinci_soc_info.intc_irq_num,
+					irq_base, 0, &irq_domain_simple_ops,
+					NULL);
+	if (WARN_ON(!davinci_irq_domain))
+		return;
+
+	rv = irq_alloc_domain_generic_chips(davinci_irq_domain, 32, 1,
+					    "AINTC", handle_edge_irq,
+					    IRQ_NOREQUEST | IRQ_NOPROBE, 0, 0);
+	if (WARN_ON(rv))
+		return;
+
 	for (i = 0, j = 0; i < davinci_soc_info.intc_irq_num; i += 32, j += 0x04)
-		davinci_alloc_gc(davinci_intc_base + j, i, 32);
+		davinci_irq_setup_gc(davinci_intc_base + j, irq_base + i, 32);
 
 	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
