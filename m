Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D68C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:34:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8308B2192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l7SgmEla";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gJ8+B91g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8308B2192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X5Au4bw2wMPbmZciS852T83LqvNTF8nzfpF8fZAo3GY=; b=l7SgmElaeF/8Az
	Qj9zljkVjZTTiAfV2w/OTja4cvQhZO7f4AN/p8nO44tjaNGx18uoP48YXDk9T+hykUSZFIY8M15Rs
	JvYPXZ1h2jL1hR4fu3RwCUIhLhI0ZPG0Ho5gU64Cq1chzOeeNkpGeqagwd1GOFFeuntl+hu1GFwzC
	M1ga4os6kGrxGYYLFvPTe896ffMlfqyGhkwiIGjSMNT/fkB1u+ycE3tuqri8Y6edtkr0dakv+laGg
	dRDZEVXLpUMTFUTEx/yzMRUKuxrpLYsq/5F1DIZSkuu3UkvuZ9oHghPQH6IUSNtWUuSzyYrN0d1bV
	QuYS4vjqM6PUeIvwd2hQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gumzx-0000lm-Al; Fri, 15 Feb 2019 23:34:25 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gumzv-0000lg-Ah
 for linux-arm-kernel@bombadil.infradead.org; Fri, 15 Feb 2019 23:34:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nVQLj5CzH3ARZ3awrPXkfkuEJlM5GS3tZKINsGe2czY=; b=gJ8+B91gvkOOjVS0jqcZHqSRm
 EEjhdJngH8wAM5ZFeL0iVeyEHG5ihfrSwXBIz7Kwl8wmA4niNgGvFsgjEfgbEfXidf6VVnfJuHnRR
 jTPw1oC6FQHAk3PkbVG6BI3CH+FnGZ/z1VzlCixVBAmMeYyM/8negH1SqDNbaN4JD3SAwYEZpU95U
 B5kpuwSafu3pC9RJlesJvNNQtakNM9hTeorcEgizT7AWrVEApaxHir3X3n4fyPkV5JKsY6eTdhEGb
 vu40uMaKQL7HMoHnII7OL+qznN5UNW+UhBh7a6R3/6ojfP92gVmstPkhzvr8Pf1lWrueE76hdE38T
 +jecRHt3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gumzp-0004Ob-0h; Fri, 15 Feb 2019 23:34:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 53617201A8972; Sat, 16 Feb 2019 00:34:14 +0100 (CET)
Date: Sat, 16 Feb 2019 00:34:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190215233414.GS32534@hirez.programming.kicks-ass.net>
References: <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <CAMzpN2hg+CY+AuF=BtetS2HrMQYdxhBZL9QMvJX4LjAs7vwwAw@mail.gmail.com>
 <20190214193432.GR32477@hirez.programming.kicks-ass.net>
 <CAHk-=wgj9yUAhTz8n__s-gHnHJw4fznBbLAfne4EO4n6RukgcA@mail.gmail.com>
 <20190215174034.GP32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190215174034.GP32494@hirez.programming.kicks-ass.net>
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Julien Thierry <julien.thierry@arm.com>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, valentin.schneider@arm.com,
 Ingo Molnar <mingo@redhat.com>, James Morse <james.morse@arm.com>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 06:40:34PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 15, 2019 at 09:18:00AM -0800, Linus Torvalds wrote:
> > On Thu, Feb 14, 2019 at 11:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Something like the below, right?
> > >
> > > +       frame->flags = 0;
> > > +       frame->flags = 0;
> > 
> > Those are not valid flag values.
> > 
> > Can you popf them? Yes.
> > 
> > Do they make sense? No.
> > 
> > It has the IF flag clear, for example. Is that intentional? If it is,
> 
> Uhmm. yeah, that's bonkers. We should have interrupts disabled here.
> I'll go read up on the eflags and figure out what they _should_ be right
> about there.

I misread (I'm forever confused about what way around IF goes), but you
said it right; IF=0 is interrupts disabled and we very much have that in
the middle of context switch.

(just for giggles I set IF for the initial flags value; and it comes
unstuck _real_ quick)

Now, EFLAGS bit 1 is supposedly always 1, but it really doesn't seem to
matter for POPF.

I went through the other flags, and aside from VIP/VIF (I've no clue),
they looks like 0 should be just fine.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
