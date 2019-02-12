Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C9EC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554A620449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nr445PHt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="phQWJmzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554A620449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EVLVgWPr6idtzNF9MInNY+sAKxaca6ZDVlgh6Mj8dSE=; b=nr445PHtTMrZbg
	MpIbEWSgGT8B9JXGoTEQnXoniKjUoE5h8lMbsoi1L1wSZcuq+485j45dwtZ4ucmHjxGqgHgGtaPp2
	f5iz4RZZPzx836QfuJxu3GDmZY9WtEffWp+cS7uLDGmgZXYLk82cY4cH/d2E9slq5IU1IQVQv22Bp
	gXcXucB3bAAU1MiDOs104UVNSILrja/U/s6nlqxhQmpPWjSJETdUXv+EG2dAqWynsDzztYTMdGnKS
	tZjcs/jO/HwWwhmR4AnumGs/7i2d62/hEb+MahDIPE0ewY7oJblxEryUQVgGy08ErKWV8DYACh3qN
	xpeQG7EA8SwGatyKRb8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVVP-00019O-Kq; Tue, 12 Feb 2019 10:41:35 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVT7-000645-O6
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:22 +0000
Received: by mail-wr1-x442.google.com with SMTP id f14so2124883wrg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DqM/kM/HaqHLmbONMvp79H2R5kq1gnK2wwY7vOs0ioE=;
 b=phQWJmzxvT+aOTlWTPIKkAPS9dnH6jBzZIYPWR5NJv8gNP05tzasUDAN8d+HVD5PM6
 +WCSBiMqAHN1N9Pom9iYw0CnCotqCokqRpa21UzqGUmmg3KAVEd+xqI61gl3g6bKYF7w
 v94b6TqmYIg2T5AjxIr7ryePs0cQzlH/ul8ra3u3f/DmzZ/b2goz4Rl+uOE5ioNM3O7p
 HwOBnNIe1iR4B6uojl/B6f/oA1SIBFQh7EI53xSst9fGNLPRM4DKOCZXdgpPJpgs9KGf
 uker5NPIzdk275XhZaGFu35mJlZk4wT4wp5meo7KwR3zRc0qHVlnhAMQyNj9CHlcwUZ9
 zpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DqM/kM/HaqHLmbONMvp79H2R5kq1gnK2wwY7vOs0ioE=;
 b=ckJbb5iqz2tiPxoJOP0Tx96x4hLDVen6SapOmRh40yQCVVLGQP/P+37ScETrsp0X7R
 vJ7wZcIkqZUY8ilRlFYEoqQvVny1qcvvALE8Sg2Jw2rAzTehbn361nWANH94vR7Vscrf
 GP1/PeVfZDM/QMby4wW3XZkBoCN2ljD4cpP9UTx/Dx8K7DSv2HsP9XJs0xoaN1u/DXuZ
 c6Eo5zMWImeWBo9tELvUQp9Z5iPhUPgusWBACxNJXDPZNdGWoDudWqWaQTo1RGAxTpbl
 ZzlE+VwpR2CcKLvPHJ8ljE0VmPy7Ut1wL97WOVdZmlDLJroKRhcu0ToA5zC8EHylX00A
 M4/Q==
X-Gm-Message-State: AHQUAuaboa9/o+MftFPFj3x2z+qGllCr3eulxXLQqYDtVxTyOWGY+5tG
 yu7onPmzqjuIwqofoEQyvfI+jA==
X-Google-Smtp-Source: AHgI3IYzNaeVJOdbgiA1bsfsq58GmrEm1ldAZawgjwSD2uL2A8sxGeMC6wcnYl17nDfFs9S5NFEekA==
X-Received: by 2002:adf:ba8e:: with SMTP id p14mr2272353wrg.230.1549967951986; 
 Tue, 12 Feb 2019 02:39:11 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:11 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 13/37] ARM: davinci: aintc: drop the 00 prefix from
 register offsets
Date: Tue, 12 Feb 2019 11:38:11 +0100
Message-Id: <20190212103835.7768-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_023914_390811_C1D58BD3 
X-CRM114-Status: GOOD (  11.07  )
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

Since no offset goes past 0xff - let's drop the 00 prefix for better
readability. While we're at it: convert all hex numbers to lower-case.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/irq.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 2eb3d9b9f65f..2df91fc0dade 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -19,17 +19,17 @@
 
 #include "irqs.h"
 
-#define DAVINCI_AINTC_FIQ_REG0		0x0000
-#define DAVINCI_AINTC_FIQ_REG1		0x0004
-#define DAVINCI_AINTC_IRQ_REG0		0x0008
-#define DAVINCI_AINTC_IRQ_REG1		0x000C
-#define DAVINCI_AINTC_IRQ_IRQENTRY	0x0014
-#define DAVINCI_AINTC_IRQ_ENT_REG0	0x0018
-#define DAVINCI_AINTC_IRQ_ENT_REG1	0x001C
-#define DAVINCI_AINTC_IRQ_INCTL_REG	0x0020
-#define DAVINCI_AINTC_IRQ_EABASE_REG	0x0024
-#define DAVINCI_AINTC_IRQ_INTPRI0_REG	0x0030
-#define DAVINCI_AINTC_IRQ_INTPRI7_REG	0x004C
+#define DAVINCI_AINTC_FIQ_REG0		0x00
+#define DAVINCI_AINTC_FIQ_REG1		0x04
+#define DAVINCI_AINTC_IRQ_REG0		0x08
+#define DAVINCI_AINTC_IRQ_REG1		0x0c
+#define DAVINCI_AINTC_IRQ_IRQENTRY	0x14
+#define DAVINCI_AINTC_IRQ_ENT_REG0	0x18
+#define DAVINCI_AINTC_IRQ_ENT_REG1	0x1c
+#define DAVINCI_AINTC_IRQ_INCTL_REG	0x20
+#define DAVINCI_AINTC_IRQ_EABASE_REG	0x24
+#define DAVINCI_AINTC_IRQ_INTPRI0_REG	0x30
+#define DAVINCI_AINTC_IRQ_INTPRI7_REG	0x4c
 
 static void __iomem *davinci_aintc_base;
 static struct irq_domain *davinci_aintc_irq_domain;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
