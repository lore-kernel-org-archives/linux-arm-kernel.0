Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220ADC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:03:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0032175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ifQTK0ss";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gSfTmvcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0032175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3FNRlAJPLUNTjc30rNB9xGos3u8HvjWO1J5CBfTV+cY=; b=ifQTK0ss46xslq
	5YT4LCywezkyhF+aZ+4zBUol6qdrFitjspxf8uEoU7KQKmoYoaOBK78EyGEdOlnaLz7O+qqgu0vyA
	Iq39S6/COwLIp1K5ZEb/xiGdAek4KV6bHpr/KlzdwLmi8zSkph52KGLWPSdoelMFUnqt8+cb5tXpD
	KIQq1Pb0qMOCCZn7NiofkVSbrL3KE4/b5+bnU0hxg05oP57eWBwIRfxoqh5WsuObw4xAkeLQx+vh/
	psXbPUAvkKBRY7m9762e2cP0bvAS5yTHTwB5EGuIbmkeTQPySNYwsVOzmCWgZO7E2AcWsoDTilFRz
	HPUQg94eHs2C6YdLl+4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvepp-0005Xe-FN; Mon, 18 Feb 2019 09:03:33 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvepn-0005XX-Oy
 for linux-arm-kernel@bombadil.infradead.org; Mon, 18 Feb 2019 09:03:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yZ6N+kGZ5Pw5/vxuhiA+q4QZ4NOtPDkAadQRH2EBWdM=; b=gSfTmvcdIPHlcMqJuqBZHtYx+
 bnKCX+VO0eDO5k6Nmvg2sv2Ck2H0C3IYv4CTY3KO7b21cZcMMF+oXynMJDN19femm3J6H+C5HIrt+
 BvyBj3k1hzSDbzFLM6tBw/Ag8Ap6Oxrn/qEKr/shIyqD5cjm7RAVbbIJHvycn/LlbHgAvoBVskasF
 p0me5yGQ47wmwoP47KNlRuL8B98d6IpMTbv6t8pJQ2RHNPfGSVu5OeUnq2vcwvpzEgu+5QDd1UEJY
 Cvbtk+SoS8YUnWJGmuIqdpcNsJQPTOYghThgLV5zgjm6o3nEzEBYSxciZiv5x7UKULQQl0ffX4W/I
 pJrt4Gfmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvepi-0004ne-27; Mon, 18 Feb 2019 09:03:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id AE2652851C40E; Mon, 18 Feb 2019 10:03:22 +0100 (CET)
Date: Mon, 18 Feb 2019 10:03:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190218090322.GT32534@hirez.programming.kicks-ass.net>
References: <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190214101429.GD32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: dvlasenk@redhat.com, brgerst@gmail.com,
 Julien Thierry <julien.thierry@arm.com>, catalin.marinas@arm.com,
 jpoimboe@redhat.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, valentin.schneider@arm.com, mingo@redhat.com,
 james.morse@arm.com, luto@kernel.org, hpa@zytor.com, bp@alien8.de,
 tglx@linutronix.de, torvalds@linux-foundation.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



Subject: sched/x86: Save [ER]FLAGS on context switch
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Feb 14 10:30:52 CET 2019

Effectively reverts commit:

  2c7577a75837 ("sched/x86_64: Don't save flags on context switch")

Specifically because SMAP uses FLAGS.AC which invalidates the claim
that the kernel has clean flags.

In particular; while preemption from interrupt return is fine (the
IRET frame on the exception stack contains FLAGS) it breaks any code
that does synchonous scheduling, including preempt_enable().

This has become a significant issue ever since commit:

  5b24a7a2aa20 ("Add 'unsafe' user access functions for batched accesses")

provided for means of having 'normal' C code between STAC / CLAC,
exposing the FLAGS.AC state. So far this hasn't led to trouble,
however fix it before it comes apart.

Fixes: 5b24a7a2aa20 ("Add 'unsafe' user access functions for batched accesses")
Acked-by: Andy Lutomirski <luto@amacapital.net>
Reported-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_32.S        |    2 ++
 arch/x86/entry/entry_64.S        |    2 ++
 arch/x86/include/asm/switch_to.h |    1 +
 arch/x86/kernel/process_32.c     |    7 +++++++
 arch/x86/kernel/process_64.c     |    8 ++++++++
 5 files changed, 20 insertions(+)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -650,6 +650,7 @@ ENTRY(__switch_to_asm)
 	pushl	%ebx
 	pushl	%edi
 	pushl	%esi
+	pushfl
 
 	/* switch stack */
 	movl	%esp, TASK_threadsp(%eax)
@@ -672,6 +673,7 @@ ENTRY(__switch_to_asm)
 #endif
 
 	/* restore callee-saved registers */
+	popfl
 	popl	%esi
 	popl	%edi
 	popl	%ebx
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -291,6 +291,7 @@ ENTRY(__switch_to_asm)
 	pushq	%r13
 	pushq	%r14
 	pushq	%r15
+	pushfq
 
 	/* switch stack */
 	movq	%rsp, TASK_threadsp(%rdi)
@@ -313,6 +314,7 @@ ENTRY(__switch_to_asm)
 #endif
 
 	/* restore callee-saved registers */
+	popfq
 	popq	%r15
 	popq	%r14
 	popq	%r13
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -40,6 +40,7 @@ asmlinkage void ret_from_fork(void);
  * order of the fields must match the code in __switch_to_asm().
  */
 struct inactive_task_frame {
+	unsigned long flags;
 #ifdef CONFIG_X86_64
 	unsigned long r15;
 	unsigned long r14;
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -127,6 +127,13 @@ int copy_thread_tls(unsigned long clone_
 	struct task_struct *tsk;
 	int err;
 
+	/*
+	 * For a new task use the RESET flags value since there is no before.
+	 * All the status flags are zero; DF and all the system flags must also
+	 * be 0, specifically IF must be 0 because we context switch to the new
+	 * task with interrupts disabled.
+	 */
+	frame->flags = X86_EFLAGS_FIXED;
 	frame->bp = 0;
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -392,6 +392,14 @@ int copy_thread_tls(unsigned long clone_
 	childregs = task_pt_regs(p);
 	fork_frame = container_of(childregs, struct fork_frame, regs);
 	frame = &fork_frame->frame;
+
+	/*
+	 * For a new task use the RESET flags value since there is no before.
+	 * All the status flags are zero; DF and all the system flags must also
+	 * be 0, specifically IF must be 0 because we context switch to the new
+	 * task with interrupts disabled.
+	 */
+	frame->flags = X86_EFLAGS_FIXED;
 	frame->bp = 0;
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
