Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB06C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:12:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BBC52082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A5DlEPWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BBC52082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4jGZ16k9kkhxcZbiZcyrIpkcGnErnFaicWuuz0yAz9Y=; b=A5DlEPWt8EOA49
	PTxqXtJ+j9r8sbEzOBWyJ/613U1gVAL6jFKL54LV4RAC/X6nFgpXcHm92/ScaNHUshfPReI2GZwcf
	LkJZ+PibN6/pgYiUKtGhS5iynwXYN3Dmqpwl8SFVYSm1fgTaIofyPKro3aqoaLSROg8KAt7IdcAia
	rdXJg2XWLTyahX/zoCAYVSp/1PFze5cRIC7dOP+fhjkWFoOcGgq8QeiHaqayh5rjC4XlooH9E4AZS
	gg6ifCrp7DGehk6QFAW366W7yUG/p9OPHbJYsQRyh+plDOHhXaVGXSUM5SqSKWxbVdHAsL0033NDE
	SaEengUJehoAb79DZ9sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU8d2-0006Uz-Tv; Tue, 04 Dec 2018 11:12:36 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8cz-0006US-Pv
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:12:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FF1AA78;
 Tue,  4 Dec 2018 03:12:23 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D31DD3F59C;
 Tue,  4 Dec 2018 03:12:22 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 288E31AE10A5; Tue,  4 Dec 2018 11:12:43 +0000 (GMT)
Date: Tue, 4 Dec 2018 11:12:43 +0000
From: Will Deacon <will.deacon@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/3] arm64: ftrace: add cond_resched() to func
 ftrace_make_(call|nop)
Message-ID: <20181204111242.GA32596@arm.com>
References: <20181130150956.27620-1-anders.roxell@linaro.org>
 <20181203192228.GC29028@arm.com>
 <CAK8P3a2gekEqUuvsC-_+ijhiqqff2bK-s2wQfkjn7z-HtNnMDQ@mail.gmail.com>
 <20181204005012.11f73df9@vmware.local.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204005012.11f73df9@vmware.local.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_031233_849911_13EAFE9F 
X-CRM114-Status: GOOD (  34.75  )
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
Cc: Anders Roxell <anders.roxell@linaro.org>, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Steve, Arnd,

On Tue, Dec 04, 2018 at 12:50:12AM -0500, Steven Rostedt wrote:
> On Mon, 3 Dec 2018 22:51:52 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Dec 3, 2018 at 8:22 PM Will Deacon <will.deacon@arm.com> wrote:
> > > On Fri, Nov 30, 2018 at 04:09:56PM +0100, Anders Roxell wrote:  
> > > > Both of those functions end up calling ftrace_modify_code(), which is
> > > > expensive because it changes the page tables and flush caches.
> > > > Microseconds add up because this is called in a loop for each dyn_ftrace
> > > > record, and this triggers the softlockup watchdog unless we let it sleep
> > > > occasionally.
> > > > Rework so that we call cond_resched() before going into the
> > > > ftrace_modify_code() function.
> > > >
> > > > Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > > ---
> > > >  arch/arm64/kernel/ftrace.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)  
> > >
> > > It sounds like you're running into issues with the existing code, but I'd
> > > like to understand a bit more about exactly what you're seeing. Which part
> > > of the ftrace patching is proving to be expensive?
> > >
> > > The page table manipulation only happens once per module when using PLTs,
> > > and the cache maintenance is just a single line per patch site without an
> > > IPI.
> > >
> > > Is it the loop in ftrace_replace_code() that is causing the hassle?  
> > 
> > Yes: with an allmodconfig kernel, the ftrace selftest calls ftrace_replace_code
> > to look >40000 through ftrace_make_call/ftrace_make_nop, and these
> > end up calling

Ok, 40000 invocations would do it!

> > static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
> > {
> >         void *waddr = addr;
> >         unsigned long flags = 0;
> >         int ret;
> > 
> >         raw_spin_lock_irqsave(&patch_lock, flags);
> >         waddr = patch_map(addr, FIX_TEXT_POKE0);
> > 
> >         ret = probe_kernel_write(waddr, &insn, AARCH64_INSN_SIZE);
> > 
> >         patch_unmap(FIX_TEXT_POKE0);
> >         raw_spin_unlock_irqrestore(&patch_lock, flags);
> > 
> >         return ret;
> > }
> > int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
> > {
> >         u32 *tp = addr;
> >         int ret;
> > 
> >         /* A64 instructions must be word aligned */
> >         if ((uintptr_t)tp & 0x3)
> >                 return -EINVAL;
> > 
> >         ret = aarch64_insn_write(tp, insn);
> >         if (ret == 0)
> >                 __flush_icache_range((uintptr_t)tp,
> >                                      (uintptr_t)tp + AARCH64_INSN_SIZE);
> > 
> >         return ret;
> > }
> > 
> > which seems to be where the main cost is. This is with inside of
> > qemu, and with lots of debugging options (in particular
> > kcov and ubsan) enabled, that make each function call
> > more expensive.
> 
> I was thinking more about this. Would something like this work?
> 
> -- Steve
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 8ef9fc226037..42e89397778b 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2393,11 +2393,14 @@ void __weak ftrace_replace_code(int enable)
>  {
>  	struct dyn_ftrace *rec;
>  	struct ftrace_page *pg;
> +	bool schedulable;
>  	int failed;
>  
>  	if (unlikely(ftrace_disabled))
>  		return;
>  
> +	schedulable = !irqs_disabled() & !preempt_count();

Looks suspiciously like a bitwise preemptible() to me!

> +
>  	do_for_each_ftrace_rec(pg, rec) {
>  
>  		if (rec->flags & FTRACE_FL_DISABLED)
> @@ -2409,6 +2412,8 @@ void __weak ftrace_replace_code(int enable)
>  			/* Stop processing */
>  			return;
>  		}
> +		if (schedulable)
> +			cond_resched();
>  	} while_for_each_ftrace_rec();
>  }

If this solves the problem in core code, them I'm all for it. Otherwise, I
was thinking of rolling our own ftrace_replace_code() for arm64, but that's
going to involve a fair amount of duplication.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
