Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4A8C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:54:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF68C21902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P9cqDfzj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ag1ilP4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF68C21902
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OiQExHsjEaiVCeommG7QEFcbF9YOAEnJWdsq1fgaVXM=; b=P9cqDfzjq4Hrae
	oL5zYImLGbpoUi6lw4Aim4LOmMzWQbuXi4sCb7yQi0eWEFq+EvTArYT70lxdr7UeS30i1w4I62uHG
	YgjCJPQ9PhDYvmB89GklqIU2k/RI4d0yFRFOZRV7KuhzOSjMjvxYAYXUy38+LPkODjh7FY80K6kXL
	kMMce4YlZqpmwee0x/57/+OF4oJnLi9zRoveRP94ABboK+RVCMhoqt10TYoHH8QHafSZQOTW+SVHv
	mQudMX5Vhy90mANtQ++A39VwG5IF++sBHQK/CTAoG+0etzISX2IlZQDW8lBNVu3OpcuA2pcM6Vqlr
	QxBWTjwLoWenkf8MHRYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtzfb-0008V9-1F; Wed, 13 Feb 2019 18:54:07 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtzfZ-0008V2-PI
 for linux-arm-kernel@bombadil.infradead.org; Wed, 13 Feb 2019 18:54:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EY2Jm+hb93wPVb/zC2IoO0q6HYpZ7+FfGU0VEP3p0RM=; b=ag1ilP4nIjXF7oiyLFio3P0J4
 /xgv1u9uTu1ePX+5g4dMLDutu6cGdBuR+oOWGWlfC/bLFj8fy4mn+enc4dXqUvqXWNFh/cSQh5oOT
 J7ERyU2e8b76ar7ZFtfwBYjdKI23jUhR8zu0zOyN30JsWE0WDe7LHhe4CpHLZuH8liD0qR+BNIGkl
 tiNMK0SYDsCY17ubU+XOCC5CkrQI3BiH73FYRRc+MijdPpzwgUmORI6Mgr04NkdLpJj4u+058c/Ak
 FhejqYFaaPYBWlKdFTQIyLDGQ2Mm8oiE/qQEBINZoUs12ldIh1xNgWKWDfskQKO5FsfwcFgTO+tLB
 BC3b95oLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtzfV-0005LJ-Te; Wed, 13 Feb 2019 18:54:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 52976202CEF99; Wed, 13 Feb 2019 19:54:00 +0100 (CET)
Date: Wed, 13 Feb 2019 19:54:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213185400.GR32534@hirez.programming.kicks-ass.net>
References: <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
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
Cc: dvlasenk@redhat.com, brgerst@gmail.com, catalin.marinas@arm.com,
 jpoimboe@redhat.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, valentin.schneider@arm.com, mingo@redhat.com,
 james.morse@arm.com, luto@kernel.org, hpa@zytor.com, bp@alien8.de,
 tglx@linutronix.de, torvalds@linux-foundation.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 04:45:32PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 13, 2019 at 03:41:45PM +0100, Peter Zijlstra wrote:
> > On Wed, Feb 13, 2019 at 02:39:22PM +0000, Julien Thierry wrote:
> > > Hi Peter,
> > > 
> > > On 13/02/2019 14:25, Peter Zijlstra wrote:
> > > > On Wed, Feb 13, 2019 at 02:00:26PM +0000, Will Deacon wrote:
> > > >> The difference is because getting preempted in the sequence above is
> > > >> triggered off the back of an interrupt. On arm64, and I think also on x86,
> > > >> the user access state (SMAP or PAN) is saved and restored across exceptions
> > > >> but not across context switch.
> > > > 
> > > > A quick reading of the SDM seems to suggest the SMAP state is part of
> > > > EFLAGS, which is context switched just fine AFAIK.
> > > > 
> > > I fail to see where this is happening when looking at the switch_to()
> > > logic in x86_64.
> > 
> > Yeah, me too.. we obviously preserve EFLAGS for user context, but for
> > kernel-kernel switches we do not seem to preserve it :-(
> 
> So I dug around the context switch code a little, and I think we lost it
> here:
> 
>   0100301bfdf5 ("sched/x86: Rewrite the switch_to() code")
> 
> Before that, x86_64 switch_to() read like (much simplified):
> 
> 	asm volatile ( /* do RSP twiddle */
> 	  : /* output */
> 	  : /* input */
> 	  : "memory", "cc", .... "flags");
> 
> (see __EXTRA_CLOBBER)
> 
> Which I suppose means that GCC generates the PUSHF/POPF to preserve the
> EFLAGS, since we mark those explicitly clobbered.
> 
> Before that:
> 
>   f05e798ad4c0 ("Disintegrate asm/system.h for X86")
> 
> We had explicit PUSHF / POPF in SAVE_CONTEXT / RESTORE_CONTEXT resp.
> 
> Now I cannot see how the current code preserves EFLAGS (if indeed it
> does), and the changelog doesn't mention this change _AT_ALL_.
> 
> 
> For a little bit of context; it turns out that user_access_begin() /
> user_access_end() sets EFLAGS.AC and scheduling in between there wrecks
> that because we're apparently not saving that anymore.
> 
> Now, I'm tempted to add the PUSHF / POPF right back because of this, but
> first I suppose we need to figure out if that change was on purpose and
> why that went missing from the Changelog.

Just for giggles; the below patch seems to boot.

---
 arch/x86/entry/entry_32.S        | 2 ++
 arch/x86/entry/entry_64.S        | 2 ++
 arch/x86/include/asm/switch_to.h | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d309f30cf7af..5fc76b755510 100644
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
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f0efdb7b629..4fe27b67d7e2 100644
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
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index 7cf1a270d891..157149d4129c 100644
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

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
