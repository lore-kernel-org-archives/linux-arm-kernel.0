Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2BFC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:55:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F65E20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F/MzHhdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F65E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zfTdUum4obKbzwMG6272yMmjw/7iRYUTz+bbfJCC5Co=; b=F/MzHhdXIyVXyI
	3UUHb2x3Kh4IGOa2vDKeZlbLlf/ymfsxJZNpaWnA/v4Po8FdZduhmid5vk1052XWYNBQTL2zExPsV
	etn2sIo8PvHT+XUcbkGUDCdrNLVJYHCBhYqKiaZlHOUSD6IeoVHQBWyi6edAOBYrZMLM+NbyNbhi+
	awBxY2TapudQVF+rmupxF8O2/QOsQtgY0JdWzfRugXiP4q9CXTpkxlr/Y18y6tNUGbTAFCrlF5AHg
	8ULt8DJzK3Krfugqs7/momZdGskGlvCg+3Aq4c9E5HbrvFirij8HqPAPi6u0ZXXT+K9mjURhqbOWK
	H3f5E0yp6QTqr6B1ajhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUklO-0001tp-WC; Thu, 06 Dec 2018 03:55:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUklH-0001fH-Au
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 03:55:44 +0000
Received: from vmware.local.home (unknown [184.48.106.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5292720645;
 Thu,  6 Dec 2018 03:55:28 +0000 (UTC)
Date: Wed, 5 Dec 2018 22:55:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [for-next][PATCH 05/30] arm64: function_graph: Remove use of
 FTRACE_NOTRACE_DEPTH
Message-ID: <20181205225526.470a6e42@vmware.local.home>
In-Reply-To: <20181205234829.164618323@goodmis.org>
References: <20181205234749.372720574@goodmis.org>
 <20181205234829.164618323@goodmis.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_195539_818268_83A6B86B 
X-CRM114-Status: GOOD (  16.31  )
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
Cc: Tom Zanussi <zanussi@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "Joel Fernandes \(Google\)" <joel@joelfernandes.org>,
 Namhyung Kim <namhyung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 05 Dec 2018 18:47:54 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Functions in the set_graph_notrace no longer subtract FTRACE_NOTRACE_DEPTH
> from curr_ret_stack, as that is now implemented via the trace_recursion
> flags. Access to curr_ret_stack no longer needs to worry about checking for
> this. curr_ret_stack is still initialized to -1, when there's not a shadow
> stack allocated.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

I haven't pushed this to Linux next yet. I tested the entire tree as
well as crossed compiled it against arm64.

Can you give me an ack for this patch?

Thanks!

-- Steve

> Cc: linux-arm-kernel@lists.infradead.org
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  arch/arm64/kernel/stacktrace.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 4989f7ea1e59..7723dadf25be 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -61,9 +61,6 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
>  			(frame->pc == (unsigned long)return_to_handler)) {
>  		if (WARN_ON_ONCE(frame->graph == -1))
>  			return -EINVAL;
> -		if (frame->graph < -1)
> -			frame->graph += FTRACE_NOTRACE_DEPTH;
> -
>  		/*
>  		 * This is a case where function graph tracer has
>  		 * modified a return address (LR) in a stack frame


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
