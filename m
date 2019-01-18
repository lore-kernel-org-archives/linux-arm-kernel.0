Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36842C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:44:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061C820823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R96aaovA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061C820823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wXs9RGHSThPtwOH6WHrNHw11tC/iYRX9PuHBvFFmexA=; b=R96aaovAfkTwdh
	XoSPAz9yQqSu0uHw4wqgqTtiXmiSHDrsUaWAvbUZ8FcTp/G2Q/CFEjzA7nB0KESZ9myB+V0g3oH7v
	IuqO1Se1xRsZ3Jth0O0qL+xiVONog+bN+/OipEcPKlRW/W583yUhKXWgh1P6aE0mtoZcqngE0/tRR
	/JUjZ6Y6dUKSkR9bfNNp/LVZ2xO2TcCdBzKuv1KUyExJMTDM9byhdftQoGRBWuP5stjPjx929nVgY
	+LKQZ1+vR5rDUtwYdHVUOeFkGrnImfQgCLuzsbs7e7KrJeR2A7o6l/HHKcjP6AK9uPT7y7jWo0Q5O
	sz3eIAug4P5CqYc6L4eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXFx-0005ke-GF; Fri, 18 Jan 2019 16:44:33 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXFu-0005kF-Jh
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:44:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5636480D;
 Fri, 18 Jan 2019 08:44:30 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FC653F7BE;
 Fri, 18 Jan 2019 08:44:27 -0800 (PST)
Date: Fri, 18 Jan 2019 16:44:25 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [Linux-eng] [RFC 0/3] Abstract empty functions with STUB_UNLESS
 macro
Message-ID: <20190118164425.GC3578@e103592.cambridge.arm.com>
References: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
 <20190118163736.6lczivagpsdnm7ju@e5254000004ec.dyn.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118163736.6lczivagpsdnm7ju@e5254000004ec.dyn.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_084430_665495_779BC0CC 
X-CRM114-Status: GOOD (  18.90  )
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
 Steven Price <Steven.Price@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Grant Likely <Grant.Likely@arm.com>, Andrew Murray <andrew.murray@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 04:37:36PM +0000, Russell King - ARM Linux admin wrote:
> On Fri, Jan 18, 2019 at 04:00:27PM +0000, Andrew Murray wrote:
> > A common pattern found in header files is a function declaration dependent
> > on a CONFIG_ option being enabled, followed by an empty function for when
> > that option isn't enabled. This boilerplate code can often take up a lot
> > of space and impact code readability.
> > 
> > This series introduces a STUB_UNLESS macro that simplifies header files as
> > follows:
> > 
> > STUB_UNLESS(CONFIG_FOO, [body], prototype)
> 
> Can you explain the desire to make the second argument optional,
> rather than having the mandatory arguments first and the optional body
> last?  It will mean more lines at each site, but I don't think that's
> a bad thing:
> 
> STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT,
> void hw_breakpoint_thread_switch(struct task_struct *next));
> 
> STUB_UNLESS(CONFIG_CPU_FREQ,
> struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu), return NULL);
> 
> or:
> 
> STUB_UNLESS(CONFIG_CPU_FREQ,
> struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu),
> 	return NULL);
> 
> Seems to be more readable in terms of the flow.

Hmmm, looking at that, I probably prefer that too.

In the unlikely case that <body> uses the function arguments it would be
quite confusing to have the body before the function prototype.

If we can keep this down to two lines so much the better, but still
seems fine.

Provided we don't end up needing a trailing comma in the void case, to
supply the empty body argument, that is.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
