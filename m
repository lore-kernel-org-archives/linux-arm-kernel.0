Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DB7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:52:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FC4321B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NIyeHtpH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hVozEyWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC4321B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xni7SreYWRvrKEK92fn1merq5g5auVdLzUMg1261Qps=; b=NIyeHtpHSOYb1f
	z6ed1vYB0kk8STz1+5Ib1HYGFWfbAEEwVjA8Ub68qSDu7NI2iyjKjKmZfYvJpo5BXeHbCfR5fdK6g
	1A8fbr+iTF1BK/CPa23rX9mXhrpb/92EHZ4Ig8oozT2BFi+joOMYnY9wxvlR6uaZlqgNcbr8p6dfp
	jVLwYpPdVXDHkuM+MvA8SZdvCUP3WxaF4lD8dEQ2jjRqh0bb/6qWhKGa3BOKgefhFkcdRm9bWIJMP
	Zvig4iIvSYUcZg4PewbTBEgkhIzA5fBmtjB5fe9O2AQ30f+8yMQBGWU4XbxbO5B/hRkagSmh7y8uI
	MB91Cjn0AB5HRKe7I2RA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtC0I-00011i-Nf; Mon, 11 Feb 2019 13:52:10 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtC0D-0000uZ-5S
 for linux-arm-kernel@bombadil.infradead.org; Mon, 11 Feb 2019 13:52:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eWj3rusOmVs9VU5WrUyV3EmRPWyzvShi15z9JJNii/c=; b=hVozEyWSFnyoOUQcnRc2RCaV3
 0J398ZZndorxm7wOPboATWk4jdD5UWzPHAioDvqYGGE0Wjv9fM0yM2c5HYQNuYcN9JCUMghQbSGAG
 27EkDEEZ5evdFr/qh4DMiB+hDqXvw0NKCvIJ8mOuy8AI0Z3kasJTwW4aiwpNZ0Vu0C5Q4xSQC+u1t
 g18qOJswBz/38yhkgoC6NOYTycWKjYT9+11vOq15BHHlISuq970oi7W4X3xuAfZldikevC1tOs0Bh
 B4lMnEBsQnx3IMx0UzhVcMlMnacF0JUWtGfVPaqYH40L4SpkXsXR2MY6hg5PidRJqkizqPXON2DyG
 mCppZU+lw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtC09-0001XH-J4; Mon, 11 Feb 2019 13:52:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 3C2032370CE11; Mon, 11 Feb 2019 14:51:59 +0100 (CET)
Date: Mon, 11 Feb 2019 14:51:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190211135159.GC32511@hirez.programming.kicks-ass.net>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211134527.GA121589@gmail.com>
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
Cc: Julien Thierry <julien.thierry@arm.com>, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
 james.morse@arm.com, hpa@zytor.com, valentin.schneider@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 02:45:27PM +0100, Ingo Molnar wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a674c7db..b1bb7e9 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3289,6 +3289,14 @@ static inline void schedule_debug(struct task_struct *prev)
> >  		__schedule_bug(prev);
> >  		preempt_count_set(PREEMPT_DISABLED);
> >  	}
> > +
> > +	if (IS_ENABLED(CONFIG_DEBUG_UACCESS_SLEEP) &&
> > +	    unlikely(unsafe_user_region_active())) {
> > +		printk(KERN_ERR "BUG: scheduling while user_access enabled: %s/%d/0x%08x\n",
> > +		       prev->comm, prev->pid, preempt_count());
> > +		dump_stack();
> > +	}
> > +
> >  	rcu_sleep_check();
> > 
> >  	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
> > @@ -6151,6 +6159,20 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
> >  EXPORT_SYMBOL(___might_sleep);
> >  #endif
> > 
> > +#ifdef CONFIG_DEBUG_UACCESS_SLEEP
> > +void __might_resched(const char *file, int line)
> > +{
> > +	if (!unsafe_user_region_active())
> > +		return;
> 
> Could you please more clearly explain why you want/need an exception from 
> the __might_resched() debug warning?

In specific; how is the addition in schedule_debug() not triggering on
PREEMPT=y kernels?

If code is preemptible, you can (get) schedule(d). If it is not
preemptible; you do not need these additional tests.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
