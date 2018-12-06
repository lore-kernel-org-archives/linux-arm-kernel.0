Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED992C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:06:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF59920838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Aif9exgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF59920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k2lCB8s6w1Q4EN9+U0Hb1toFsHyjlnRAjwRRrNyAQ3s=; b=Aif9exgGZ04sQF
	vD6pXMdcpIziaES1073yR92VujlJ3W5L0sjnTBX83MiNmXJPFW+pCLRLXiVCzspsxaS+la2WkJGkS
	wcAihzoabrO0SxJgL753FEN810qSHFm4sEp/t7y9LN/O23tkCBXlk81ULYD/vpAAktUeMzkp7hjBt
	mMafW4YNuBMrdZ8OhMGgLlke3qC6spV5VgxmcnemDiWLVNZsaVdA6abCresTJL1USwHU7SaoFtzwH
	ZbA+pZg4xkQZ1Sn4gPGmdO8QD8DuOlMrw6bDVjiQGeVW+dza1zYopdJYE+oxmN9mHSr7F1aQnD4lH
	fZedbgR23To4xPpBrtPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUwAl-0008WR-2c; Thu, 06 Dec 2018 16:06:43 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwAd-0008Vl-G2
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:06:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11E7180D;
 Thu,  6 Dec 2018 08:06:25 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D644E3F59C;
 Thu,  6 Dec 2018 08:06:24 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id F052C1AE0BD1; Thu,  6 Dec 2018 16:06:45 +0000 (GMT)
Date: Thu, 6 Dec 2018 16:06:45 +0000
From: Will Deacon <will.deacon@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] arm64: ftrace: Set FTRACE_SCHEDULABLE before
 ftrace_modify_all_code()
Message-ID: <20181206160645.GA4728@arm.com>
References: <20181205174852.435233070@goodmis.org>
 <20181205183304.000714627@goodmis.org>
 <20181206132007.GB27744@arm.com>
 <20181206105914.7a29efa9@vmware.local.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206105914.7a29efa9@vmware.local.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_080635_535757_B107F858 
X-CRM114-Status: GOOD (  26.05  )
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
Cc: Anders Roxell <anders.roxell@linaro.org>, keescook@chromium.org,
 arnd@arndb.de, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 10:59:14AM -0500, Steven Rostedt wrote:
> On Thu, 6 Dec 2018 13:20:07 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> 
> > On Wed, Dec 05, 2018 at 12:48:54PM -0500, Steven Rostedt wrote:
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > 
> > > It has been reported that ftrace_replace_code() which is called by
> > > ftrace_modify_all_code() can cause a soft lockup warning for an
> > > allmodconfig kernel. This is because all the debug options enabled
> > > causes the loop in ftrace_replace_code() (which loops over all the
> > > functions being enabled where there can be 10s of thousands), is too
> > > slow, and never schedules out.
> > > 
> > > To solve this, setting FTRACE_SCHEDULABLE to the command passed into
> > > ftrace_replace_code() will make it call cond_resched() in the loop,
> > > which prevents the soft lockup warning from triggering.
> > > 
> > > Link: http://lkml.kernel.org/r/20181204192903.8193-1-anders.roxell@linaro.org
> > > 
> > > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > ---
> > >  arch/arm64/kernel/ftrace.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > > index 57e962290df3..9a8de0a79f97 100644
> > > --- a/arch/arm64/kernel/ftrace.c
> > > +++ b/arch/arm64/kernel/ftrace.c
> > > @@ -193,6 +193,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> > >  
> > >  void arch_ftrace_update_code(int command)
> > >  {
> > > +	command |= FTRACE_SCHEDULABLE;
> > >  	ftrace_modify_all_code(command);
> > >  }  
> > 
> > Bikeshed: I'd probably go for FTRACE_MAY_SLEEP, but I'm not going to die
> > on that hill so...
> 
> I like bike sheds. Hmm, it's not too late to change this. Perhaps I
> will.
> 
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Thanks!
> 
> If I decide to change the name to MAY_SLEEP, I assume I can still keep
> your Acked-by.

Of course!

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
