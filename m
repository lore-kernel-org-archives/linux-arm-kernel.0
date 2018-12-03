Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD7CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:02:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8D1214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HjcoaT4+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1nf9zR7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8D1214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:From:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ENcTkjWZxTPH0PhvYfzNDFhjzry/7bzG7bFQrNsRrIs=; b=HjcoaT4+GyIRNu
	F4GoRnhDf2inIao64TnTcjJFDxF6cf1hGFXJfmO6gWSyoa52v3I+yXB88LlTPIMBFowoAQekHqHKS
	TIlQ60m6eIGeIZgFfccHQr7/E8wnevtWsiuHxuDac5wqtL4q6vYAOW/JjzfFeXhVwNOLPCEre0WHL
	9ERsza2o3iuRbQhpMe5XqfC7fTmRQLlVLG7CelZIeYOLaJLAYwpK8TGQ2jFGXZEA6dHCG1pGE1skR
	ZhAYVtv5fc2MtxburffphvNH55YEGblZn8PWjWmB1CBS6k2siI7bewIVMsVoIiUWAKDrS/U4cr/Sl
	VIegpLhlXFIxS9Aywu7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTm00-000762-DC; Mon, 03 Dec 2018 11:02:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlzv-00075M-DX
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 11:02:46 +0000
Received: from localhost (unknown [62.119.166.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 55B532147C;
 Mon,  3 Dec 2018 11:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543834953;
 bh=QAfAM0s0McS0KYIfdEbR93eah03/PLBFokfXnTuRodA=;
 h=Subject:To:Cc:From:Date:From;
 b=1nf9zR7UkcxdhPjCR3tPet74LI8Bqje68NBt8s1L6IqVHOz/OGCsesXdCZaWSH3Cr
 60pa8OUVtsW73KkxniNrcCOYY5YIDffzxf6yUWkZiTt9iAu6xJM3wnOX8N3upOfct/
 ZAcez/a2UUW9nNPwcLZS2a1x53DjnEyRaQ9x//CU=
Subject: Patch "ARM: function_graph: Simplify with function_graph_enter()" has
 been added to the 4.19-stable tree
To: gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
 linux@armlinux.org.uk, mhiramat@kernel.org, rostedt@goodmis.org,
 stable@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Dec 2018 12:00:11 +0100
Message-ID: <154383481176225@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_030243_489327_A615A867 
X-CRM114-Status: GOOD (  12.90  )
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

    ARM: function_graph: Simplify with function_graph_enter()

to the 4.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     arm-function_graph-simplify-with-function_graph_enter.patch
and it can be found in the queue-4.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From f1f5b14afd7cce39e6a9b25c685e1ea34c231096 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Sun, 18 Nov 2018 17:19:26 -0500
Subject: ARM: function_graph: Simplify with function_graph_enter()

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit f1f5b14afd7cce39e6a9b25c685e1ea34c231096 upstream.

The function_graph_enter() function does the work of calling the function
graph hook function and the management of the shadow stack, simplifying the
work done in the architecture dependent prepare_ftrace_return().

Have ARM use the new code, and remove the shadow stack management as well as
having to set up the trace structure.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/kernel/ftrace.c |   17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -227,9 +227,7 @@ void prepare_ftrace_return(unsigned long
 			   unsigned long frame_pointer)
 {
 	unsigned long return_hooker = (unsigned long) &return_to_handler;
-	struct ftrace_graph_ent trace;
 	unsigned long old;
-	int err;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
@@ -237,21 +235,8 @@ void prepare_ftrace_return(unsigned long
 	old = *parent;
 	*parent = return_hooker;
 
-	trace.func = self_addr;
-	trace.depth = current->curr_ret_stack + 1;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace)) {
+	if (function_graph_enter(old, self_addr, frame_pointer, NULL))
 		*parent = old;
-		return;
-	}
-
-	err = ftrace_push_return_trace(old, self_addr, &trace.depth,
-				       frame_pointer, NULL);
-	if (err == -EBUSY) {
-		*parent = old;
-		return;
-	}
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE


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
