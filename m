Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB52C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:07:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA61217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gnI0B3U/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA61217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oJo0vs1zJqpcAhQY2uEk3+gF9v4EfUohnoa7s+mPFTA=; b=gnI0B3U/9ZapDn
	2LZcEJLzjDjSf9hfUP/YQRSrlofcJ3AnjOkV62Xp1tGd5aNRQRMuY2H4RAkbKh2AeyPffhfuLbw1W
	oyWEIThihBaQQTC82cFgXeCbxt76uUEtvKv6kszsQ5liY38Gb67tn3cCpD7gbqzHjqszxKDzlEqSI
	xxF34MgiZff4rcGfxvRcBFl0U2uCUxfrYZyQnEoxcPxl59t2QoQeCNjb4iuA9Y8/ALf6wIq3qEYYu
	u13K/XTFnlFrFzcdCyBIL/AFWQ4KOlXlY9NwVl1s1Nsv8MO9OW/zMKR5bS47a/rbx9y5PHyXqueSv
	so8t15v7JlShyRtFMuMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghuef-0007x7-S0; Fri, 11 Jan 2019 11:07:13 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghueX-0007vU-0s
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:07:12 +0000
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 87e8267296bcc0e4; Fri, 11 Jan 2019 12:07:02 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 03/27] timer: Export next wakeup time of a CPU
Date: Fri, 11 Jan 2019 12:06:15 +0100
Message-ID: <119031115.C8gHTGbYmQ@aspire.rjw.lan>
In-Reply-To: <20181129174700.16585-4-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_030709_715801_58A29BEC 
X-CRM114-Status: GOOD (  21.41  )
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
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>,
 linux-kernel@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>,
 Tony Lindgren <tony@atomide.com>, Lina Iyer <lina.iyer@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thursday, November 29, 2018 6:46:36 PM CET Ulf Hansson wrote:
> From: Lina Iyer <lina.iyer@linaro.org>
> 
> Knowing the sleep duration of CPUs, is known to be needed while selecting
> the most energy efficient idle state for a CPU or a group of CPUs.
> 
> However, to be able to compute the sleep duration, we need to know at what
> time the next expected wakeup is for the CPU. Therefore, let's export this
> information via a new function, tick_nohz_get_next_wakeup(). Following
> changes make use of it.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v10:
> 	- Updated function header of tick_nohz_get_next_wakeup().
> 
> ---
>  include/linux/tick.h     |  8 ++++++++
>  kernel/time/tick-sched.c | 13 +++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index 55388ab45fd4..e48f6b26b425 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -125,6 +125,7 @@ extern bool tick_nohz_idle_got_tick(void);
>  extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
>  extern unsigned long tick_nohz_get_idle_calls(void);
>  extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
> +extern ktime_t tick_nohz_get_next_wakeup(int cpu);
>  extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
>  extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
>  
> @@ -151,6 +152,13 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
>  	*delta_next = TICK_NSEC;
>  	return *delta_next;
>  }
> +
> +static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
> +{
> +	/* Next wake up is the tick period, assume it starts now */
> +	return ktime_add(ktime_get(), TICK_NSEC);
> +}
> +
>  static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
>  static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
>  
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 69e673b88474..7a9166506503 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1089,6 +1089,19 @@ unsigned long tick_nohz_get_idle_calls(void)
>  	return ts->idle_calls;
>  }
>  
> +/**
> + * tick_nohz_get_next_wakeup - return the next wake up of the CPU
> + * @cpu: the particular CPU to get next wake up for
> + *
> + * Called for idle CPUs only.
> + */
> +ktime_t tick_nohz_get_next_wakeup(int cpu)
> +{
> +	struct clock_event_device *dev = per_cpu(tick_cpu_device.evtdev, cpu);
> +
> +	return dev->next_event;
> +}
> +
>  static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
>  {
>  #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> 

Well, I have concerns regarding this one.

I don't believe it is valid to call this new function for non-idle CPUs and
the kerneldoc kind of says so, but the next patch doesn't actually prevent
it from being called for a non-idle CPU (at the time it is called in there
the target CPU may not be idle any more AFAICS).

In principle, the cpuidle core can store this value, say in struct
cpuidle_device of the given CPU, and expose a helper to access it from
genpd, but that would be extra overhead totally unnecessary on everthing
that doesn't use genpd for cpuidle.

So maybe the driver could store it in its ->enter callback?  After all,
the driver knows that genpd is going to be used later.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
