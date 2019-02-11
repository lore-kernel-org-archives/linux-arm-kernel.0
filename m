Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870BFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:33:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ED0420818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CSBkJU+c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jIWkXbVG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XvFefnzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED0420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DyA5QQE7fUihbrKMjdFreAwIN44sUjaNVZ9T8gNqtZo=; b=CSBkJU+c1e27l1
	9UkLvnMYhJ58McTEzIN4eXFBOsFZZ4B9uDHyNs1hXrKTkAFWFEcJdna6pjf/sy0nWcjXG9laIJVnF
	AArAQ/ODezUi2b9ti7urEegXHz8HDJhVOX+9GIx0J4x2tRRVXZKsnqI4oJrIlFI7XJtdy9XHuzNsv
	dL8J5Lhn3vLnoh6sKVENo7G8WjQK8qv49EOWekDkPHicMYBz78QvQuXuivvKGkm3cqp+VXi81ws0+
	K5/TlJn1QO9KauGadKoCBNDlPD2Sg6NlBeduzoj6/qu3AE/m2lEZrUNWy2V3CzO0XWVh9wJLQPGD6
	KV0miMvQOfhdM1qw+FkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAmI-0006Q7-9O; Mon, 11 Feb 2019 12:33:38 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfn-0007sQ-Uk
 for linux-arm-kernel@bombadil.infradead.org; Mon, 11 Feb 2019 12:26:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sTea19K3binG0va6K3CDh++GjnL1PDlQZK2LSFZjZkA=; b=jIWkXbVGbd8xrNTODp26Ws0Dmf
 ze2nqtDNM5Fhwx9U4wvmY5C68t1y59Hj5NZRBiReA9jvd/KB8GshcN760k/zrbHT3+HNnz08tESbj
 eNGso2dVqGMBXUfEMuqtheIbf/9GZnjldb8eCfVqV/cNgw0ohqPnJGdr66JYWGQk5jJ9L/BchPn75
 qlFn7SJq/wyxwB/WnDqh+WNnGMLvs/b2ugndkortKvSvO97vMLW6V8HjFJthf3RXonl2JMbnH4FSa
 pqfPMXcrkYpkySgA2rBvVfC/EVKuZ92C2s5i4yy8l7mwGCFnQrvqDlEUO0jPJIpGnwjrv9P3OpjVW
 61XadE6g==;
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfm-0008Tz-5O
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:26:55 +0000
Received: by mail-wm1-x341.google.com with SMTP id a62so17478970wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sTea19K3binG0va6K3CDh++GjnL1PDlQZK2LSFZjZkA=;
 b=XvFefnzcpYD5ALIRM2KGQQj34oyU/+3fZ3ZGR2mqxf7Uqhi092067rNqVHIuthUeuL
 jOhU+zbBtwvKMi8Li1WBP/nXj/NXGQDWqE5tIe1v+Ar1RnGt21ywt7q6Pcxb/G70EWrJ
 +1CpNRjIsSF8OJg/bvQGnxLNruUhnII5i/PJsoMXlKuEBVLegCr978ffcXWzvd/Y3RuC
 ffdnF+HUKNADFBnlwN6DYoXoY8jePRWiSWOdd5xfHVubOYf9PCKEnOcVrJzg4Q654zku
 Z6bXnYH5rLekdGtsh+nAexx9xr+uZv9rk/sMynirzr9BQInaiopTaDJscIi8RKut2nQA
 rKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sTea19K3binG0va6K3CDh++GjnL1PDlQZK2LSFZjZkA=;
 b=D225rMgW8eVexE+koaHJZq4Lgx8JXUDEJG6XP8pGZ4LugpZyQL3fcLUkeJOQ+IeZhg
 KSwTX1pRV6Di8u7OTMxtqtIIcImXjBkDCz5ZU5LKq/k3baSqVqEEfhm4BuE7qdEAhuvX
 dJlRi2jN4s67+beP8f1mZ45fxXG+foVaERxT/dOxrjIyvz98H/iNWZJ0d2nPEUTjkKn4
 wksl8lXvoqKxUXD311OGucUbLnRxTHS5h8CNRckV7ajUW6zAiM8v99wLy7GkjNVxw96f
 DV8CIaJTZbDAbZNB//bsDXLinbm/1WlZxFWH88xgLk1vLil9n2reVwGnMMG1ZgBCXGli
 JI0Q==
X-Gm-Message-State: AHQUAuarqwbaEiboxHdk6FxIJcQlznS+6OURfEMjQxjdI604L67NWnb6
 t/tBARHxzS4HrFJfei48/VOrDA==
X-Google-Smtp-Source: AHgI3Iarb1FLcGmry7RiSvTBrPz9ALtXwOgxsIwgzDlDv7AO4KuEI6zOMYR15AfaHbJg7pe29O0CLA==
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr10088623wmh.144.1549888011093; 
 Mon, 11 Feb 2019 04:26:51 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:50 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 31/33] ARM: davinci: cp-intc: remove redundant
 comments
Date: Mon, 11 Feb 2019 13:26:04 +0100
Message-Id: <20190211122606.8662-32-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_072654_235492_B2BC0846 
X-CRM114-Status: GOOD (  12.68  )
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
