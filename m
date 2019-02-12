Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F70C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:56:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44AD2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rWBt6d2x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jb2wpPOh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lIhVFlgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44AD2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D/VsbZlS+NuOUEmnTdJcul9/VTfqoREkD3n8L3OKLNQ=; b=rWBt6d2xI6s2C0
	Jsrgql8zwaGuirHcNbH8D2UBd9wr30dnubDFOTAlWV4dMIsbUhec++pDBEBRYW1PqeQmRmJ/J1L17
	m1qBj5b9xJSuonYZaKTePWyQF4rLFftaexNac76E9r74EuvYW1L/0Euc34V3oEmpXeS1eWHBvTBUE
	6JtFwNfp9xN/dwyPOckOJLK7STtgnsiGTiX2lP/wNX5RsSYh6M9BzL5hXFxM45Nt8BqdQQryp9Ikd
	JMpDBTQK1Pr75Lf7pZhAudawNHin/rAtOndkhOc8xdzs6xjAxDNMKtnkI/gsXTEqV5JY95L0t3ZgB
	WG1BRFcEvd+jesIw2ACw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVjR-0004g7-Hu; Tue, 12 Feb 2019 10:56:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtViK-0002AN-Cs
 for linux-arm-kernel@bombadil.infradead.org; Tue, 12 Feb 2019 10:54:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uTYZ0vXP8sAs8gifFLvRMBmuXz5Fy14EY7Zl2hW8P1E=; b=Jb2wpPOhd2vDDuART99++IIBbZ
 /8EuY6nJKxqR/ROcSp17wzR9ULlVqoZPqW4NOdbVoGl37LF6B2Dar+H2C/BscDH8i8/t30xVFsyL2
 dyZ3mh7g7h5VUmRPenoseoqdaendD78Zdq9gJbXwMD4gIzoAcS/a2Rz2Ufktf25RpDb2ijiQ3QfGa
 Hc4TnObdXBYkTtklalZmiafLay7Cb0j55YcrKPfhLlTNA8RPEtZNUU6eQJiyci2cCxojL8RL0Xis7
 SvQy1MQF6uTTIBU8rJQRzdgS2PZx6evOl0rwSCMVbrp1l4ZG1mbDKjwmovC3+sfBLJ/QEmZP6U5Aj
 2LOTojuQ==;
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTT-0003mS-LX
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:37 +0000
Received: by mail-wm1-x344.google.com with SMTP id f16so2437999wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uTYZ0vXP8sAs8gifFLvRMBmuXz5Fy14EY7Zl2hW8P1E=;
 b=lIhVFlgpqs9i8UBs1sXVt+szDQf7hhJw4n0iFrjfUsliCeDSt/mw4N/1YIki7zYkyI
 L9uO01cEiDV2/OiqNI9uVVJMb4pf6oDFwBDB/EEiyYrCdFDq02liTAYt/r0e/6N/9NUD
 Rk33hnEc/jWDdUzM8LDLzNEWgCCTeBudpvaOW1Rq7hha8/h2cqyFqTbn9242TXp8ojQn
 eFbwPYi8QSWr02BAy0X7EbKc9LIZFbxEviiGNfas97lgfdvqPZcQiJH4vqwrFy8qqIVl
 I1WpuSRHJm0qxcau5eRIRUWjNbutYyS+3ChaEBaToxKNs3vckZ6bxdY299ZEs0zFBD4a
 DU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uTYZ0vXP8sAs8gifFLvRMBmuXz5Fy14EY7Zl2hW8P1E=;
 b=C7IqJ1Lyt23ylTXb0UDQZ1qFw0KyXLIjuHZbyvrIPMEL0IHra4ej0GK1BajcyjeVgP
 G6JN5EPaUdVoDTDOmrA6m5rTvP+zyWs2SF3MRYqaBp7tkup/evgP6q8Au7Gn5PguO2Z5
 p/7O8zsRyVJ7gmuyfUaK779cje31cOFSiWFrz4eXDxLtgneysaUmSc3wvaMabwLcMJZT
 ZQpmeNVdMQ9EJ9VABbkWCKH2x/efSIWTg8u+BOgf6mxkGAUodhTXUriM6FukngqZNgpt
 GmJafrj4RKx/75PrVptYkecRWYktSljrJ+66nMH5iRMCy+jrlDSmdLXZR9qFC8gAR+SX
 7eAw==
X-Gm-Message-State: AHQUAubV1tEsVrX3hqo0+gl7nzrxM9f78GgX6bsXKFjn5Cv19jiIg1cM
 Lg0VjUUFvsFIc1K61aw+HwVU3g==
X-Google-Smtp-Source: AHgI3IZvrU3Gc7o+/aYpo7ifggGgbcm6gMjvXeYm18oGwKV8y8NFJ8EJq/jsNXWqKCjxmwiwHE0uKw==
X-Received: by 2002:a1c:f518:: with SMTP id t24mr2417784wmh.26.1549967972484; 
 Tue, 12 Feb 2019 02:39:32 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:31 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 31/37] ARM: davinci: cp-intc: improve coding style
Date: Tue, 12 Feb 2019 11:38:29 +0100
Message-Id: <20190212103835.7768-32-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_103935_716172_C1CE8497 
X-CRM114-Status: GOOD (  16.30  )
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
index 6ab56af3be6b..25221dfe8a20 100644
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
