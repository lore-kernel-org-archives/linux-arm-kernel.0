Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F96C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:23:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C593620870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U5XmZ57+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C593620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sZdBTGTZ/FaDerc8U30RlwXHpKFWv8Ev8xYjxRJJrpA=; b=U5XmZ57+nc5DVX
	B/pvx85j7s6jeP9mONNdSI7Ju/mdpUDO8idWC5+L/iWLcyNldzt2Ouq6ofXijuITKm7A4ym/Pz4CJ
	RA4DfnA720sUnc/pX576QtzHO/NzlcKyCT24rxbekPmqUClvg3ZVesor5qiToRjFrT8bCP7sTaqRU
	3A6V4fyLSB5rrhgTNNp9HkT396mbUqioVoZu0qJmOHWDwhVVzaoowDY0bablFnpLKLZin/5zpWOGy
	h26qNJnTjEEu2h2H+rW0V4OXR3UJDAbprt6yyeSIn0MTLqqgCc29SxZvTG2EtAfoDN/5UD649/ESg
	WzgtfsCwS32HRnw6vQ6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmGdE-0004Hp-Aq; Wed, 23 Jan 2019 11:23:44 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmGdA-0004HN-VD
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 11:23:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F504EBD;
 Wed, 23 Jan 2019 03:23:38 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE33C3F5C1;
 Wed, 23 Jan 2019 03:23:36 -0800 (PST)
Date: Wed, 23 Jan 2019 11:23:34 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Kristina Martsenko <kristina.martsenko@arm.com>
Subject: Re: [PATCH v2] arm64: add ptrace regsets for ptrauth key management
Message-ID: <20190123112332.GL3578@e103592.cambridge.arm.com>
References: <20190110193508.31888-1-kristina.martsenko@arm.com>
 <d2bcfb3a-3668-693c-2fd4-3814b473375c@arm.com>
 <20190111135842.GB3547@e103592.cambridge.arm.com>
 <911e27a9-d199-9a64-8a2e-597733af5854@arm.com>
 <20190116151254.GA3578@e103592.cambridge.arm.com>
 <b8afbda4-c782-ceee-8294-a96a1fec02df@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b8afbda4-c782-ceee-8294-a96a1fec02df@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_032341_013570_176F86E6 
X-CRM114-Status: GOOD (  21.67  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Amit Kachhap <amit.kachhap@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 07:08:25PM +0000, Kristina Martsenko wrote:
> On 16/01/2019 15:13, Dave Martin wrote:
> > On Tue, Jan 15, 2019 at 07:32:30PM +0000, Kristina Martsenko wrote:
> >> On 11/01/2019 13:58, Dave Martin wrote:
> >>> On Thu, Jan 10, 2019 at 07:41:15PM +0000, Kristina Martsenko wrote:
> >>>> On 10/01/2019 19:35, Kristina Martsenko wrote:
> >>>> @@ -80,12 +65,12 @@ static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
> >>>>  #define ptrauth_thread_init_user(tsk)					\
> >>>>  do {									\
> >>>>  	struct task_struct *__ptiu_tsk = (tsk);				\
> >>>
> >>> Not added by this patch, but __ptiu_tsk doesn't seem to do anything
> >>> except make the subsquent lines more verbose than otherwise (and pollute
> >>> the identifier namespace -- though unlikely to be a problem).
> >>>
> >>> It may not be worth dropping it now that it's there though.
> >>
> >> Using __ptiu_tsk prevents the argument (tsk) from being evaluated twice,
> >> which could have side effects.
> > 
> > Ah, right.
> > 
> > Actually, could this be a function instead?  That would avoid multiple-
> > evaulation a clean way.
> 
> If it were a function, then this file (pointer_auth.h) would need to
> #include <linux/sched.h> (for the struct task_struct definition), which
> would create a circular header dependency, since sched.h #includes
> asm/processor.h, which #includes pointer_auth.h. Alternatively the
> function could be moved to pointer_auth.c, but that would prevent it
> from being inlined, so I'd prefer to keep it as a macro for now.

Ah, right -- I hit that before in a couple of places.

So long as there's a reason for these things being macros, I see
no problem.

> 
> >>>> -	ptrauth_keys_init(&__ptiu_tsk->thread.keys_user);		\
> >>>> -	ptrauth_keys_switch(&__ptiu_tsk->thread.keys_user);		\
> >>>> +	ptrauth_keys_init(&__ptiu_tsk->thread.uw.keys_user);		\
> >>>> +	ptrauth_keys_switch(&__ptiu_tsk->thread.uw.keys_user);		\
> >>>>  } while (0)
> >>>>  
> >>>>  #define ptrauth_thread_switch(tsk)	\
> >>>> -	ptrauth_keys_switch(&(tsk)->thread.keys_user)
> >>>> +	ptrauth_keys_switch(&(tsk)->thread.uw.keys_user)
> > 
> > Similarly, can this be a function?
> 
> Same reasons as above.
> 
> > (Technically tsk may be evaulated twice in this macro.  Given the way
> > these macros are used, I'm not sure that matters though.)
> 
> tsk is only used once here, so I think it's only evaluated once.

You're right ... I misread the changed line in the diff for two added
lines (doh).

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
