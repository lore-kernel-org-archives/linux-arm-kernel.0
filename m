Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B9AC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:21:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12D720868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nQ8KjExA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12D720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9GzzZyx+lgv7SWqMf0KtF1qc6GhkmdGx3NJYUBJMTPA=; b=nQ8KjExAtYvuEd
	5eotzBRsa3iedVMoBEPZJZ32Xm1bR73Lo03ySZdmolpf0friKe8sppvuhLYsj6tzJsWxrHnnjYGS6
	uJD4VggjK95iOZ1xeF9/zrRtNKoQ/+QoHP9hS402Vc5NJZIpwO/pfO/MmkUq/2znvYgHQ/PMZxiR/
	lqIhpGKy8TcjbR/qtOb3TXb1lwT/1N41HMsvC6/ZYpEqJa/2SqlFVDHyY0fysBGa8h3Mo6gnasnpu
	DjJ6vuSQYHOPFDIGbFtF5SQYq8j9Xbe5yvlNwndMY6hnGnkIE9QMKtgJrv4WXJTeNRMPVT44xU0jY
	z6UDbpq/bvUMfyJmKEJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSkbc-0008C1-Vx; Fri, 30 Nov 2018 15:21:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSkbS-0007wz-T2
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 15:21:17 +0000
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com
 [66.24.56.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9B40420868;
 Fri, 30 Nov 2018 15:21:03 +0000 (UTC)
Date: Fri, 30 Nov 2018 10:21:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 1/3] stackleak: mark stackleak_track_stack() as notrace
Message-ID: <20181130102102.041b8291@gandalf.local.home>
In-Reply-To: <20181130150859.27366-1-anders.roxell@linaro.org>
References: <20181130150859.27366-1-anders.roxell@linaro.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_072114_949035_FBABADD0 
X-CRM114-Status: GOOD (  14.86  )
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
Cc: keescook@chromium.org, Arnd Bergmann <arnd@arndb.de>,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 30 Nov 2018 16:08:59 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:

> Function graph tracing recurses into itself when stackleak is enabled,
> causing the ftrace graph selftest to run for up to 90 seconds and
> trigger the softlockup watchdog.
> 
> Breakpoint 2, ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:200
> 200             mcount_get_lr_addr        x0    //     pointer to function's saved lr
> (gdb) bt
> \#0  ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:200
> \#1  0xffffff80081d5280 in ftrace_caller () at ../arch/arm64/kernel/entry-ftrace.S:153
> \#2  0xffffff8008555484 in stackleak_track_stack () at ../kernel/stackleak.c:106
> \#3  0xffffff8008421ff8 in ftrace_ops_test (ops=0xffffff8009eaa840 <graph_ops>, ip=18446743524091297036, regs=<optimized out>) at ../kernel/trace/ftrace.c:1507
> \#4  0xffffff8008428770 in __ftrace_ops_list_func (regs=<optimized out>, ignored=<optimized out>, parent_ip=<optimized out>, ip=<optimized out>) at ../kernel/trace/ftrace.c:6286
> \#5  ftrace_ops_no_ops (ip=18446743524091297036, parent_ip=18446743524091242824) at ../kernel/trace/ftrace.c:6321
> \#6  0xffffff80081d5280 in ftrace_caller () at ../arch/arm64/kernel/entry-ftrace.S:153
> \#7  0xffffff800832fd10 in irq_find_mapping (domain=0xffffffc03fc4bc80, hwirq=27) at ../kernel/irq/irqdomain.c:876
> \#8  0xffffff800832294c in __handle_domain_irq (domain=0xffffffc03fc4bc80, hwirq=27, lookup=true, regs=0xffffff800814b840) at ../kernel/irq/irqdesc.c:650
> \#9  0xffffff80081d52b4 in ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:205
> 
> Rework so we mark stackleak_track_stack as notrace
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/stackleak.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index e42892926244..5de3bf596dd7 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -102,7 +102,7 @@ asmlinkage void stackleak_erase(void)
>  	current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
>  }
>  
> -void __used stackleak_track_stack(void)
> +void __used notrace stackleak_track_stack(void)
>  {
>  	/*
>  	 * N.B. stackleak_erase() fills the kernel stack with the poison value,


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
