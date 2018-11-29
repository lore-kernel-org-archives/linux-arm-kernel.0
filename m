Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79F6C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:25:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7715520863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YPg4ZOlw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SJm6Shy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7715520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D2v6bhi3dUh5kkZUGb8ByFBek957WJvL3AnlIaFj1q0=; b=YPg4ZOlwgPwYcq
	sjUgYABBImbojpNUWWg0y6oKluLtL/r+2qPPlny0ZrtWtj+JFg4XO8KsZdLf/OpZ6EHW7cbhZg/36
	T5I1+upPMq+4gCzGEb/irLB/96rPCrBSYSHywMJJzvceY9ZEM2YB6/nryOuQzvjrgzsjFPRMq8KW3
	aS/Ka/R3l+9JM+ZDU4gv/vuCrJjN7gQxIEyViWP7vmhWwx/0Vret7t70NsIo71X5/gYaGrC9EQNoC
	Zj5E4UXEzGKhfCPggaNF6my7LOr6WraZbvaGKP44lOxBpwEymj60DLxajbijnjmaImDWRgk911M58
	0YN3mTxIU5NTuvPXuHjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQ4E-0000jv-Sb; Thu, 29 Nov 2018 17:25:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQ0k-0004pU-DB
 for linux-arm-kernel@bombadil.infradead.org; Thu, 29 Nov 2018 17:21:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SARPDdke6+qxC+U8Uxe3SeCSArOfv6H2EKwmxNcbqBs=; b=SJm6Shy+Ll0StSPGsr4eGqqQ76
 O/4BAqMowezuvIOK5PkEcPq/Gi+u/B3awvw0z2wVtOCqrKHA4Ydtt49QnAWpIL9YJ17ydhY+Al4vw
 5Tr1N5o2+ayw/HeDWXEG8EpeVbMs4QmQ2RQaFzFG3FQbJrom/1Enx/X7t+OErCdaGuLRSEaJFsdBx
 w6dJDpBd2n6ShlhlM1Rjp3hpPaR6R14jV9LU7Jl+ykEPHOi+4CxhEcYfrSr7eELSbuj02xdouUJE8
 RdrCJVdRDZogG4SKCPexf2WLoRpMIPC7iJSiLvt57NBOxakCvnsMCz2bqT1YpIKGD9XOQRpKRJwbh
 ZX6D0FfQ==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPlm-0002ny-VQ
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:06:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B050615BE;
 Thu, 29 Nov 2018 09:06:30 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B0633F59C;
 Thu, 29 Nov 2018 09:06:28 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 15/28] arm64: compat: Generate asm offsets for signals
Date: Thu, 29 Nov 2018 17:05:17 +0000
Message-Id: <20181129170530.37789-16-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129170530.37789-1-vincenzo.frascino@arm.com>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_170631_160557_375BAD33 
X-CRM114-Status: GOOD (  10.96  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch updates asm-offsets for arm64 to generate the correct offsets
for compat signals.

They will be useful for the implementation of the compat sigreturn
trampolines in vDSO context.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/signal32.h | 14 +++++++++++++-
 arch/arm64/kernel/asm-offsets.c   |  6 ++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index 1f05268f4c6d..a6fd7be1b22a 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -52,7 +52,7 @@ struct compat_ucontext {
 	compat_stack_t			uc_stack;
 	struct compat_sigcontext	uc_mcontext;
 	compat_sigset_t			uc_sigmask;
-	int 				__unused[32 - (sizeof(compat_sigset_t) / sizeof(int))];
+	int				__unused[32 - (sizeof(compat_sigset_t) / sizeof(int))];
 	compat_ulong_t			uc_regspace[128] __attribute__((__aligned__(8)));
 };
 
@@ -66,6 +66,18 @@ struct compat_rt_sigframe {
 	struct compat_sigframe sig;
 };
 
+/* Macros for asm-offsets.c */
+#define OFFSET_OF_COMPAT_SIGFRAME_REGS (				\
+			offsetof(struct compat_sigframe, uc) +		\
+			offsetof(struct compat_ucontext, uc_mcontext) +	\
+			offsetof(struct compat_sigcontext, arm_r0))
+
+#define OFFSET_OF_COMPAT_RT_SIGFRAME_REGS (				\
+			offsetof(struct compat_rt_sigframe, sig) +	\
+			offsetof(struct compat_sigframe, uc) +		\
+			offsetof(struct compat_ucontext, uc_mcontext) +	\
+			offsetof(struct compat_sigcontext, arm_r0))
+
 int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 		       struct pt_regs *regs);
 int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 06cfd2363a86..4f8317c23908 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -30,6 +30,7 @@
 #include <asm/fixmap.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
+#include <asm/signal32.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <linux/kbuild.h>
@@ -81,6 +82,11 @@ int main(void)
   DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
   DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
   BLANK();
+#ifdef CONFIG_COMPAT
+  DEFINE(COMPAT_SIGFRAME_REGS_OFFSET,		OFFSET_OF_COMPAT_SIGFRAME_REGS);
+  DEFINE(COMPAT_RT_SIGFRAME_REGS_OFFSET,	OFFSET_OF_COMPAT_RT_SIGFRAME_REGS);
+  BLANK();
+#endif
   DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id.counter));
   BLANK();
   DEFINE(VMA_VM_MM,		offsetof(struct vm_area_struct, vm_mm));
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
