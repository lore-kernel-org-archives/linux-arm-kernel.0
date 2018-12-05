Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F23C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:54:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55B820661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VQTYgdqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55B820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6X189g4qYrYhoMLYzf+Ru0CQwnBXlqqUyQEmCVzCkdY=; b=VQTYgdqEAUuM8Z
	qn9zaWz0USyB3bunLtsLUWfYot3jgrwCv/wVQTBOT1M/oU4O9+Jb9D62TUhThU5Qfd/OsAnNpUu6F
	wgszxJvYmkX4SqeVX2LCK3R8V5Zd/MrKqutz0YtPnm6RcltDO/OZgcOd7J321p5AGLzqyxiTo79EJ
	ozcnMAQZt8+5C2MykW56vewYti0LFq4761rfeos/ut1HAfhDlUoWXiRzJkuYk5ANH9IJ4Sxu9JoVc
	FhjrcHMlkhl/VJ1DWf1I6Fx0doRaqN4myWGeljbJ4EWJF5S9J06ddkv+gGMftCzagTrXeKgC3YO32
	a/y2B83AXgFRoBB7vD+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUTtA-00073r-Fh; Wed, 05 Dec 2018 09:54:40 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUTt7-0006rF-Ar
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 09:54:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 276EC80D;
 Wed,  5 Dec 2018 01:54:26 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB5443F575;
 Wed,  5 Dec 2018 01:54:25 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 974C51AE0BA8; Wed,  5 Dec 2018 09:54:46 +0000 (GMT)
Date: Wed, 5 Dec 2018 09:54:46 +0000
From: Will Deacon <will.deacon@arm.com>
To: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2] tracing: add cond_resched to ftrace_replace_code()
Message-ID: <20181205095445.GA14317@arm.com>
References: <20181204192903.8193-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204192903.8193-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_015437_388074_C42943EB 
X-CRM114-Status: GOOD (  20.95  )
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
Cc: keescook@chromium.org, arnd@arndb.de, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anders, Steve,

On Tue, Dec 04, 2018 at 08:29:03PM +0100, Anders Roxell wrote:
> When running in qemu on an kernel built with allmodconfig and debug
> options (in particular kcov and ubsan) enabled, ftrace_replace_code
> function call take minutes. The ftrace selftest calls
> ftrace_replace_code to look >40000 through
> ftrace_make_call/ftrace_make_nop, and these end up calling
> __aarch64_insn_write/aarch64_insn_patch_text_nosync.
> 
> Microseconds add up because this is called in a loop for each dyn_ftrace
> record, and this triggers the softlockup watchdog unless we let it sleep
> occasionally.
> 
> Rework so that we call cond_resched() if !irqs_disabled() && !preempt_count().
> 
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  kernel/trace/ftrace.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c375e33239f7..7080eb464983 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2419,11 +2419,19 @@ void __weak ftrace_replace_code(int enable)
>  {
>  	struct dyn_ftrace *rec;
>  	struct ftrace_page *pg;
> +	bool schedulable;
>  	int failed;
>  
>  	if (unlikely(ftrace_disabled))
>  		return;
>  
> +	/*
> +	 * Some archs calls this function with interrupts or preemption
> +	 * disabled. However, for other archs that can preempt, this can cause
> +	 * an tremendous unneeded latency.
> +	 */
> +	schedulable = !irqs_disabled() && !preempt_count();

Is there a reason not to use preemptible() here?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
