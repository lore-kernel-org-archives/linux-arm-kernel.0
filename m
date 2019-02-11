Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A983EC4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:28:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7633B21A49
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GXp93zV2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LAH3ZTvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7633B21A49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XqvbeqADbM6P43MU5Rk9UQ0np7Kjn4tIBVItQ0yncjU=; b=GXp93zV28r2jp3
	vfSdbhoXiKCC9z6anV9VnmJCnjsW9C6XQVwCSwRXOaEekh0jWf+shT/qdNV0uXi+ZVV22rZA2Jwee
	FqyJfzv5BM0ZgtQ6SnJqvEprnwvRM5ws2IT3BoQuBSUIDDkrxiQLx197KOFr/exzKFtMLvqUTPHkY
	tIzM1RrA8hT63qMV9yvB36FOdaVCQ8FP5NByp/srZQRNGQv+haO1G7mzMu0bObhiBoP6+RvvXEtbh
	8xBq+JX7PmOSnAvMjol2SpoMKGhHDsg4pq77p4aoOkHkPpX6FvRzbhDlTHbDs+dIKwPBAbvNGw+RC
	/73N+Sk3yEIXRIHDp6Fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAhF-00012S-T5; Mon, 11 Feb 2019 12:28:25 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfN-0007PW-Ug
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:26:39 +0000
Received: by mail-wm1-x344.google.com with SMTP id q21so17009148wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=caGR+xPQP4nJO6Pesj45R1zU4S0+ykorYdgBwjiu6dQ=;
 b=LAH3ZTvJcseL493VTuaAsp2SE095lhSFofkx0/5Q0B/QpcDeJsyGr1u+C7FI+exWt2
 tUFk80g0PLRTAa8uIvQzIlZjmziUR5sVsoZWjIwKwR8oOv2tkl6Ij0oK4AwtmQoLa335
 SDphT1u+IbEfDrSg2fgjuw+/Gfqpnb+IsybRuaMCqVZujlVg0jcaUGpibajEDttinfvw
 hT39tWFnbLUwXk9Jr2bT7xWGOqI2BkwiG4AjUdIZK0bMOZeTHCe9qkNHFbciD5EPWXSu
 q80Dz0fyVNZxtOXzYq9VreaSajJajWfft6Bf46RzbnxeE/hP4rAs74aiSjXIXMOazo6o
 rUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=caGR+xPQP4nJO6Pesj45R1zU4S0+ykorYdgBwjiu6dQ=;
 b=IzGx7+66dDY0lNqsHOYmlYW//YD7PENMiLsrA/WpIEcHjcGq/z+wN0027ElGp0kKeM
 ExOfxbu94/bezMVFHxvLy6XTfd81AnGz863tZHm7AeiveLReCdNdyV2JHemk8MCvhcED
 +BUuoxKCG2XHlmn/F1oGv2rHjOgmj+hYQpXeDZK9IPEUIt6DGDocoI7Dap003+PFRE8D
 SHkapZgrjs4a4w4P5xdzLeNd4POfgG+Xj/l8ULtKpG9ycCAx/TyXBIDAQ7AIecld0iqn
 eI+zl+7vL0fuzYJBpmvqlVhiSXOKBFfu4dJ7H0E2n7n/bXpj3MxD70N1hWGazul1RzIH
 PvSg==
X-Gm-Message-State: AHQUAuZ1MGHUkUxj0tBNdFVEPetQTCQovIdXVIDn2A+lhRxrf68si2em
 T7qumJ7tQ5Q3wabY5i6yQsDVZQ==
X-Google-Smtp-Source: AHgI3IY9xcCufmEPJ3uK+Os/G3CyB2OE/d313Lz7/HnWa0M2LrjO5xO2Tnp/8169gMzfYU/np/uvoQ==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr9678759wmd.36.1549887988652; 
 Mon, 11 Feb 2019 04:26:28 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:27 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 12/33] ARM: davinci: aintc: drop the 00 prefix from
 register offsets
Date: Mon, 11 Feb 2019 13:25:45 +0100
Message-Id: <20190211122606.8662-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042630_648949_674A7BE9 
X-CRM114-Status: GOOD (  10.72  )
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
