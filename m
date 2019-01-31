Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948FCC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:59:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6664620869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AsMvHAhJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EFPNVUfj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yXsqvJsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6664620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zY7WnUox9yz03mWa4IjDJAH47PuQMAurBIUAr7zyZuk=; b=AsMvHAhJuMCPvR
	3PbNBDVDjxFEJ93bv40I69gk81zq0901M/PeE4j0xM5yVfLLpTUssTO6Xyk+FzHBG7Z6QFhKNDhdx
	7M+h4h7I1HdYNrUQOMEWcgCZw0fRuXv6mDh2Q83G/CLOw/mRjemo9BUCKowXsTtV8TJB4mljWz8wn
	VNa9Wcko/Lz6j7FW/NlPjyk1iyQu47nHahWA11OKp/ocT0Lb/CQ8WAHIQhWLqVhOBYxQzMaph2/az
	XrAemX/B+FLfsPMMP1GChfittVTvomqg7ucJAuYo1GcV9hpMQuo3iEeUxhg3NbexM7waLxL8Lh5li
	9bnFPrlGsq0fBla2M24A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCry-00035z-6E; Thu, 31 Jan 2019 13:59:06 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCqs-0002L9-L9
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 13:57:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k1HTTn1zj1MT4j+ZQRh8biG0PnZ1oRBNNapN+dBPCQc=; b=EFPNVUfjzGHcj58RQRP3jULZoj
 nlbpYOpFLcqP3IOVdcodCso1xmvvD28nWnjLvWZnxCPFQ2nbkH/G60H56uccN5VbWHHdToZdX/0iq
 3pSLGNRnzLf8Pfgj/JqtPyqu8MEn57E+NjQb+3RYgT3HuVUe1z4JoVKn7EhSveOeHOvfha+xT9F4K
 2FYm5b0oRXib3ux1tWTdUSKsKHRGbVY9U6ISc30Ftd4GZ8/+EUh51yViBVRaLfNDfQfj4IR27SeAu
 8oiqaDLimwm9LPWlrBlJirNTQjzqDu9fNHarrna4EYGgznC++RqZA6GcFncAXrGk2sqKWF2UwgWBM
 Ra77W1tg==;
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZi-000687-Ic
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:16 +0000
Received: by mail-wm1-x342.google.com with SMTP id r24so2157211wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k1HTTn1zj1MT4j+ZQRh8biG0PnZ1oRBNNapN+dBPCQc=;
 b=yXsqvJsgY0gXnH7Bhgddj++HS6M1/Mg/ntCKI/aXRWNdAEdnbki//I/WxKRK+J1W7s
 +xyKHgCe4FgJkPTgve5sxnI9ebBjgsRPR6qxic3g97nQ9J3ZhflMuop4CMqqB2kR5ZwE
 byqrOtHObAyNu38zWDaUfuGrSUaJ/ErrWnyFfJSpBj1sWI1/ITjec3IqRvP9uQfiY47V
 lJH9kqFEr5hhFw3gUej2hAL19d7saNoAVft4PEKt5ZqF/iFdCUwB7a0y+v1zOhfEmaVB
 Tn5g2gVzoWH4RkQlA3mXX5Ll8FFGYkXn+/kh6wTLpe3vscW33fHqxjYF6G4dEdNsdCYb
 UjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k1HTTn1zj1MT4j+ZQRh8biG0PnZ1oRBNNapN+dBPCQc=;
 b=YMPkVuQI8IlWccCM4FVksFhzEqSqmR8E0lwNvYDXwJKZ5+/J6/3+p6Z2wFhU8BXQXM
 kUWQmuJLR6b/UMpiNVgctBpOWvD67EdMl8uRXkv4fTKEPskLHacgW1HlfZU+czcOe67C
 AKPqmLK0Ywmz0PgrwKHSu5Y9IrBi3rEzxplHUOXwrm+vp9OrWdpTuZXArFz8cBua1F+B
 YGULUnkMIYUWiu5pn+LNsJUbZ/oypDsNLh17f7dPZOT3Bg0ULZ30Ig+C9lD5d8+KKg53
 wK739HneRadS8ZQrVpT7RhcPIsUbv872Vbvgh9EqBF8TcKRn5qwdkft1ihzkUefHh9t7
 JjEQ==
X-Gm-Message-State: AJcUukd565xi0zx6tNXMFbbjqZ8PKRVQrCS21Ab/Om5/+iahgS/n8Uc3
 q43KmLX9c39yN4CcVbwToNMT1A==
X-Google-Smtp-Source: ALg8bN4fZmcsLxh6VIkBDvi3YojOuyTp7UWE4fZ6I6gO0T9djSicgcYPZ9ew+621Hws57Xi9IezELA==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr29382352wmi.58.1548942012453; 
 Thu, 31 Jan 2019 05:40:12 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:40:11 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 26/35] ARM: davinci: cp-intc: improve coding style
Date: Thu, 31 Jan 2019 14:39:19 +0100
Message-Id: <20190131133928.17985-27-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_084014_654991_9A8DD10F 
X-CRM114-Status: GOOD (  12.50  )
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
index 2ce0b7653c88..4cd515b507f4 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -76,12 +76,12 @@ static void cp_intc_unmask_irq(struct irq_data *d)
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
@@ -137,6 +137,7 @@ static int davinci_cp_intc_host_map(struct irq_domain *h, unsigned int virq,
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
