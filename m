Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4949C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:24:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B059020868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D9HkurDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B059020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P7hc3eDScLGIeLwF6vsxDl9SWsXgJ6ivzlVbC+HjWII=; b=D9HkurDaAGOxua
	AItuneEXCuE9RUlZ7Nnfb1LYSBnay9UbHGhNH+TR3JSlFzAjqToLprRCQ/TyPQFGmyTcPJFy6AphN
	GrRboZldFYYFSzTHOV4N8Yf//qu0wTIenMsKwGw13x708IPLTbj30juX150/pYKRvkibhElWL3LPO
	1suRswACUIn4RbCCitZxMpIZuNkQHFRpnJUEZ04TEBMZRS8u8VN1To7WuE2SDeel00ybsSW3qiZxR
	rmpcVyuostUX5x0DufhmmvhmvBWY7yMmWaUQVg4AOA2mucx3IrV2tuIqpkPreAEwiPlTUW395wZNV
	VbGpG14hCknhyKZ7hsMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSkeF-00016D-R7; Fri, 30 Nov 2018 15:24:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSkeC-0000vC-1k
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 15:24:05 +0000
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com
 [66.24.56.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E997320868;
 Fri, 30 Nov 2018 15:23:52 +0000 (UTC)
Date: Fri, 30 Nov 2018 10:23:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 3/3] arm64: ftrace: add cond_resched() to func
 ftrace_make_(call|nop)
Message-ID: <20181130102351.61045b21@gandalf.local.home>
In-Reply-To: <20181130150956.27620-1-anders.roxell@linaro.org>
References: <20181130150956.27620-1-anders.roxell@linaro.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_072404_105392_097C620F 
X-CRM114-Status: GOOD (  16.94  )
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

On Fri, 30 Nov 2018 16:09:56 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:

> Both of those functions end up calling ftrace_modify_code(), which is
> expensive because it changes the page tables and flush caches.
> Microseconds add up because this is called in a loop for each dyn_ftrace
> record, and this triggers the softlockup watchdog unless we let it sleep
> occasionally.
> Rework so that we call cond_resched() before going into the
> ftrace_modify_code() function.
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I'm fine with this patch, but I'm not placing an ack on this patch
just because I don't know the repercussions of such a change. I'll let
you folks take full responsibility ;-)

-- Steve
 

> ---
>  arch/arm64/kernel/ftrace.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index de1a397d2d3f..9da38da58df7 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -130,6 +130,11 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  	old = aarch64_insn_gen_nop();
>  	new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
>  
> +	/* This function can take a long time when sanitizers are enabled, so
> +	 * lets make sure we allow RCU processing.
> +	 */
> +	cond_resched();
> +
>  	return ftrace_modify_code(pc, old, new, true);
>  }
>  
> @@ -188,6 +193,11 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>  
>  	new = aarch64_insn_gen_nop();
>  
> +	/* This function can take a long time when sanitizers are enabled, so
> +	 * lets make sure we allow RCU processing.
> +	 */
> +	cond_resched();
> +
>  	return ftrace_modify_code(pc, old, new, validate);
>  }
>  


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
