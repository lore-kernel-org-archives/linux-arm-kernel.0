Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931D9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:15:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB2620859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HiQQfYKV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT4QAHOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB2620859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=mN1y2gUH01XiItrMhDYiL+GFbIKhGwoauf0vY40HEqY=; b=HiQ
	QfYKV7EOcDMdcboMK/aWgn5/lmlFu/cUwPumLXlHLgEKw3+371o7lboSo7sjH8UpFDH+DRAseFHdK
	5gJVWJDeRbXh9+8RvCKIUeiG+Flwdv9ieQG5sRIwNsrgXh9s8OiuMN3gHv/Ecxr4ow+qdcIqwI9GG
	lAtBZhpjcb87+XdLMXPcK677zoyOsTfvOkNaeDkEkqVcjisjWmuuyOwNdswimqsILTMT8Jl8xUV0n
	GsJ9LCkeyvkfwFoecOGLTMXu4ds2t7ovTeVLhHSa8QvK+gYTE2vpeiKvvSoyOjXe43SpgwoHYz1of
	udM9KDLqOQMUqptmS4eRyAZa0BiYz2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwa9V-0003qG-Jt; Wed, 20 Feb 2019 22:15:41 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwa9S-0003pp-Np
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 22:15:40 +0000
Received: by mail-pf1-x441.google.com with SMTP id a3so2811752pff.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 14:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=JIPebUwrfUQp4/lobhfycIns3KRkR56rOagABg4mSCM=;
 b=IT4QAHOqN9B5lNm3IJ1Q6dA+tYZgPGLa/s+njUzyaU20PCFZn5eHCwdmN8MpKlbGjs
 yUgziNaEEC7w2vNEWz1KCX2SJCJeQGgC4BPo68nzNqqVMRIJyM2rNbFEk4VRrqRkLhWl
 Vo5pIOaO1yYdODf6FGKJ1pW+RBzn5GjNIKzU3lLc7+dFHjIgytYyWjfGF+1CRsA2gQfj
 bl/R16dGORJ9HL7now3zRUWwOpL/PWkf0SheJAsar5MguqYnYnbtWp3WxN2sMvHp+z4z
 6QWIV62O7f1KaaC8aagGGMNblXn6qfGxaq4F+oA3JvN05HFY4WKEKMnpIsmSOpKPOtbv
 SudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=JIPebUwrfUQp4/lobhfycIns3KRkR56rOagABg4mSCM=;
 b=alHSRMQo2ca9FUAJ57KyKo0n1Eq41eOkXFJUHCR+czKeTj/HRRa8uqjt6GFBvLWpzQ
 Jqltl2cSINoa72gGlip1e3WggQt5MbKN61vUd0LPTqC8SKlCrfAeOc9zJXaz6ohqPP69
 BoJdnowlzBTebFaprSRBUSMTBbOfskAAdZ9VqLlJH7zatxt6QRMYLeQtqNP5ydeOqAL1
 g4MN3YViaWcIq8keIhLK1zy/XX4ZA0OswtWUKhd653ujvgBgVC8BEs+//+qMFM8rL/zT
 CKt1X2BR8lCIcwxX91/Q8P4qnhb2HcB/LWMOxAJR5tRkfMHF21kvi3njwWZEobpJuYXl
 UjwQ==
X-Gm-Message-State: AHQUAuahR9fpHPyMQxG2V+H8CgVUFqxdc6ptf8os4wmbFngdnDdwmjKd
 TWjUZ6G8pge1LoDSU0MNW5o=
X-Google-Smtp-Source: AHgI3IaFNdYHO6F4cdbiItPo5PAZjXMdkk+Tn/fKRXp92LyuZ5qC0fNOwqF82i/6aFfRRctB26ZXaA==
X-Received: by 2002:a65:4608:: with SMTP id v8mr31686795pgq.9.1550700937254;
 Wed, 20 Feb 2019 14:15:37 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id z9sm56779603pfd.99.2019.02.20.14.15.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Feb 2019 14:15:36 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org,
	marc.zyngier@arm.com
Subject: [PATCH] irqchip: brcmstb-l2: use _irqsave variants in non-interrupt
 code
Date: Wed, 20 Feb 2019 14:15:28 -0800
Message-Id: <20190220221528.20811-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_141538_801256_5EA6179F 
X-CRM114-Status: GOOD (  12.23  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Jason Cooper <jason@lakedaemon.net>, Kevin Cernekee <cernekee@gmail.com>,
 "open list:BROADCOM BMIPS MIPS ARCHITECTURE" <linux-mips@vger.kernel.org>,
 Doug Berger <opendmb@gmail.com>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Doug Berger <opendmb@gmail.com>

Using the irq_gc_lock/irq_gc_unlock functions in the suspend and
resume functions creates the opportunity for a deadlock during
suspend, resume, and shutdown. Using the irq_gc_lock_irqsave/
irq_gc_unlock_irqrestore variants prevents this possible deadlock.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-brcmstb-l2.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 0e65f609352e..83364fedbf0a 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -129,8 +129,9 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct brcmstb_l2_intc_data *b = gc->private;
+	unsigned long flags;
 
-	irq_gc_lock(gc);
+	irq_gc_lock_irqsave(gc, flags);
 	/* Save the current mask */
 	b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
 
@@ -139,7 +140,7 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 		irq_reg_writel(gc, ~gc->wake_active, ct->regs.disable);
 		irq_reg_writel(gc, gc->wake_active, ct->regs.enable);
 	}
-	irq_gc_unlock(gc);
+	irq_gc_unlock_irqrestore(gc, flags);
 }
 
 static void brcmstb_l2_intc_resume(struct irq_data *d)
@@ -147,8 +148,9 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct brcmstb_l2_intc_data *b = gc->private;
+	unsigned long flags;
 
-	irq_gc_lock(gc);
+	irq_gc_lock_irqsave(gc, flags);
 	if (ct->chip.irq_ack) {
 		/* Clear unmasked non-wakeup interrupts */
 		irq_reg_writel(gc, ~b->saved_mask & ~gc->wake_active,
@@ -158,7 +160,7 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	/* Restore the saved mask */
 	irq_reg_writel(gc, b->saved_mask, ct->regs.disable);
 	irq_reg_writel(gc, ~b->saved_mask, ct->regs.enable);
-	irq_gc_unlock(gc);
+	irq_gc_unlock_irqrestore(gc, flags);
 }
 
 static int __init brcmstb_l2_intc_of_init(struct device_node *np,
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
