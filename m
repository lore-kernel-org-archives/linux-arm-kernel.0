Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9BCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:10:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521A720827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CSN6qJSk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p8CjZv2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521A720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=MWsSSgtUgJN1tDQCbzfBgsLun+qGQa+T9L6T3Zs+c3A=; b=CSN6qJSk5WGRvO5CPROeBqakCc
	joKkvxdapMs+L7mICtc8ULFiAeJfHYbvR6JNzs0hArgQ9xSfbMKDaqXfJCCnxrT13gfjm8nqM4QnD
	9X7ZJGVcnQUHgcOHr3sRTCiJhXL/LKusXzon9Aqn2fn12mRXOoae2eiScGBds3vyoRza5NvpMBjv9
	rfcjiMfdjsv7ewaf0EGcEXH0qnufHvSkisOssVDYPKGQ2hbTmXCh+fKObCseXy6ziRUJbTp0T0fe8
	zGD4xYHy0aL90KqJKbtFOL0I1Hbu1o6wQBHGUM0NtPrxdX7KWurRglzxpbHR4p9nttrbNYM3Wgvop
	LvMIGu3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggt1i-0007s9-DK; Tue, 08 Jan 2019 15:10:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggt1g-0007ru-2g
 for linux-arm-kernel@bombadil.infradead.org; Tue, 08 Jan 2019 15:10:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XstrkodA/0TP1WKi5rBiSjR6N8tDC6kxHy8gTN1p9BI=; b=p8CjZv2ydWA1AS2SXOAzyg37n
 zUn5tqtrFqQxkrQJu0f+jZhZf4wnINjG8+W054IBVTA41BiLFCAwaFqXPvC5+BtZ/wtaJT2uqpKa7
 GWCcrFHP9zh/My6pctEi6O+csswFbXLPSA47qpBmA9SWv35ZkiAGU0EgtjpSClN9iDgawZLJXMAZ+
 +JPNlJuHTPSY6iBY6Iy7XxGu1i3lHpWshqxOcJnwN5F7xRxRz4vpjJz1wWnAYdSB1pPlhmC8bTLun
 GBhcTOAZV9C12FiuY+MyyCLU2Wd7ngacdO8sG/bG6LAPdIFV1tXIfBYJCWo5Q/MJFR2KlCuom4vuq
 PJulqNb7Q==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggs3s-0000D1-Ne
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:08:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9080C80D;
 Tue,  8 Jan 2019 06:08:56 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9546B3F70D;
 Tue,  8 Jan 2019 06:08:54 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 25/26] arm64: Skip irqflags tracing for NMI in IRQs
 disabled context
Date: Tue,  8 Jan 2019 14:07:43 +0000
Message-Id: <1546956464-48825-26-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_090856_853525_A0933EC0 
X-CRM114-Status: GOOD (  10.86  )
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
