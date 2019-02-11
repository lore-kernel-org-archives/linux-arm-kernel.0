Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C83DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:30:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8D320818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wqo7OF1W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="N48L8FUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8D320818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tsci1EIWXxYNlr1y8om1V5bV6CO3AbbGU717LMtDu8c=; b=Wqo7OF1WIa4xMH
	0rV4OxH5NSTpwhP8vl5KrJPx1Q3r/k2hLwXOXyKKyxBSP0UQ7iEbBeOfxVPuYYQKuvqIeWL6U7jCB
	I/WOCFXaDtm6tW0kP0fpL/GsKsiWqGS9dDdrb/K3lCCvNHElfKimmhP977OPcbBz6zVZVVa/35Wd8
	P1rQyOTwtR2jOtzfYl2DYfWOqJP/PxTIpe3wszxN7T8NGM40sLivUXAohBZ6EvPsk1Lto2tTWPbiZ
	hAGmg4o7wgqyRcLQl4ih7+my+OIfgwjvqwBF6V3zj0XbRGDGwJSevPmNungOZDnh+KEiH/sFloAx/
	VEtu2m+nd2yGSlDXkPcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAjR-00042v-D4; Mon, 11 Feb 2019 12:30:41 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfg-0007j3-1y
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:27:25 +0000
Received: by mail-wr1-f67.google.com with SMTP id q1so4484678wrp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7gYlfZ8dUsAGabZoJfnAkrezi2SLK3ltNashAmxc40Y=;
 b=N48L8FUFoPpFOnAS0YTAWg2l0y48HLmUcYMfphxyLIFbMi+J20j/cmxn1D+Jr6TMkx
 C3nE+0fqWFgs9JxgI9hYR0VlnDKaCpcyam7BbB5+TP1PA1x3tSmiv9rbbOWxLFmKQXeb
 xt63EBA044XSKdXUkIFOOnHfpq6Z6cBCddV1LhDTUc5coR3GMuM9dm3aPHHHDGZuL5w0
 dOsihb4Pch/ZKCm4c/KBadPHLUd3ek6Jm4jJe6//XIbYEt5vJs6PPFChh1ad1cnJm6/4
 5omFC1Yty6qkq2YbNmK6wqnGhLim0Al572o+6tXE/7LhpbaK3gs+929Ms+Na53+WoWuW
 hvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7gYlfZ8dUsAGabZoJfnAkrezi2SLK3ltNashAmxc40Y=;
 b=UStwzZnB0jCnzfDfHe2KoDWjLPAC/jfgQNaCVELEHoHcdoR5gLwXkw5ia80/1W0x+1
 R9aNxNW4ScCDC7gxpmEf3O3wCryMeOQmHw5rtmJ1cU+9mEXgJ0bZTFC3U9tMPlYiAVWq
 Ht7JAeU7YiUQOxoPqhCycC77rRjZSjzZIieb0/3KmFxnCaMneejEStPcReywCXL4O83A
 su11Gr0eBwn8d2CPSBEPepR/rEoFjvqVqGsv9OXfYAoZD9F2+MWJ1q6b4p8Z1L/L5VB3
 bn3iCjJZ2uNPdcqp0Jid1rbaXQJRnBAHzDwa1kRD+xzaCu7dNwTl196f6LsjzuN2VDKB
 1ZuQ==
X-Gm-Message-State: AHQUAubDYti6LItR/1REDvZsK8z5aZfmkYOW0y0ix6x39sF9HiR+c/lf
 Zk6J1P6/Fdmu7GNSjVHUnqMmdw==
X-Google-Smtp-Source: AHgI3IYPnmpwc1HtFSRqkmujesCeydya0rEXFXaA6U+cZ064qrci+lst4vOY8YYs4YfUeyzNsVyvCA==
X-Received: by 2002:adf:f848:: with SMTP id d8mr29156469wrq.178.1549888006437; 
 Mon, 11 Feb 2019 04:26:46 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:45 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 27/33] ARM: davinci: cp-intc: improve coding style
Date: Mon, 11 Feb 2019 13:26:00 +0100
Message-Id: <20190211122606.8662-28-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042648_571431_DE1D1341 
X-CRM114-Status: GOOD (  12.66  )
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

Drop tabs from variable initialization. Arrange variables in reverse
christmas-tree order. Add a newline before a return.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index faf3d74d3719..f3787ae4cdbd 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -77,12 +77,12 @@ static void davinci_cp_intc_unmask_irq(struct irq_data *d)
 static int davinci_cp_intc_set_irq_type(struct irq_data *d,
 					unsigned int flow_type)
 {
-	unsigned reg		= BIT_WORD(d->hwirq);
-	unsigned mask		= BIT_MASK(d->hwirq);
-	unsigned polarity	= davinci_cp_intc_read(
-					DAVINCI_CP_INTC_SYS_POLARITY(reg));
-	unsigned type		= davinci_cp_intc_read(
-					DAVINCI_CP_INTC_SYS_TYPE(reg));
+	unsigned int reg, mask, polarity, type;
+
+	reg = BIT_WORD(d->hwirq);
+	mask = BIT_MASK(d->hwirq);
+	polarity = davinci_cp_intc_read(DAVINCI_CP_INTC_SYS_POLARITY(reg));
+	type = davinci_cp_intc_read(DAVINCI_CP_INTC_SYS_TYPE(reg));
 
 	switch (flow_type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -150,6 +150,7 @@ static int davinci_cp_intc_host_map(struct irq_domain *h, unsigned int virq,
 	irq_set_chip(virq, &davinci_cp_intc_irq_chip);
 	irq_set_probe(virq);
 	irq_set_handler(virq, handle_edge_irq);
+
 	return 0;
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
