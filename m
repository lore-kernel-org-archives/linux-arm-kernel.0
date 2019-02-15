Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EDEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:40:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F9621927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a4UHaVsY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="URdkLOaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F9621927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6+RNzUpSkCu8i1bn/0Jgv8vqDdl+1mzCC1PyKNclOTw=; b=a4UHaVsYtGiWeE
	AcRITE5VRADayfAQM2kwpPCEbZNRyIvZvGKPFWuwy16Nx8Zjd4ED7kpH1674haqJQAK7rC7O9to8/
	iWKrI982+uE7pvsKu2w6lEb4Xe5PmmTsKRI3tL71w8GdAU03/x80kRQz1QZ9iNwS8l75aQnAN698W
	gYLlQKZliFIe4yFw8syeivHJalq9gqKmJYss3bT7IUY8rTf3TnI5UOJXNJ8AquJ2vzp403J5C1Wmf
	nWGgHIIMYICJZgTh+laF6GqW5yxcCtss4N7oVoJC8Rku3U7Tbq1a/MkMeUq26syT5sS1nk/PeCDSY
	wjevwHSuIu5vxCSqDGbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guhTi-0007FG-5E; Fri, 15 Feb 2019 17:40:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guhTg-0007Et-H1
 for linux-arm-kernel@bombadil.infradead.org; Fri, 15 Feb 2019 17:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3CyfjezA+S+2MaTUVDQw70hdDLbw1EZGPKtc0T6KeLM=; b=URdkLOaQXugoIEqVbkxev5aqv
 BM+wmv/VzK3ZWEAoY6OfpTaKIqaJWUCzgq3ziASmdAS5rGK1A9zsBEg8Kg/QUg4Iq69ovNPoAjGr5
 30DSNXn2aU8qJ+w+ycW0U+KUxXsDpse+8XzyY4Z4Z8Wy72rYRSUsO26jwXN+uAo+DKYxCYtGgsoUR
 U/vSDP8EjnMsbj2GPBo6LvdCiAaeFLiGDeEgXKpw8lYCLJBn7Iun75ZJgjbsBdYtLSFXo4tjgtSAj
 Cqkr7W+TwfawZzmUBd8n5AosfvKRp06G+ZRyGkYcD9wYqgn5ikdzmMFolLM4yqkDsSWR0bUbPDWoj
 r+p9EyhsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guhTb-0008La-CH; Fri, 15 Feb 2019 17:40:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 8D607233D2080; Fri, 15 Feb 2019 18:40:34 +0100 (CET)
Date: Fri, 15 Feb 2019 18:40:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190215174034.GP32494@hirez.programming.kicks-ass.net>
References: <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <CAMzpN2hg+CY+AuF=BtetS2HrMQYdxhBZL9QMvJX4LjAs7vwwAw@mail.gmail.com>
 <20190214193432.GR32477@hirez.programming.kicks-ass.net>
 <CAHk-=wgj9yUAhTz8n__s-gHnHJw4fznBbLAfne4EO4n6RukgcA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wgj9yUAhTz8n__s-gHnHJw4fznBbLAfne4EO4n6RukgcA@mail.gmail.com>
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

On Fri, Feb 15, 2019 at 09:18:00AM -0800, Linus Torvalds wrote:
> On Thu, Feb 14, 2019 at 11:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Something like the below, right?
> >
> > +       frame->flags = 0;
> > +       frame->flags = 0;
> 
> Those are not valid flag values.
> 
> Can you popf them? Yes.
> 
> Do they make sense? No.
> 
> It has the IF flag clear, for example. Is that intentional? If it is,

Uhmm. yeah, that's bonkers. We should have interrupts disabled here.
I'll go read up on the eflags and figure out what they _should_ be right
about there.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
