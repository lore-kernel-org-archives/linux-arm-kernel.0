Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D5DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:00:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B987206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e7oNO7vP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JxJS7eYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B987206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OmJesV6FXrvAtV1xn2yybxLLkEMY6Bc6WSOU0eA5GjA=; b=e7oNO7vPIdUYhs
	fsKOXh+lxPo7bfNOXnrQyMHj+nmvdSMFTqZ79HvzLMU5eNY6K/0zE4KT528hALPmSjuaZH/LuZH7Q
	+Pt/3hMA1xWmvTeYVEW9V+9OCGiNlOi/WgXMzgtdtdfdk9y1U0hqoRDdskqIvnq6N0lFRhmokM9XA
	+LEyVlCBNNVm0V2Hz7x0YYiYDbp8S0bUKCGeo3XLG1IZSCi6RtrPC5JXFF62faDXj/ddZMyz1h3Dz
	06AAL5dI2IUiVhbu96dIqIOqh76H8I0moRmFSvLiErSf1vWyZwg5qWjry8reTBANh+y5zgBd2WXLL
	3kMBDwOYz4hyYMDGqeVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjjsN-0000Ih-GS; Wed, 16 Jan 2019 12:00:55 +0000
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjjsJ-0000IC-Bk
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 12:00:53 +0000
Received: by mail-ua1-x944.google.com with SMTP id e16so2044889uam.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 04:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pgxm3kChNw8oK1BV6R/D92bOBtVUjtxC+UQG7yRRsDE=;
 b=JxJS7eYnc6IfjfgEpI48yRwQyPcr7WfXJQZh2wt9L5ImQwQ3xcYZ6DV7Vs7j5sKNqh
 Qk43YwkxJgZ8zZXEQyyOnTyYMublI9RNq3b2tuQDRRrsg6K7kjxxCWpSxhrL9//It4tG
 xyHIeNjLjAUWLUS+rllZWzZZ3LU40DYiUmsyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pgxm3kChNw8oK1BV6R/D92bOBtVUjtxC+UQG7yRRsDE=;
 b=X13/5XWu3P3y7YeMlWd5y7wL8kfrY8PMhadhY3ggNK0RYB7VNK375TCoQ3qulaKqXh
 yiam85IZ/hGGSRFjdn1arYUiVyEYBH2HHCMEWBPtquSmk6L8JS1BVickzAEtki+wi6HB
 D0c6cfkTiEYZWbLX2BdTXbYbgANHFshq7ztCG6Qf4OyBTPjrru7UsX2hBqziQbbhbbv7
 mzx7z/TbwPT4v1YN8/GX6FozdYkPUQJwqa0mTBA8wfS0p4ExSi29gc18hmB/cbpKz2b7
 yZ4rIyLIM258EPqMWnJM0KdwoNUllBoHNLAYWNwUiYb6exDNW5F7xaEXu1eIYLQpff9U
 RHuA==
X-Gm-Message-State: AJcUukcVTE3L1zQxxS+UTw4s9BZzyH7KAUGeqhLGFyOmU2N8hFfoUHbz
 eFCOBInNHaC7hvwR6XnNqJKYXXqKDXYoE++vYbqpMg==
X-Google-Smtp-Source: ALg8bN51CcHrU+JEK914gF86v5JMo78F3NrSpGePAXLHj8RJGd9yKsXVhVZ5k5vARkeg1RUJjiYewhR+89EfvnxFBaY=
X-Received: by 2002:ab0:526:: with SMTP id 35mr3521294uax.25.1547640049661;
 Wed, 16 Jan 2019 04:00:49 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-4-ulf.hansson@linaro.org>
 <119031115.C8gHTGbYmQ@aspire.rjw.lan>
 <CAPDyKFqQQnMKFNpGyi_dkP_Rm8qo-1WjPfVkp2unOxyXRa2wbA@mail.gmail.com>
 <CAJZ5v0iY7j5SThQhtq5xP+g5yNiHQ+cMWxq-tdVh3t5wJ_s3Tw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iY7j5SThQhtq5xP+g5yNiHQ+cMWxq-tdVh3t5wJ_s3Tw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 16 Jan 2019 13:00:13 +0100
Message-ID: <CAPDyKFr6nD6hazmsGqT-Z-Z67oime75Yavr+SuL0P_MZF3HZGQ@mail.gmail.com>
Subject: Re: [PATCH v10 03/27] timer: Export next wakeup time of a CPU
To: "Rafael J. Wysocki" <rafael@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_040051_406375_21732497 
X-CRM114-Status: GOOD (  42.10  )
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
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, Tony Lindgren <tony@atomide.com>,
 Lina Iyer <lina.iyer@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 16 Jan 2019 at 11:59, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jan 16, 2019 at 8:58 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Fri, 11 Jan 2019 at 12:07, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Thursday, November 29, 2018 6:46:36 PM CET Ulf Hansson wrote:
> > > > From: Lina Iyer <lina.iyer@linaro.org>
> > > >
> > > > Knowing the sleep duration of CPUs, is known to be needed while selecting
> > > > the most energy efficient idle state for a CPU or a group of CPUs.
> > > >
> > > > However, to be able to compute the sleep duration, we need to know at what
> > > > time the next expected wakeup is for the CPU. Therefore, let's export this
> > > > information via a new function, tick_nohz_get_next_wakeup(). Following
> > > > changes make use of it.
> > > >
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > > Cc: Lina Iyer <ilina@codeaurora.org>
> > > > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > > > Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >
> > > > Changes in v10:
> > > >       - Updated function header of tick_nohz_get_next_wakeup().
> > > >
> > > > ---
> > > >  include/linux/tick.h     |  8 ++++++++
> > > >  kernel/time/tick-sched.c | 13 +++++++++++++
> > > >  2 files changed, 21 insertions(+)
> > > >
> > > > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > > > index 55388ab45fd4..e48f6b26b425 100644
> > > > --- a/include/linux/tick.h
> > > > +++ b/include/linux/tick.h
> > > > @@ -125,6 +125,7 @@ extern bool tick_nohz_idle_got_tick(void);
> > > >  extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
> > > >  extern unsigned long tick_nohz_get_idle_calls(void);
> > > >  extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
> > > > +extern ktime_t tick_nohz_get_next_wakeup(int cpu);
> > > >  extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
> > > >  extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
> > > >
> > > > @@ -151,6 +152,13 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
> > > >       *delta_next = TICK_NSEC;
> > > >       return *delta_next;
> > > >  }
> > > > +
> > > > +static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
> > > > +{
> > > > +     /* Next wake up is the tick period, assume it starts now */
> > > > +     return ktime_add(ktime_get(), TICK_NSEC);
> > > > +}
> > > > +
> > > >  static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
> > > >  static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
> > > >
> > > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > > index 69e673b88474..7a9166506503 100644
> > > > --- a/kernel/time/tick-sched.c
> > > > +++ b/kernel/time/tick-sched.c
> > > > @@ -1089,6 +1089,19 @@ unsigned long tick_nohz_get_idle_calls(void)
> > > >       return ts->idle_calls;
> > > >  }
> > > >
> > > > +/**
> > > > + * tick_nohz_get_next_wakeup - return the next wake up of the CPU
> > > > + * @cpu: the particular CPU to get next wake up for
> > > > + *
> > > > + * Called for idle CPUs only.
> > > > + */
> > > > +ktime_t tick_nohz_get_next_wakeup(int cpu)
> > > > +{
> > > > +     struct clock_event_device *dev = per_cpu(tick_cpu_device.evtdev, cpu);
> > > > +
> > > > +     return dev->next_event;
> > > > +}
> > > > +
> > > >  static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
> > > >  {
> > > >  #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> > > >
> > >
> > > Well, I have concerns regarding this one.
> > >
> > > I don't believe it is valid to call this new function for non-idle CPUs and
> > > the kerneldoc kind of says so, but the next patch doesn't actually prevent
> > > it from being called for a non-idle CPU (at the time it is called in there
> > > the target CPU may not be idle any more AFAICS).
> >
> > You are correct, but let me clarify things.
> >
> > We are calling this new API from the new genpd governor, which may
> > have a cpumask indicating there is more than one CPU attached to its
> > PM domain+sub-PM domains. In other words, we may call the API for
> > another CPU than the one we are executing on.
> >
> > When the new genpd governor is called, all CPUs in the cpumask of the
> > genpd in question, are already runtime suspended and will remain so
> > throughout the decisions made by the governor.
> >
> > However, because of the race condition, which needs to be manged by
> > the genpd backend driver and its corresponding FW, one of the CPU in
> > the genpd cpumask could potentially wake up from idle when the genpd
> > governor runs. However, as a part of exiting from idle, that CPU needs
> > to wait for the call to pm_runtime_get_sync() to return before
> > completing the exit patch of idle. This also means waiting for the
> > genpd governor to finish.
>
> OK, so the CPU spins on a spin lock inside of the idle loop with interrupts off.

Correct.

This is the part that is not very nice, but ideally it should be a
rather rare condition as it only happens during the last man standing
point.

>
> > The point is, no matter what decision the governor takes under these
> > circumstances, the genpd backend driver and its FW must manage this
> > race condition during the last man standing. For PSCI OSI mode, it
> > means that if a cluster idle state is suggested by Linux during these
> > circumstances, it must be prevented and aborted.
>
> I would suggest putting a comment to explain that somewhere as it is
> not really obvious.

Let me see if can squeeze in that somewhere, probably it's best suited
in the new genpd governor code somewhere.

>
> > >
> > > In principle, the cpuidle core can store this value, say in struct
> > > cpuidle_device of the given CPU, and expose a helper to access it from
> > > genpd, but that would be extra overhead totally unnecessary on everthing
> > > that doesn't use genpd for cpuidle.
> > >
> > > So maybe the driver could store it in its ->enter callback?  After all,
> > > the driver knows that genpd is going to be used later.
> >
> > This would work, but it wouldn't really change much when it comes to
> > the race condition described above.
>
> No, it wouldn't make the race go away.
>
> > Of course it would turn the code
> > into being more cpuidle specific, which seems reasonable to me.
> >
> > Anyway, if I understand your suggestion, in principle it means
> > changing $subject patch in such way that the API should not take "int
> > cpu" as an in-parameter, but instead only use __this_cpu() to read out
> > the next event for current idle CPU.
>
> Yes.
>
> > Additionally, we need another new cpuidle API, which genpd can call to
> > retrieve a new per CPU "next event data" stored by the cpuidle driver
> > from its ->enter() callback. Is this a correct interpretation of your
> > suggestion?
>
> Yes, it is.

Thanks for confirming!

>
> Generally, something like "cpuidle, give me the wakeup time of this
> CPU".  And it may very well give you 0 if the CPU has woken up
> already. :-)

Yep, I was thinking something like that, so in principle it may
minimize the window of receiving in-correct "next wakeup data" in
genpd for a non-idle CPU, but again it doesn't solve the race
condition.

Alright, I re-spin this according to your suggestions. Thanks for reviewing!

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
