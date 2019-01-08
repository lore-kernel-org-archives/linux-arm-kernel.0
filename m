Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E69C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:11:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAB920827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ENplgSOj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x6FJIh3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAB920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=uBS/bLagtZoLArB+pARNhhe47vK+iKvi4UVKfhq5cEw=; b=ENplgSOjt2Ed9aoblTp7Qoql7c
	OvRhgvpZGgpSjtgqaunUTeIQd1KyKIUZ/5INkOp/mJAPgHpjt0pwptmE8+JMuvEAqMxagvOQhOYDo
	WdTXPHRklo6/46jWpJUt6aKWW2bGf3dYJJbttT4BOP+H/6YZEs77HEHd/stiNYUX7IbOJ4lCqOqjR
	FJjbl0DcvoKRp1pZuUAXjNN+17phnCuQezWHmRQ/OtoutHXasZV3wb04ZNt4PIKBH2vdUG9nxE3BW
	/QhBCBPM4EeFkDYSSbObwz59aCGsl6pJVSL7+H4K7lYLXQC0wuKEBDlgqa+NAfi5kBlL9bx5LXkTo
	F+jVUTiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggt1r-000809-Ry; Tue, 08 Jan 2019 15:10:55 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggt1l-0007ru-2o
 for linux-arm-kernel@bombadil.infradead.org; Tue, 08 Jan 2019 15:10:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9n57iFEKD8GQpICV1W7n49NUkwnU3SW57I36Fliu+Vw=; b=x6FJIh3PUAf0ZHtKbzF/dJb4b
 F4aWyvBfZT2kfSJbY2bDfT9CK37nCo5CrB28jGxy2KU5rzDUlM9NLTHS8L1Bu1T9Qe2eovvUtlk1c
 6EJ8tZ+MBCaSsJDUZvPe2Q/+UHSGmqYfjgdyChZNnw+XPRM0SOflFFSHxR6K6IY7N7M1nvO9xupHo
 +OUww1hqOesTGmUkjxXVjyYQCfR++ihif8M7zqGZO0RIs9wnFCy/rxUmmoeUofoGSvsEOna/OJ9EI
 tLrG2sfLURnYlxZNAL9glnoj9rnuWKi1+wA+V0qnjzQ9ktMEE5MjiXF9N/WnLMlsdrbhf/gvc6PL7
 jRRLRVXhQ==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggs3q-0000D1-GD
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:08:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 590A180D;
 Tue,  8 Jan 2019 06:08:54 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5CB0A3F70D;
 Tue,  8 Jan 2019 06:08:52 -0800 (PST)
From: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 24/26] arm64: Skip preemption when exiting an NMI
Date: Tue,  8 Jan 2019 14:07:42 +0000
Message-Id: <1546956464-48825-25-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_090854_670268_55576BFB 
X-CRM114-Status: GOOD (  10.35  )
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

Handling of an NMI should not set any TIF flags. For NMIs received from
EL0 the current exit path is safe to use.

However, an NMI received at EL1 could have interrupted some task context
that has set the TIF_NEED_RESCHED flag. Preempting a task should not
happen as a result of an NMI.

Skip preemption after handling an NMI from EL1.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/entry.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 35a47f6..a0b0a22 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -624,6 +624,14 @@ el1_irq:
 
 #ifdef CONFIG_PREEMPT
 	ldr	x24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
+alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	/*
+	 * DA_F were cleared at start of handling. If anything is set in DAIF,
+	 * we come back from an NMI, so skip preemption
+	 */
+	mrs	x0, daif
+	orr	x24, x24, x0
+alternative_else_nop_endif
 	cbnz	x24, 1f				// preempt count != 0
 	bl	el1_preempt
 1:
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
