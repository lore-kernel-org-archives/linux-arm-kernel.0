Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9B8C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:02:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F61C2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cPwbhEzk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibhyqSsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F61C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:From:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qUvxYIZuV1ZOoKNbz5C2xKxleOH+XvhBZ74whs2QKrg=; b=cPwbhEzkFqiCIn
	ketKEPxIuLq6BKpdSHPq0leDCLYQMr4FHog6cLDuD+c0phg2RbD8zF+qkUslslyfEK/DXQzXpRaL1
	WvFyoaaKywBJX2XCp9AtMa1OL6lue8nvf1cAtkifzEOhIGTbD5ZOSUIYJR7Ljde1OuQfMZaevTZjN
	DGThHLXeZf3pTihk4O6BBHwCri34nSBMfQrj0m4FWIt21iBL/ANAwUoX1l8AFjMzgQUAZa3YpLDfN
	LYe45db2JyQW9gbe4uiI97NMB4He6OtmUY46B5n2uKsU6jzmCmo3UQBozyvb80SDr0qICpmwSWmGO
	TsezHvOm7iINQCPLgkZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlzG-0006jN-6E; Mon, 03 Dec 2018 11:02:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlzC-0006ir-CN
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 11:02:00 +0000
Received: from localhost (unknown [62.119.166.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B5EE9214D9;
 Mon,  3 Dec 2018 11:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543834906;
 bh=9TsCLeAsgRjzDwsqV/KTciIGfX8aqFMDgVpxeQUs5KA=;
 h=Subject:To:Cc:From:Date:From;
 b=ibhyqSsTeTVzLncZgtWd0yaKgtgapw6ypqTdhA1NEMr8+Hi08QiTxBbyeRQpafOje
 DovTgwnKUCrouMvKcs79X3NiJWalR/quA/ie8CpIl8MOGSG0CMBE2oIZNWl41VWYsa
 EM655i+nvBoznGyAnVS2iIU8hokKC4Ts7gPI8E7U=
Subject: Patch "arm64: function_graph: Simplify with function_graph_enter()"
 has been added to the 4.19-stable tree
To: catalin.marinas@arm.com, gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org, rostedt@goodmis.org,
 stable@kernel.org, will.deacon@arm.com
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Dec 2018 12:00:11 +0100
Message-ID: <154383481115995@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_030158_453455_F9C6685A 
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

to the 4.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     arm64-function_graph-simplify-with-function_graph_enter.patch
and it can be found in the queue-4.19 subdirectory.

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
@@ -216,8 +216,6 @@ void prepare_ftrace_return(unsigned long
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
 	unsigned long old;
-	struct ftrace_graph_ent trace;
-	int err;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
@@ -229,18 +227,7 @@ void prepare_ftrace_return(unsigned long
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

queue-4.19/function_graph-create-function_graph_enter-to-consolidate-architecture-code.patch
queue-4.19/sh-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/function_graph-move-return-callback-before-update-of-curr_ret_stack.patch
queue-4.19/nds32-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/function_graph-use-new-curr_ret_depth-to-manage-depth-instead-of-curr_ret_stack.patch
queue-4.19/sparc-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/parisc-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/x86-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/powerpc-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/function_graph-reverse-the-order-of-pushing-the-ret_stack-and-the-callback.patch
queue-4.19/arm-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/mips-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/function_graph-make-ftrace_push_return_trace-static.patch
queue-4.19/arm64-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/riscv-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/s390-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/microblaze-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/function_graph-have-profiler-use-curr_ret_stack-and-not-depth.patch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
