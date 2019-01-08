Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006CCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:07:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07BF2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nOiaLuQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07BF2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NeKNXXZxALwLYp0NvhODzY5Iqry9d7E+CCH0LzJW7dg=; b=nOiaLuQg7t4odo
	HoXeeJ8B96iYF5Ku5BdU/k9ITcNR78Ndv9OZkfFoLN5r2aC7ytQCpMg3WkO87wpjaPTO4Jv35LYAQ
	u6nf30G85Nr6uwtLyX4jrzpbwZjSit0PryIBtmCv3tfq7q0sRpk+5En0sbuC0WLBdN96KnRPPHUHe
	PsiSMVbYKVgKkP6ZpNibvAH9b8dTGR3JeU7ZG63uXA369bVnRGB7CkgRBKr/OXJSDEnbL8snHEyCr
	Ncb+kh0ByL5+BVmw2z6nwsH1Ri9EXhR5L/jne10C79FsY5UNA5WUJdlyslELNRrJz6ESaQCStwJpi
	uTbXFSgX6D4olHXwvZGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggr6k-0005jX-Iv; Tue, 08 Jan 2019 13:07:50 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggr6g-0005ig-FA
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 13:07:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D6621596;
 Tue,  8 Jan 2019 05:07:43 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C84953F70D;
 Tue,  8 Jan 2019 05:07:42 -0800 (PST)
Date: Tue, 8 Jan 2019 13:07:41 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 05/13] arm: perf: conditionally use
 PERF_PMU_CAP_NO_EXCLUDE
Message-ID: <20190108130740.GC56789@e119886-lin.cambridge.arm.com>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
 <1546878450-20341-6-git-send-email-andrew.murray@arm.com>
 <20190108102802.GC6808@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190108102802.GC6808@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_050746_553616_141F0119 
X-CRM114-Status: GOOD (  22.33  )
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
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>,
 Shawn Guo <shawnguo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>,
 suzuki.poulose@arm.com, Sascha Hauer <s.hauer@pengutronix.de>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 11:28:02AM +0100, Peter Zijlstra wrote:
> On Mon, Jan 07, 2019 at 04:27:22PM +0000, Andrew Murray wrote:
> > @@ -393,9 +386,8 @@ __hw_perf_event_init(struct perf_event *event)
> >  	/*
> >  	 * Check whether we need to exclude the counter from certain modes.
> >  	 */
> > +	if (armpmu->set_event_filter &&
> > +	    armpmu->set_event_filter(hwc, &event->attr)) {
> >  		pr_debug("ARM performance counters do not support "
> >  			 "mode exclusion\n");
> >  		return -EOPNOTSUPP;
> 
> This then requires all set_event_filter() implementations to check all
> the various exclude options;

Yes but this isn't a new requirement, this hunk uses the absence of
set_event_filter to blanket indicate that no exclusion flags are supported.


> also, set_event_filter() failing then
> returns with -EOPNOTSUPP instead of the -EINVAL the CAP_NO_EXCLUDE
> generates, which is again inconsitent.

Yes, it's not ideal - but a step in the right direction. I wanted to limit
user visible changes as much as possible, where I've identified them I've
noted it in the commit log.

> 
> If I look at (the very first git-grep found me)
> armv7pmu_set_event_filter(), then I find it returning -EPERM (again
> inconsistent but irrelevant because the actual value is not preserved)
> for exclude_idle.
> 
> But it doesn't seem to check exclude_host at all for example.

Yes I found lots of examples like this across the tree whilst doing this
work. However I decided to initially start with simply removing duplicated
code as a result of adding this flag and attempting to preserve existing
functionality. I thought that if I add missing checks then the patchset
will get much bigger and be harder to merge. I would like to do this though
as another non-cross-arch series.

Can we limit this patch series to the minimal changes required to fully
use PERF_PMU_CAP_NO_EXCLUDE and then attempt to fix these existing problems
in subsequent patch sets?

Thanks,

Andrew Murray

> 
> > @@ -867,6 +859,9 @@ int armpmu_register(struct arm_pmu *pmu)
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (!pmu->set_event_filter)
> > +		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
> > +
> >  	ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
> >  	if (ret)
> >  		goto out_destroy;
> > -- 
> > 2.7.4
> > 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
