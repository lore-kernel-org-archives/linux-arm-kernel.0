Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D18C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:17:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5291222B1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pY2Hu5eM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xj2JPIQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5291222B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zCrRqPtr7ya2bJDqy7GYjUSY+4e9mdI3FkfnCK5CHdA=; b=pY2Hu5eMGpxUJw
	VR/23QxdtbJg8lUH/ZkS1iZCcOEJpYItX9DGLstXYetu1InyU95ljNjRCBVF/TcM7kc/kovPnErcM
	NI7DAvannOdv5aPkTcJanPX1i4QVncIt7uBMRf+DbJIDG0PqaPCr7NG0M8cnBuGJD8QeDq4o3YFbb
	qpEQBBOmmoy9yH4A3nPyqABsWyEQYsx1vBuVl9bYxT36gIYcyiVXSNSuJUYjDQUHe68MTD9LKi2bm
	HlecqGgq58iBuqNGF3g0lh7UBrr2bzAxfG1RVvxTT/YQkHarn4fbConD0WINHbMv+/SRBLnHG8yes
	APxNIwEsRvywuZwKdJ3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtuPm-0005q1-3d; Wed, 13 Feb 2019 13:17:26 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuPj-0005pR-Hl
 for linux-arm-kernel@bombadil.infradead.org; Wed, 13 Feb 2019 13:17:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sSbenEiJhYX0l2EY5xkUhH56SlPk5uQLJ95FY6Mjt1Y=; b=Xj2JPIQBOloxhQw3JujUmGJIq
 DFUBrKC+gfMyibtvX1xhuP6U5b6tDKKXEfK+cJojo6IjEyeLF91bsRPk+YOlJ+kpegYeb2ZFXdhAq
 OSZrldohNa09OEJgutlw0oex04SKKqk7maSCd4Nlkhiy5T8uRAB92kbhvi73QFea/81qqeWmdpHeP
 JAvOL4HNW+DTdMpbGM0k+zFFvKRACTDr22Equv682FZWcYaivmgMPXMsBPKGk0gW0ZcTqeFfZW2kg
 84BvlBxo08nJ1Ql2V06hNEjJNphxNXCTHtpn2/majCFoSv5cnqTmjDYldsye7FzBmNeBUDHKHi7rZ
 qBvBdEqHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuPh-00084g-BQ; Wed, 13 Feb 2019 13:17:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 207E325D07E27; Wed, 13 Feb 2019 14:17:20 +0100 (CET)
Date: Wed, 13 Feb 2019 14:17:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213131720.GU32494@hirez.programming.kicks-ass.net>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
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

On Wed, Feb 13, 2019 at 10:50:21AM +0000, Julien Thierry wrote:
> On 13/02/2019 10:35, Peter Zijlstra wrote:
> > On Tue, Feb 12, 2019 at 09:15:13AM +0000, Julien Thierry wrote:
> > 
> >>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >>>>> index a674c7db..b1bb7e9 100644
> >>>>> --- a/kernel/sched/core.c
> >>>>> +++ b/kernel/sched/core.c
> >>>>> @@ -3289,6 +3289,14 @@ static inline void schedule_debug(struct task_struct *prev)
> >>>>>  		__schedule_bug(prev);
> >>>>>  		preempt_count_set(PREEMPT_DISABLED);
> >>>>>  	}
> >>>>> +
> >>>>> +	if (IS_ENABLED(CONFIG_DEBUG_UACCESS_SLEEP) &&
> >>>>> +	    unlikely(unsafe_user_region_active())) {
> >>>>> +		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
> >>>>> +		       prev->comm, prev->pid, preempt_count());
> >>>>> +		dump_stack();
> >>>>> +	}
> >>>>> +
> >>>>>  	rcu_sleep_check();
> >>>>>
> >>>>>  	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
> > 
> >> I guess I'll drop the might_resched() part of this patch if that sounds
> >> alright.
> > 
> > I'm still confused by the schedule_debug() part. How is that not broken?
> 
> Hmmm, I am not exactly sure which part you expect to be broken, I guess
> it's because of the nature of the uaccess unsafe accessor usage.
> 
> Basically, the following is a definite no:
> 	if (user_access_begin(ptr, size)) {
> 
> 		[...]
> 
> 		//something that calls schedule
> 
> 		[...]
> 
> 		user_access_end();
> 	}
> 	
> 
> However the following is fine:
> 
> - user_access_begin(ptr, size)
> - taking irq/exception
> - get preempted

This; how is getting preempted fundamentally different from scheduling
ourselves?

> - get resumed at some point in time
> - restore state + eret
> - user_access_end()
> 
> That's because exceptions/irq implicitly "suspend" the user access
> region. (That's what I'm trying to clarify with the comment)
> So, unsafe_user_region_active() should return false in a irq/exception
> context.
> 
> Is this what you were concerned about? Or there still something that
> might be broken?

I really hate the asymetry introduced between preemptible and being able
to schedule. Both end up calling __schedule() and there really should
not be a difference.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
