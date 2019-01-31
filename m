Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEC5C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:42:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038B820881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p3bisofJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="RYV5DEzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038B820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wNYO5ko1Epu/x3S90fhwp96WcTPl3w4GGMKrmeNH1eY=; b=p3bisofJlA+z3m
	XjwrZyO0UfCK4Bo9UEeHwWtcJxlvpp8niID65FC+fnSi65CWIsa3eBcgAwB+VZByiIL+dj+eOuio3
	X6wqT1FYqL0LwEesvtoQufRviIrq+qnvIhkPUvzCel/pUf7fGdkql0TnryZ+Wg1tWh51NR4RSo7Dn
	VoL5QN6YlvfdaViwOGnVHq+O7cA+lbgbBiAkgVW1Y594aZhWRnuc8zCqF1DuYokz9qRx2+ZDQKgpn
	EhmoNneWZPXmVs8AcqecwAlHJf9qxY55k/T14XmnDhC1uAXQkTtVk6cYxBl83I8DzjYQgX9kBgtBe
	todGzhcXQu1VY86hrdPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCcC-00008v-4N; Thu, 31 Jan 2019 13:42:48 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZR-0004k6-KI
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:21 +0000
Received: by mail-wr1-x443.google.com with SMTP id t27so3326751wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QanIhRSlQl6wGHvoamzYhAaZ9CMIQGcX9Hv3iPJ8S+I=;
 b=RYV5DEzoSKU1PBmHiU+He6LaLOSZF9P8/gPImBjiYXmwPl55MEFXg3Sr2j8Q1gYTib
 VDlAC0vJdGwISB1akfFzpCza+a7zwLwo4+aPPUGdMmZFcrFyO1f6Qs+VzKhrc6OEOF35
 pE4NwzDZ7HCVvy1IHudHxqo2XCLXK8DLjS8+WtpArwly1k/j9Pzs6A8gii2gpDqr/sIz
 nor04x9qyEbFkjIivz5+6AsF63IcrpONel+9djbvh0lNk+QBT47lZLcLZucvH2S2WKtb
 qxioHWXWjeVg8ky0kdEGcVqqIn+Adv2oDzgdQ41gfCaNdug3XAD8fmXkUZvXUWaxEPwl
 vYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QanIhRSlQl6wGHvoamzYhAaZ9CMIQGcX9Hv3iPJ8S+I=;
 b=UylVcDiTgG3WEbpcdFwKpRWEZ/LUPSIhsZ4ntRgEm8YqEiCg7eMYHV6PizpTD7vMMV
 2EnJJcqXCDfhfx8n/poIYRmt+KEp2eV0Yughrk4vbvTSYyGw/YPbRkKu0rZfGWWU2G1N
 0eFpWI2AHY18O39IrM4Oy43EH6QRtSooc1jQL9FgWgXjSKwlwhhp4WdbYh7t1ruRkxdx
 CznjX6dYHcfymbTjD0aQ24owscm6ftjyZ/f1kQynS9no9C1G6hh5mzTp/tgXHLr3ZF/E
 qAAcsFmTQZ0kCwSxzy9w69xtf+gh7q07YOHvUmOaycOTVqH20+rklzcDBvcaKPWLyaNc
 RAMw==
X-Gm-Message-State: AHQUAubCzgozbU2fxhiWJzkCBSlFhgwscUfybXmLH3kAOSZp4YRTOhlU
 lrTvHcIjciXhknE2roA9TzlAKBF8dkg=
X-Google-Smtp-Source: AHgI3IZO5qofrDBCfkoDg3bkSTWpbu5tdvIda2Dk0kIwZYe6DPteyHFBgoZzNC5yiSO9+3GFgO/C0A==
X-Received: by 2002:adf:fe11:: with SMTP id n17mr7692879wrr.329.1548941996310; 
 Thu, 31 Jan 2019 05:39:56 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:39:55 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 12/35] ARM: davinci: aintc: drop the 00 prefix from register
 offsets
Date: Thu, 31 Jan 2019 14:39:05 +0100
Message-Id: <20190131133928.17985-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_053958_221221_D2F6A4F9 
X-CRM114-Status: GOOD (  10.47  )
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
---
 arch/arm/mach-davinci/irq.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index c43aee686b78..b31821e89a46 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -18,17 +18,17 @@
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 
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
