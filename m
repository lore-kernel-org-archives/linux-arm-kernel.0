Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B83C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:42:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A712146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EsQvQGAY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Uv+caocM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A712146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DyA5QQE7fUihbrKMjdFreAwIN44sUjaNVZ9T8gNqtZo=; b=EsQvQGAYlYX8VA
	Dd+brKnckHSRnjCKfiKiwp+T6WhjKQwKGC5ghSNiFrBlPECCMs0nF+MD7ejNJkX67ZMix0y5XcuXt
	RzAONCCLbsiZdN/kZo6tFFHIaHL0KM0115sNfWddwBT/Mi0anfhfpoKvxCFriHuVn1osiALJIPk8S
	/MKSsIEZjqnkxVzHBBdAfWbofwYbfGt3lccb4MHBT6jwBgw5F5UX1sbjaCRusOdC9iG2o2VxV0avG
	DvLKMb+6fppWhDpNJ/4PHVcgYGsJ9ktyCRfZyJ+RmYpzcwR7x7tDRQEglXbkrQYOXWiPDHHKGGG8S
	aGpXldkojEACKmaVOrSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsAAD-00067Y-Ki; Fri, 08 Feb 2019 17:42:09 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA40-0007d7-IP
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:36:06 +0000
Received: by mail-wm1-x344.google.com with SMTP id g67so4273586wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sTea19K3binG0va6K3CDh++GjnL1PDlQZK2LSFZjZkA=;
 b=Uv+caocMdpNFgkFDcaJqdy+kjNtdbH28LW8ltHIyMpiWHChJzPTwWTPs3EDSGGYs0W
 D+uOq9GUHN1UtLEiMSu2DldQHTmMJqZtvR3y/fqJcKf3GEMM5YE7DPFQIMYGWZMzE/1w
 DegtqUrBGLNyX0WNwi3qdhx+QildyRozNmpgJCMpDZN7yRDRttEUgQmxAkzdb+heUN2f
 sh2ATwDokioA10sQ/N4iRSYQSkUWY3rcaHEGy5usDh4KgIDTx0hy1SeFU8Mw0yIFHjcz
 Z6V3VBCBbqZyWSA4hlgj/e18I/OrYDwK8i2chGeVOCzjMaxKj5/cKDwTXAdc3rVF8VXY
 8pEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sTea19K3binG0va6K3CDh++GjnL1PDlQZK2LSFZjZkA=;
 b=JKl/yi3bEvZ/NWIMCFFRBrAb1IubML72Cq1yLmSXVXgrG0ccGai61S90wcDXlvjaqH
 ljGL6qhMMUWU5BDtMxrMtVXpRDCtna0kbh1p15rEi7qssBIIITbNvicAP23+a9GpGDz9
 +d9+HvP5KpER5PnXqw5gl46v3RY7hWyHRArk4V5t1WHV+lxt02dstEtqqJhCdNAHATCu
 oWflAPxU6z5MpplDZxhz/iek+erHW/5Qtu0i5nCeYIs5gh2Lf6t8N5OnNCGSJxPazdoy
 Uov/1F/DGOc3QFKRpUndb7OvVCOiedCGo1symFk+3aozH+mKA09YvqpmwbEKitP50A6v
 +YrQ==
X-Gm-Message-State: AHQUAubmvGMkbwhYTyU98cn8QNHpELOFZyFRFZSabXe4cz2aqbhXPa62
 1syFpE4HsojjFyFWWiCXs1sspw==
X-Google-Smtp-Source: AHgI3IZ+vYnRfDHz0S7Iaz/A7JLuUD/0qDbQw9Rt7EpJg19BgkyaCs1UV7Z9KwDxazSgCmLpn7Vu/w==
X-Received: by 2002:a1c:c4c4:: with SMTP id u187mr7529550wmf.114.1549647343254; 
 Fri, 08 Feb 2019 09:35:43 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:42 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 31/33] ARM: davinci: cp-intc: remove redundant comments
Date: Fri,  8 Feb 2019 18:34:56 +0100
Message-Id: <20190208173458.4801-32-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_093545_581172_8EE402A7 
X-CRM114-Status: GOOD (  11.60  )
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

We don't need comments explaining what functions with obvious names do.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 2040c974689a..e32fa3b1889d 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -57,7 +57,6 @@ static void davinci_cp_intc_ack_irq(struct irq_data *d)
 	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_STAT_IDX_CLR);
 }
 
-/* Disable interrupt */
 static void davinci_cp_intc_mask_irq(struct irq_data *d)
 {
 	/* XXX don't know why we need to disable nIRQ here... */
@@ -66,7 +65,6 @@ static void davinci_cp_intc_mask_irq(struct irq_data *d)
 	davinci_cp_intc_write(1, DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET);
 }
 
-/* Enable interrupt */
 static void davinci_cp_intc_unmask_irq(struct irq_data *d)
 {
 	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_ENABLE_IDX_SET);
@@ -201,7 +199,6 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 	if (WARN_ON(irq_base < 0))
 		return irq_base;
 
-	/* create a legacy host */
 	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
 					node, config->num_irqs, irq_base, 0,
 					&davinci_cp_intc_irq_domain_ops, NULL);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
