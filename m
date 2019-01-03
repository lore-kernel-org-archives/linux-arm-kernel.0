Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987F9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:23:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6182E21479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OYci9Py2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6182E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=JHzuoECoOmibQq/DZ/0+PRd3ugbXiSYP+vLJgXtYisw=; b=OYc
	i9Py2cgZS+UQbFvNP3FMiaiQ34zqJaLGi04FrRlXK1rF2HMtgeL2bqOvT8RDDgEOtlnViDjb+bj0i
	cyk8D8+2yG7Ny6O2RkxyA8m6LyruIBXIdlYKopSi03CGJHy7iCyYc3V20fbo4aG7e8k7RedVmXuL4
	1+N8PpdJYpnPVQXs/20/teB6hnn6+unTiAwXnH5p0wxm+GN/NQAH8GA0nReoxRgbYSERy8dO6E62P
	grv9rpkqn1siZZwMC0ELvi6DjdbU3NjzHP+I3OWGq36rrUAeejyAGLRNlO+H42azMvo0rSt6bagAM
	hE3QSXnfJ8bXXfuHPxP7a3SnoeX9aqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf2y2-0004Ph-8I; Thu, 03 Jan 2019 13:23:22 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf2xy-0004PG-W2
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 13:23:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BCF3EBD;
 Thu,  3 Jan 2019 05:23:15 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 42CF23F5CF;
 Thu,  3 Jan 2019 05:23:14 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: entry: remove unused register aliases
Date: Thu,  3 Jan 2019 13:23:10 +0000
Message-Id: <20190103132310.42561-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_052319_033570_888AAA8A 
X-CRM114-Status: GOOD (  11.90  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In commit:

  3b7142752e4bee15 ("arm64: convert native/compat syscall entry to C")

... we moved the syscall invocation code from assembly to C, but left
behind a number of register aliases which are now unused.

Let's remove them before they confuse someone.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 763f03dc4d9e..0ec0c46b2c0c 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -392,17 +392,7 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
 	mov	sp, x19
 	.endm
 
-/*
- * These are the registers used in the syscall handler, and allow us to
- * have in theory up to 7 arguments to a function - x0 to x6.
- *
- * x7 is reserved for the system call number in 32-bit mode.
- */
-wsc_nr	.req	w25		// number of system calls
-xsc_nr	.req	x25		// number of system calls (zero-extended)
-wscno	.req	w26		// syscall number
-xscno	.req	x26		// syscall number (zero-extended)
-stbl	.req	x27		// syscall table pointer
+/* GPRs used by entry code */
 tsk	.req	x28		// current thread_info
 
 /*
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
