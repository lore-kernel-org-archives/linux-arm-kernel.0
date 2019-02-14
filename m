Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE49AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:10:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9960B218FF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dJruHet5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TBkUuiqV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0658j7AC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9960B218FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D/VsbZlS+NuOUEmnTdJcul9/VTfqoREkD3n8L3OKLNQ=; b=dJruHet5jBwTOz
	oNe80jPu3fzfyBS3vtN3coswzzwBufl7jli2eiYPKyLAosDJxobyAk6m/HvmaaqIRzq+dH61EAK13
	HjK/qqX3kCXDa/3iZ4DCWOeTyN53i4hMXOqFI/jKzi90veX94NIJ96dmF3XvM/hSNdSCHHpxEZIYJ
	ji0kQRIYgpW4ufK70Dc5f4EvV6Jfxc3wIVghpe6ja2Z6whxZr6A4DRv9h7RIrwm3Y85FLVSCyN0i5
	dkUf2gSJKkc5ZgNmK3yb7DsQDUVgXhpADKFCYwP6TFdZRGNmlNvOzgC8xsLtyjpQacblLKxeC3aUi
	ZzeHAceV4/zfU+0wv8PA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIeW-0002Fe-5A; Thu, 14 Feb 2019 15:10:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIeI-0000b5-Ar
 for linux-arm-kernel@bombadil.infradead.org; Thu, 14 Feb 2019 15:10:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uTYZ0vXP8sAs8gifFLvRMBmuXz5Fy14EY7Zl2hW8P1E=; b=TBkUuiqVZvy7/GgyC743RFPg4q
 g37BVw2v4FtgVGiUKqIMMPFQc5fV4F76ud4wsAC3Ju16RmRE0SlbWmDH+doUkvFK3hIi4FycBzD/R
 XvHeM9IgwkW8iD4IovTM7/aASEwu91tkr5OwGembYn7necyAZbWjNdL6gHnX0i60PWKp2cYsPXOSX
 nfz1f/R0frL6v5PACnqyclFhsgvoiQFgIrUy/OyBzazr0kWeAg7SmIBA3Ur17hx+UOBtW/VKGGoKr
 zMkNs9VUEjaIn+V3D3CSRamnNSAsFA1WFY9U1cfcZ3LWeXAxnezFTtpBZVr52v8OYEM0lKfBHQXiM
 mHjVeNoA==;
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIO8-0007ov-Mb
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:22 +0000
Received: by mail-wr1-x441.google.com with SMTP id i12so6838500wrw.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uTYZ0vXP8sAs8gifFLvRMBmuXz5Fy14EY7Zl2hW8P1E=;
 b=0658j7ACh1agWR//z8BaobHFmL7RX/R2bpEHD2W4/W00SBxksiZqRb2RgYchwsQFUA
 2h8vnzEkbY21CvZIqmLIfpim5mSmwiAiVqIcbl4aXTxO/JgiNBSln91Sn+cM6oF9NR8L
 d1brm9EWaiRdgopV6BA2tgxKRvZhcdS79YIYn2gPOUbzOHrxe2W4olXUEOSSAijRssnD
 9aPZnuA+xj+8X7IU5MWNtxMqTSFjF0WTn6pquyIwqLWwoBAbPTkA7vM6jqN6GOs3EqQ3
 wSpvfc/QAlkxI4JLEzHGxZzk9Sn8S/YKjDjPNQy0hPY4BoBK5F7ebGtskEibZJ6+MODr
 XNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uTYZ0vXP8sAs8gifFLvRMBmuXz5Fy14EY7Zl2hW8P1E=;
 b=K27ITf+SSXWU87fpnphC5t9Axa26avCGDTqakttPJ3AZRLme73DQCrIB55lk2xQp25
 yGF+pBUKFFFxlxCTIm/8xd5OhRqVbki7kcoaD4lgMsw/Zn4rovVurbyG9ePNcJ1H2DhY
 QqjtRyfxTBTMGTAy2Xkh6lwm/k7n3nOTmebFWjsgZpOfmJVVe0QMzR7IQ0lBHFo2gNbV
 FFYgKtRWZKP9Hwb9LkEbEf+E/vqYOMWcJ04sG7Y0C5v1kUmxFfpE9QzYjoyJLiU4oEMc
 fQhzWgMmrGVjYt4TFRC1tdkGOUpif+a0klxLwKaNNW99ESaT9/JvuvFmbHXHcbnfI0dH
 HZeA==
X-Gm-Message-State: AHQUAuaVWB2JeWaby+PVgmd1NZWl60Iz+cciODkoLP0qDet02pVFJTC6
 MG47X2RMHh19v2K+4hREM/g7Bw==
X-Google-Smtp-Source: AHgI3IaGxONeSlkBAe1qKfY/jtNqvQRmQcAkuYpWf9t1xu0vttrkNAtLX7HNJCKNs5a5TK+Wp7yliw==
X-Received: by 2002:a05:6000:1110:: with SMTP id
 z16mr3267768wrw.28.1550155999778; 
 Thu, 14 Feb 2019 06:53:19 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:53:19 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 31/37] ARM: davinci: cp-intc: improve coding style
Date: Thu, 14 Feb 2019 15:52:25 +0100
Message-Id: <20190214145231.8750-32-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_145320_750453_4E708EC4 
X-CRM114-Status: GOOD (  15.86  )
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
