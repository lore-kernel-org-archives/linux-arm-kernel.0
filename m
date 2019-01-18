Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D956C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:01:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1282086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rm0Tl/08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1282086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tfT4BKu+sNLHlsMOhFoggVDS2YkgYIXZdx7SGJwpDpo=; b=rm0Tl/08SjZBCq
	xLOTRANEHbYIqQ293aJKD5bS6gpXfMzFxPPhxO8HJ9Obj6QF8iJCyqMLolhKjWkTj1+HOyWdECWK+
	KPhr3XeR7O8+YVbwnLMjNXgwVz3pegj8XFsz2G83rlM9UPb279Iff12vrjFVjDj0sFWBRNwq/vEdS
	FfqkEoF9qyAt/1y2pPQ2gOA3JKSEGc6DTl4AynZGbI+jL/9qi60aFZGE+dE+WHH7wZYtDzGoohQIk
	UvZfDJ62CJUz3ueo2HmdmlxCkE8IMmVAs+ehjk+LtgJupXNjEOUKgVXL8g93G2Ek988ewCmIE9l3P
	uoVA+uC4xdpNHkD8+uIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXWF-0007dh-Qa; Fri, 18 Jan 2019 17:01:23 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXWC-0007dL-CQ
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:01:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E08F980D;
 Fri, 18 Jan 2019 09:01:19 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7951E3F7BE;
 Fri, 18 Jan 2019 09:01:19 -0800 (PST)
Date: Fri, 18 Jan 2019 17:01:17 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [Linux-eng] [RFC 0/3] Abstract empty functions with STUB_UNLESS
 macro
Message-ID: <20190118170117.GC8120@e119886-lin.cambridge.arm.com>
References: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
 <20190118163736.6lczivagpsdnm7ju@e5254000004ec.dyn.armlinux.org.uk>
 <20190118164425.GC3578@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118164425.GC3578@e103592.cambridge.arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_090120_433008_D1532C7B 
X-CRM114-Status: GOOD (  25.14  )
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
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Grant Likely <Grant.Likely@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Price <Steven.Price@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 04:44:25PM +0000, Dave Martin wrote:
> On Fri, Jan 18, 2019 at 04:37:36PM +0000, Russell King - ARM Linux admin wrote:
> > On Fri, Jan 18, 2019 at 04:00:27PM +0000, Andrew Murray wrote:
> > > A common pattern found in header files is a function declaration dependent
> > > on a CONFIG_ option being enabled, followed by an empty function for when
> > > that option isn't enabled. This boilerplate code can often take up a lot
> > > of space and impact code readability.
> > > 
> > > This series introduces a STUB_UNLESS macro that simplifies header files as
> > > follows:
> > > 
> > > STUB_UNLESS(CONFIG_FOO, [body], prototype)
> > 
> > Can you explain the desire to make the second argument optional,
> > rather than having the mandatory arguments first and the optional body
> > last?  It will mean more lines at each site, but I don't think that's
> > a bad thing:

My intent was to make the function prototype look like an ordinary prototype
but with all this special macro stuff on the preceding line. Much like this:

> > 
> > STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT,
> > void hw_breakpoint_thread_switch(struct task_struct *next));

Besides the extra ')' at the end it looks like a normal prototype. I felt this
may be important as existing tooling (ctags etc) might have a better chance of
recognising it and it wouldn't be so alien to new developers. I feared that if
the 'prototype' argument was in the middle then it would get lost in all the
other arguments and be less readable as a prototype.

> > 
> > STUB_UNLESS(CONFIG_CPU_FREQ,
> > struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu), return NULL);
> > 
> > or:
> > 
> > STUB_UNLESS(CONFIG_CPU_FREQ,
> > struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu),
> > 	return NULL);

As you indicate here, it's possible to spread this to three lines and keep the
readability of the prototype - though I was keen to condense it to as few lines
as possible (I was probably putting too much focus on the diff stat).

> > 
> > Seems to be more readable in terms of the flow.
> 
> Hmmm, looking at that, I probably prefer that too.

Feedback I've had so far suggests that there is a preference to putting the
optional argument at the end, I have no objection to this.

> 
> In the unlikely case that <body> uses the function arguments it would be
> quite confusing to have the body before the function prototype.
> 
> If we can keep this down to two lines so much the better, but still
> seems fine.

This is the compromise - having the optional argument after the prototype
will likely result in wrapping to the next line as prototypes tend to be
long. Perhaps this is more readable.

> 
> Provided we don't end up needing a trailing comma in the void case, to
> supply the empty body argument, that is.

No this isn't necessary.

Thanks,

Andrew Murray

> 
> Cheers
> ---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
