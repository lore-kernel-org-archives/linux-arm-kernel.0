Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EA3C2F441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:10:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66D220861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bMUTkFwA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Is/RvMyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66D220861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=MWsSSgtUgJN1tDQCbzfBgsLun+qGQa+T9L6T3Zs+c3A=; b=bMUTkFwAd8HI+qBWu1ZE6tybLj
	NLrZfdQVXbyOZWYLulVgkc83+rg9HYzmEfnxX34UccrbnmQa6ufDhwXcRLYK/CUiR+6vu1nNXEVeH
	v4O1rm8w8qmFVeI67Ej8j7vP+69yv/LSMIV3/JbbsJknSmn7WdTvM9sj1GHw5+6Ce/bd3rlCKE6Qn
	4Mw1rYkNvIAp06NQ5lD1BZHUXMOLqhi07rxo64Da0R6IsfEceCGSCIryShcXBm/Xa18cZCYCJU5rG
	LKCbsOGRJtLR/esg2oYO1lrFsYCMbnAuDLdfng1CDmQ3a9mLreXh4nu0Z6ATm8kctBQ5uA1N1TavP
	9pKEqP6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glc9t-0000x4-Ge; Mon, 21 Jan 2019 16:10:45 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glc9r-0000wv-Ii
 for linux-arm-kernel@bombadil.infradead.org; Mon, 21 Jan 2019 16:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XstrkodA/0TP1WKi5rBiSjR6N8tDC6kxHy8gTN1p9BI=; b=Is/RvMyRILWVhKFXLmpGXIM9o
 yxu1CuyQidrOlpxI2JaFQjruUFkHWBJNWY37BaAD1sPx828e40KRvQeGERzGVsUyFPAxjJSXc9bUx
 FdzUbcj4XsSSkM2d+lkjGxGu6pWd+kFDOBF81eEO7v3D6mzbWcV7uIQJ38JtwOEVVY7mhOIbqo55t
 g0mu0wkmfBR1IAtevKJKjHLLvcWG4Fpov777dLvqgQTWrwxoJNuZSCa7+o6BX9KTUI/6fRIxI8rG3
 PCv5UuRzqdcPdzeO8c+XN9JUyza/NCKM/u5RFJuiOaYWGUgl5dKLBrzXRvWOlbEd1/9Y0hciYjg2h
 GL3SzXz2g==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbbI-0006uS-89
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:35:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B5B01AC1;
 Mon, 21 Jan 2019 07:35:00 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1F8113F5C1;
 Mon, 21 Jan 2019 07:34:57 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 25/26] arm64: Skip irqflags tracing for NMI in IRQs
 disabled context
Date: Mon, 21 Jan 2019 15:33:44 +0000
Message-Id: <1548084825-8803-26-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_103500_386441_4F9C5326 
X-CRM114-Status: GOOD (  12.73  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org,
 Julien Thierry <julien.thierry@arm.com>, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, joel@joelfernandes.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When an NMI is raised while interrupts where disabled, the IRQ tracing
already is in the correct state (i.e. hardirqs_off) and should be left
as such when returning to the interrupted context.

Check whether PMR was masking interrupts when the NMI was raised and
skip IRQ tracing if necessary.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/entry.S | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a0b0a22..bd0b078 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -617,7 +617,18 @@ el1_irq:
 	kernel_entry 1
 	enable_da_f
 #ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_ARM64_PSEUDO_NMI
+alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	ldr	x20, [sp, #S_PMR_SAVE]
+alternative_else
+	mov	x20, #GIC_PRIO_IRQON
+alternative_endif
+	cmp	x20, #GIC_PRIO_IRQOFF
+	/* Irqs were disabled, don't trace */
+	b.ls	1f
+#endif
 	bl	trace_hardirqs_off
+1:
 #endif
 
 	irq_handler
@@ -637,8 +648,18 @@ alternative_else_nop_endif
 1:
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_ARM64_PSEUDO_NMI
+	/*
+	 * if IRQs were disabled when we received the interrupt, we have an NMI
+	 * and we are not re-enabling interrupt upon eret. Skip tracing.
+	 */
+	cmp	x20, #GIC_PRIO_IRQOFF
+	b.ls	1f
+#endif
 	bl	trace_hardirqs_on
+1:
 #endif
+
 	kernel_exit 1
 ENDPROC(el1_irq)
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
