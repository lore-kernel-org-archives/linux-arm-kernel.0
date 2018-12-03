Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5AEC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:04:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5EF214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QspL8gun";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAHhrRdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5EF214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:From:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yMJuV6vALEtQEVvXj+/Uo9WLcCIhXzEjqCEXxNRM3c0=; b=QspL8gun7edcVA
	BOLBduhv86hNPaNqCVUlgZH48PVxu7z+GAYLskwKLaQiLDelVo3frb1ETVqSvPvhm3x2DzpcGomLJ
	u4xkZzxOzNZh4ezHXPxclsYKNAYHxUwKMBjWeWS5BVHaT31fgPTxnwu1W46nNjta1vi8ZGXWwbyuq
	gxB2q0ryJTvhQQsgAXmU/b5VZMrpbZTTMG9lmM6uyo5+eDvhC+99qHOABRLPuiA+NCOsJA8xKj6BD
	IRJ0chhGPTydtEzIDQmtFmcEX+26l3sGlrcYvrpTVE2QuWAmK/Ug3Valc47zMB2feX+vhoDSDEPFq
	DexJCt9vuDB4i/4jiAZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTm1U-0007UO-Rd; Mon, 03 Dec 2018 11:04:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTm1R-0007Tm-0P
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 11:04:19 +0000
Received: from localhost (unknown [62.119.166.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5AEFA214C1;
 Mon,  3 Dec 2018 11:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543835046;
 bh=daTBcwl39wwQBXBkFyo+09FTbQLAU7lPNv1bGhpJzpM=;
 h=Subject:To:Cc:From:Date:From;
 b=fAHhrRdkVL6mCziZza9L4xHx7d6umk4HhjDGeTDtfUKenAjmaZbD47S2Tdb2jtP+c
 VtmVcNUBqRhq3O/8q9V6nqfkDmzYcWYX8Hl/s/cdKhJpb+iDxNkMr/WV59F5N3NVZ7
 ISMn9tnH96qbX3QUw7dDkbQvWgFddY0218/sKeEo=
Subject: Patch "arm64: function_graph: Simplify with function_graph_enter()"
 has been added to the 4.9-stable tree
To: catalin.marinas@arm.com, gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org, rostedt@goodmis.org,
 stable@kernel.org, will.deacon@arm.com
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Dec 2018 12:02:22 +0100
Message-ID: <154383494215123@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_030417_080858_0391780F 
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
Cc: stable-commits@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


This is a note to let you know that I've just added the patch titled

    arm64: function_graph: Simplify with function_graph_enter()

to the 4.9-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     arm64-function_graph-simplify-with-function_graph_enter.patch
and it can be found in the queue-4.9 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 01e0ab2c4ff12358f15a856fd1a7bbea0670972b Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Sun, 18 Nov 2018 17:21:51 -0500
Subject: arm64: function_graph: Simplify with function_graph_enter()

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 01e0ab2c4ff12358f15a856fd1a7bbea0670972b upstream.

The function_graph_enter() function does the work of calling the function
graph hook function and the management of the shadow stack, simplifying the
work done in the architecture dependent prepare_ftrace_return().

Have arm64 use the new code, and remove the shadow stack management as well as
having to set up the trace structure.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Acked-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/ftrace.c |   15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -117,8 +117,6 @@ void prepare_ftrace_return(unsigned long
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
 	unsigned long old;
-	struct ftrace_graph_ent trace;
-	int err;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
@@ -130,18 +128,7 @@ void prepare_ftrace_return(unsigned long
 	 */
 	old = *parent;
 
-	trace.func = self_addr;
-	trace.depth = current->curr_ret_stack + 1;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
-		return;
-
-	err = ftrace_push_return_trace(old, self_addr, &trace.depth,
-				       frame_pointer, NULL);
-	if (err == -EBUSY)
-		return;
-	else
+	if (!function_graph_enter(old, self_addr, frame_pointer, NULL))
 		*parent = return_hooker;
 }
 


Patches currently in stable-queue which might be from rostedt@goodmis.org are

queue-4.9/function_graph-create-function_graph_enter-to-consolidate-architecture-code.patch
queue-4.9/sh-function_graph-simplify-with-function_graph_enter.patch
queue-4.9/function_graph-move-return-callback-before-update-of-curr_ret_stack.patch
queue-4.9/function_graph-use-new-curr_ret_depth-to-manage-depth-instead-of-curr_ret_stack.patch
queue-4.9/sparc-function_graph-simplify-with-function_graph_enter.patch
queue-4.9/parisc-function_graph-simplify-with-function_graph_enter.patch
queue-4.9/x86-function_graph-simplify-with-function_graph_enter.patch
queue-4.9/function_graph-reverse-the-order-of-pushing-the-ret_stack-and-the-callback.patch
queue-4.9/arm-function_graph-simplify-with-function_graph_enter.patch
queue-4.9/function_graph-make-ftrace_push_return_trace-static.patch
queue-4.9/arm64-function_graph-simplify-with-function_graph_enter.patch
queue-4.9/s390-function_graph-simplify-with-function_graph_enter.patch
queue-4.9/microblaze-function_graph-simplify-with-function_graph_enter.patch
queue-4.9/function_graph-have-profiler-use-curr_ret_stack-and-not-depth.patch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
