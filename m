Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCCFC4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:36:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187462190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rd9sPe3a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jHJJNhfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187462190A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LAHN71qsLLgYXvnduE2d+4K+ogqJdChN1Z1Wpfz+gJk=; b=rd9sPe3aqxaNGU
	wkGj6ykw/CuyVQVE91ozhpIs0U2QV60t+PKBb5NWlH/GZoZdogxwPDpcqNqM0kEyp1JaCBDsPnTEz
	Gju4zqag2f9HsQOCGRL1qie/izK/z86vvj8zW4vxV04WUCcgyJ3+skj1mRTVlNg5pomwPUB2kS6e9
	JqWxAaoyJpMdUkekD+8lVr96OHbwt+f/rq4KJ5f57gXowVLf/9Vagj6t5+uUTM/C/8+vuxjeNfVvw
	Fjcy0g1ZQDBX1OJmBL075rjO9KHB4CxVFfrNRatQgZ9uGi5tgFQhSOqpMEwwukLayqjgHMFudMA27
	q6WHsAZrFf/hnlpFoXpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtrtY-000277-Id; Wed, 13 Feb 2019 10:36:00 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtrtW-000264-Q1
 for linux-arm-kernel@bombadil.infradead.org; Wed, 13 Feb 2019 10:35:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=czAaUKm5d4NJqhNhwcovfXQn4SkiGplxomEQLfnJLXs=; b=jHJJNhfC68k0s+g824T+ojFF/
 RyG1NGZLpeUAjfrd263UZFzBTLsa4GHWlBlybEx3lJM57Pa6fjTTkGYIdeTFFFVSwEYk4BgQnXT20
 4gysr+4A+RjR11ZuH1FUUCUv2N1IPKAdHl6EYJqHZ9NvLgmsgWYGGx2hxwiHFCnruSA7AVyDYkqnp
 sQRJB2CY3CHasCgDslp3BlsywX/tGVTnlfey9HIqHE4EFJ73nbpLMPTI07UAVXQccISuZTaKoJH8+
 vnbszb+VGF23wKB/ljdjBoJVyTpC8PCQTkJWQ3oVG0UZUQ1Zj2mT+xyoVJ/kmy22KA0NN/8A0Zrnz
 iFM9IkVYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtrtT-0005FS-MI; Wed, 13 Feb 2019 10:35:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 06ACE20D0C1E6; Wed, 13 Feb 2019 11:35:54 +0100 (CET)
Date: Wed, 13 Feb 2019 11:35:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213103553.GO32494@hirez.programming.kicks-ass.net>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
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
Cc: catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 valentin.schneider@arm.com, mingo@redhat.com, james.morse@arm.com,
 hpa@zytor.com, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 09:15:13AM +0000, Julien Thierry wrote:

> >>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >>> index a674c7db..b1bb7e9 100644
> >>> --- a/kernel/sched/core.c
> >>> +++ b/kernel/sched/core.c
> >>> @@ -3289,6 +3289,14 @@ static inline void schedule_debug(struct task_struct *prev)
> >>>  		__schedule_bug(prev);
> >>>  		preempt_count_set(PREEMPT_DISABLED);
> >>>  	}
> >>> +
> >>> +	if (IS_ENABLED(CONFIG_DEBUG_UACCESS_SLEEP) &&
> >>> +	    unlikely(unsafe_user_region_active())) {
> >>> +		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
> >>> +		       prev->comm, prev->pid, preempt_count());
> >>> +		dump_stack();
> >>> +	}
> >>> +
> >>>  	rcu_sleep_check();
> >>>
> >>>  	profile_hit(SCHED_PROFILING, __builtin_return_address(0));

> I guess I'll drop the might_resched() part of this patch if that sounds
> alright.

I'm still confused by the schedule_debug() part. How is that not broken?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
