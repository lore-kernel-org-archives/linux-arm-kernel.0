Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2ACC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:40:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC7B2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bz1toDbO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AOTfbBMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC7B2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XqvbeqADbM6P43MU5Rk9UQ0np7Kjn4tIBVItQ0yncjU=; b=Bz1toDbOSYoXV+
	ha+OsYsPrDhPGGVwak9GzJ9F0gYHzfl4u49sLukJd7n6peUP1eLLM0/WA14L34LW9DO/jAbMrdBY1
	hgYKNpNmhICLOr51PQ8F0EBIsda1MNVORScGAew9O2skwfPHarbICK3+crW7K2IGOyH+vxy3nfd/X
	A4tPyC5XsRr1ZdrOkA1s+sshfWJW1XN/qm2VjbiRvtzbkOyroslAAtI/pfrk5Usw5lQjJ7bTjzFYZ
	2yKYZoPnsQZe7IKJLhl18FJFOLNqmUTNCMtKIzq1bRgqwweTDFVo6thgM5WuaTqb2ajYjKu71PR0a
	czo/MHeUijEBOv2S2C2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsA8L-0003cv-FB; Fri, 08 Feb 2019 17:40:13 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3e-0007EL-6x
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:35:39 +0000
Received: by mail-wm1-x343.google.com with SMTP id f16so4302533wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=caGR+xPQP4nJO6Pesj45R1zU4S0+ykorYdgBwjiu6dQ=;
 b=AOTfbBMtd23OZerUaD0B95Pp5TGB3kuH28oxVZjTikJdkKcIiiyvbmWes6cOim9gOC
 lGXWdDyQS3OlvMPiVAgws09x3h1STpy9SC0Bth1NJa4DqFkJxGhkZrDYmgOQ306oxQUg
 4TDHvshpLZigRehC8osZ1yDw96I9FEEIwMMQasgI/2XsPEi4aCvroyKCXF/P8pcWbvP/
 7vRLv96EJF2mcTX9iriYQCjQv8pF7kaIbHPLk06H6yHc7nkhSjkz0t8xq9bPuGUKocR8
 dVzdY/w2Ufw+8aHjBgC3gL8J7+9ORhgPMBrnKXeWJSStE1YnNHoYGxtpX3/iD1YX5dKX
 4/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=caGR+xPQP4nJO6Pesj45R1zU4S0+ykorYdgBwjiu6dQ=;
 b=NXR32+PCwuOX5MbTgioyx/g/yIDPAwmkVgE78rDcR3KYdJMvyfYaUnB6xm04f4mimE
 BO3UmEj5fQlldGtb8RJtj5OWIu14asmChljgN8iId9590ZATGkI+NiUjR4ODNSKRhU6z
 hqxSmYF8bacES2EH1EW9nJi3tRSZHmD+ffbDeda1gcSKhJj0h1D4+JQswYig7FreedOL
 lt7w7Jil7FXXmDgY/GfUj5M/VgYQkDwjjWInUMxv7B2HyjvHmqJMBj+3216+SvjauG/2
 Jd+W/eCkPdP5dEFS5LcdxYKYQUvfYeomFcfEOawapk6oAORt86rIPfSuG3Jbr/XXLxFP
 OJYQ==
X-Gm-Message-State: AHQUAuYoGhwPfMmy9azpwvv2hzi7dSiVrTFFtcd/SnDPotVf6PHazO9T
 ArdQBY0EqMPno4/swIxZFSi4Qg==
X-Google-Smtp-Source: AHgI3IZxcXqeoiwZnw6PdcCGq8zPSe28nDYpFBXgG8ubOglJV098dnQ1hr8jx7sG6Zy4cHQto2RADw==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr18123788wrf.206.1549647320827; 
 Fri, 08 Feb 2019 09:35:20 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:20 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 12/33] ARM: davinci: aintc: drop the 00 prefix from
 register offsets
Date: Fri,  8 Feb 2019 18:34:37 +0100
Message-Id: <20190208173458.4801-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_093522_684268_BF61BF83 
X-CRM114-Status: GOOD (  11.39  )
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

Since no offset goes past 0xff - let's drop the 00 prefix for better
readability. While we're at it: convert all hex numbers to lower-case.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/irq.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 145fda7e5a35..148c23728bdb 100644
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
