Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541E8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:40:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E52E206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JJiI/5EG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxdHCejo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E52E206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PBwTPd7gelXw5SIKTVGtYtEI1w2Xtvi1Pj+2wbWU1Fs=; b=JJiI/5EGysoWw7
	KOHvvbJ+1BVDVERAqTcBZsl6tEFi3N1Aq4I4oAFIX5Rv27KpmS2b1Kx7dgPzOqdsckZtyDmMGEqdZ
	8LIRNkEsCbPNeTXkXniYa4u/0D6pfWaDmoz6h0kqs5IRC1ooqG2NQfW0fFdl56WEwTTjF11nj+lML
	MWG/5eU6Ommetz+I55UA0gZn0Epb6Sb/Qn8+KxMQSfDL2C80iMXZhEOQ7RQQNftW8YFRNmqHxOZuk
	yQYL54jUb9qy2TI0uWy8/I7a59KxH828E7AwHiHQHO0k4rTqbVp9RU4BqCOfIteFI8wo3dg1RzI/u
	CuywqfMO7ibMRP+cvsaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gghJC-0004HW-GQ; Tue, 08 Jan 2019 02:40:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gghJ8-0004EY-5e
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 02:39:59 +0000
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0B312206A3;
 Tue,  8 Jan 2019 02:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546915196;
 bh=VT0+XNUdZwsmaGLxFPXM9zwdwnbcsTw9cqA1fMecFRc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kxdHCejoo7hs1seGOIlYhPyhqOgP6q4raLbVYdBr9TZ879haspLbpoPKnS3ot4hfv
 7TgO+x/UAwi6Vq2F3Y4TLDhYDH/m0ul+YrDM06Ep/V3NSktzs53+vCQG13POcdaGHs
 tsHAuPnTwt7OXyYtuJHzuzldmRBZpoEMJbeB1WQU=
Date: Tue, 8 Jan 2019 11:39:53 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 1/3] arm64: kprobes: Move extable address check into
 arch_prepare_kprobe()
Message-Id: <20190108113953.8bc0cc7d196ddba370377217@kernel.org>
In-Reply-To: <aec51c10-d744-df0f-1216-d3372e779cb1@arm.com>
References: <154502881646.30629.9938335052821665530.stgit@devbox>
 <154502884653.30629.3172839440883293817.stgit@devbox>
 <aec51c10-d744-df0f-1216-d3372e779cb1@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_183958_256682_42A4666E 
X-CRM114-Status: GOOD (  19.78  )
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
Cc: Pratyush Anand <panand@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "David A . Long" <dave.long@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 3 Jan 2019 17:05:18 +0000
James Morse <james.morse@arm.com> wrote:

> Hi!
> 
> On 17/12/2018 06:40, Masami Hiramatsu wrote:
> > Move extable address check into arch_prepare_kprobe() from
> > arch_within_kprobe_blacklist().
> 
> I'm trying to work out the pattern for what should go in the blacklist, and what
> should be rejected by the arch code.
> 
> It seems address-ranges should be blacklisted as the contents don't matter.
> easy-example: the idmap text.

Yes, more precisely, the code smaller than a function (symbol), it must be
rejected by arch_prepare_kprobe(), since blacklist is poplated based on
kallsyms.

> The arch code should also reject instructions that can't be probed from
> arch_prepare_kprobe(). easy-example: exclusive load or store.
> 
> 
> > Please do not blacklisting instructions on exception_table,
> > since it is a kind of architectural unsupported instruction.
> 
> This doesn't fit the pattern, ... what should it be?

Some kind of instructions can not be instrumented by kprobes, such instruction
level rejection must be done in arch_prepare_kprobe(), instead of blacklist.

> The instructions in the exception_table don't matter, its the address that
> indicates there is a fixup for page-faults that occur here. We don't need to
> look at the instruction to determine this, why can't we treated these as a
> blacklisted range?

Sorry for your confusion, it was my mis-describing.

As I pointed, the exception_table contains some range of code which inside
functions, must be smaller than function.
Since those instructions are expected to cause exception (that is main reason
why it can not be probed on arm64), I thought such situation was similar to
the limitation of instruction.

So I think below will be better.
----
Please do not blacklisting instructions on exception_table,
since those are smaller than one function.
----


Thank you,

> 
> 
> Thanks,
> 
> James
> 
> 
> > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > index 2a5b338b2542..b2d4b7428ebc 100644
> > --- a/arch/arm64/kernel/probes/kprobes.c
> > +++ b/arch/arm64/kernel/probes/kprobes.c
> > @@ -102,6 +102,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> >  
> >  	if (in_exception_text(probe_addr))
> >  		return -EINVAL;
> > +
> > +	if (search_exception_tables(probe_addr))
> > +		return -EINVAL;
> > +
> >  	if (probe_addr >= (unsigned long) __start_rodata &&
> >  	    probe_addr <= (unsigned long) __end_rodata)
> >  		return -EINVAL;
> > @@ -477,8 +481,7 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
> >  	    (addr >= (unsigned long)__entry_text_start &&
> >  	    addr < (unsigned long)__entry_text_end) ||
> >  	    (addr >= (unsigned long)__idmap_text_start &&
> > -	    addr < (unsigned long)__idmap_text_end) ||
> > -	    !!search_exception_tables(addr))
> > +	    addr < (unsigned long)__idmap_text_end))
> >  		return true;
> >  
> >  	if (!is_kernel_in_hyp_mode()) {
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
