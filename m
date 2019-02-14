Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8067DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:54:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520112229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iVMgwTLa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XuxCDBvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520112229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EVLVgWPr6idtzNF9MInNY+sAKxaca6ZDVlgh6Mj8dSE=; b=iVMgwTLa55U1Pw
	yC2eOLKDeoimgfY9qQlBK1p3JAUQr2aYwmSnMAtDtB5ljW1NhdY/xlla+gbpMEHwwDD21sLwND6L/
	cZuH2zXo5uMbPbbFp65kd6tb91bzCR2BUd9W6o/kJvTjfsr77TSpg8diRhOxGJRaT5Sph7rZoBiqz
	L7dOxJEG055IIN6iwsRKqQe5+g/Jo9UVvGf51mTibXEqcO8dj5kGvhIS7ejaEgRMHWQwJ4hd/3w9b
	/AmiZXgM3JfBjorHjdSrc0YY/4tXnOwaQK3w2ojC4Rtq+LdhM4c2D/qLRwrt0rnWAae4rv5k2fY/E
	LCmJLV0QHIPpmVTfjKUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIPW-00076Z-SI; Thu, 14 Feb 2019 14:54:46 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guINo-00053S-9l
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:12 +0000
Received: by mail-wr1-x444.google.com with SMTP id r2so6765775wrv.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DqM/kM/HaqHLmbONMvp79H2R5kq1gnK2wwY7vOs0ioE=;
 b=XuxCDBvXCWJb+O34mxggfJXC5IN9aM6b7wqvr7NIDh8Q4vOWnnMCYkwad28bhOUU79
 TbJcUHxRWLnHWIp0j2t3jvp+cCwM+cQoXUEA/KyYh8nD4cdf5slVNonQXWT3MMIfZoON
 gj46m9R9S8v9sdVu4WW8fkclzTM78qgmS+Wc+OxLYp5IB7HHi3ZFZKI8Kit1Lw3lDdp9
 GodFoD/ECc3KdBJazjfoLcEQZHN6EJRQBXm1dva231zxf9LiqT3FMVLKAoC+v65zP3E5
 QwfKZeGZSwDb7gYEpGCGsCBoFT3Z33UKTxY86wiQJFH/kmrcPqIKvTrAsoIKLvu1/7Bn
 PitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DqM/kM/HaqHLmbONMvp79H2R5kq1gnK2wwY7vOs0ioE=;
 b=emOFhRH0qT2Jx2OzsP6L88xWyFHVVBDjkm5VjKvLr87fswFB1sYfmJmjHz2qbpujGN
 WpNy8VLUTpqT99pxpbSHpafbA9YAbPJA0y18nvEEZvv0MrJiExk39DGKu/dOj8rlCUb7
 /U7ZViEsBfiIINyojQVnqIAj92CVGYNhoNbJ6YFsnUbGPp1gqIw6sDKNHp5SOjvWR1Db
 CvDsLCMHgnvNzwH/ObfnqxWfXyZZmUiaNDiAND6Fv6VdE+by7WDnUmjp6gxj3OOlAqku
 ns68iBPrmYD7Hy7VvTEOeSn0HGiRhddc/PTaOR+MH8WOAoxA1bwtadb9k0NNKDb5bJzF
 LG8g==
X-Gm-Message-State: AHQUAuYwLBEbS29AYa7Z5bD19miE9v/1y5rHVQ39hTxSmKczrVWEQyoz
 a+zZybel4mcdgNnFwvLD6h9JdA==
X-Google-Smtp-Source: AHgI3Ib6PUDF1c4rjkTwSzYSEU0j99yFVD2iXCnZSoKqpWTjKMwn7CUKBqM/eaTl7BBV5HMVHKNNTQ==
X-Received: by 2002:a5d:434c:: with SMTP id u12mr3249080wrr.14.1550155978941; 
 Thu, 14 Feb 2019 06:52:58 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:52:58 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 13/37] ARM: davinci: aintc: drop the 00 prefix from
 register offsets
Date: Thu, 14 Feb 2019 15:52:07 +0100
Message-Id: <20190214145231.8750-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_065300_717538_D986C7AD 
X-CRM114-Status: GOOD (  10.66  )
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
