Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C77C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:19:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5CD3218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lF960RjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CD3218D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zaxTbiGpHp4L9v3eoPDMAA0w0LIDBmFPOElaoXEtXkc=; b=lF960RjIFQujvr
	QKGXfQqLP3Qu/Yxpj8edckn/NOWETAJmwh4dY8qOEbRJcpxP+UMr6EgF6v2WivHnC1aTYc97rO4Cb
	tmko1tKG9Ia+uevV4rVxU1PMOd6hYVEn9iTV0ZTaYbtMU14eAFHPWZVSsrTQiWBaKEL7f/vNhxjVu
	qoortd/XI2rP8GwgvJ1d9PzQwCO9GyZkeFNe5wbXs+Tv+WmZaPL5oilMb7ZV5+l64gW+oan4YR2v2
	JRlAROsSr8n6ik/LaolYMRnCcSP/Vjk4BD0HDmQAs4aIbtSw4/B/syN9SAgxpKp34gip8JwCwMY1I
	kBqkNMx9N/ZnL/999ymA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyZq-0002hv-WB; Fri, 25 Jan 2019 10:19:11 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmyZn-0002hI-K0
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:19:09 +0000
Received: by mail-ot1-f66.google.com with SMTP id t5so8081191otk.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 02:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cieXeQ//y7xkUGvpDjyVuY5IzlnKYqpyI5hEWYBCr7M=;
 b=Qb6sPK/zs/rVCRPfn5P6MvTT817hJYvRwgxsvaqr3GjCAKrL2BW3MVrkiTeVFs7A4M
 D0/b0SFWoblnU2bcJPjli8FeQpq2g08qs/Yp77q8uqEgEyCAXeyV1xSK75VkRwfvLHx9
 shc5g4CCzwIexAC36L9woxNvDe0JEgzWw3arW1qrgUmb3pD3NdnRShlKyVdYfTj84V1J
 8G5g9YNU1QXhmHzFAHGNk/S+vD8JeifudxZ92mzGFNfmkwopcprD3fWUt93hSLzX8N4x
 2564jx22DdCSiw/delcOamEXHz+ETCPJmzwSLMT8OlG5oLzAJ0VAxGNcYTmEsKh3nhlC
 Dw+Q==
X-Gm-Message-State: AJcUukfx1TOY0qcqZbTebjR8VLM51NqAC/VUWCxPUZNki7/AxlrHHlfM
 mTTe0jE8ynwU8WzWOBjNXeKEhkAfJgPPhhMcBpM=
X-Google-Smtp-Source: ALg8bN4CWdz8jsDCD2OSOiUDmDS7cAalxDNLBKPeZaT1yuXRrXsnUQPMhd2xJGF3ekE6y3HY/DJ43GjhMwIbRu2ez0E=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr6920554ota.244.1548411544379; 
 Fri, 25 Jan 2019 02:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-4-ulf.hansson@linaro.org>
 <119031115.C8gHTGbYmQ@aspire.rjw.lan>
 <CAPDyKFqQQnMKFNpGyi_dkP_Rm8qo-1WjPfVkp2unOxyXRa2wbA@mail.gmail.com>
 <CAJZ5v0iY7j5SThQhtq5xP+g5yNiHQ+cMWxq-tdVh3t5wJ_s3Tw@mail.gmail.com>
 <CAPDyKFr6nD6hazmsGqT-Z-Z67oime75Yavr+SuL0P_MZF3HZGQ@mail.gmail.com>
 <CAPDyKFoRZyTpccWaE7TZXM=E2xRevqX9MxMGnuq6P=qfYQfBtg@mail.gmail.com>
In-Reply-To: <CAPDyKFoRZyTpccWaE7TZXM=E2xRevqX9MxMGnuq6P=qfYQfBtg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 25 Jan 2019 11:18:53 +0100
Message-ID: <CAJZ5v0hiC-FJMR4_QSBEgCKLbj2QHBRB3ReABFmQ_8wF4=-mcQ@mail.gmail.com>
Subject: Re: [PATCH v10 03/27] timer: Export next wakeup time of a CPU
To: Ulf Hansson <ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_021907_657600_BB155C1C 
X-CRM114-Status: GOOD (  37.62  )
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
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Lina Iyer <lina.iyer@linaro.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Kevin Hilman <khilman@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 11:04 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> [...]
>
> > > > > > +/**
> > > > > > + * tick_nohz_get_next_wakeup - return the next wake up of the CPU
> > > > > > + * @cpu: the particular CPU to get next wake up for
> > > > > > + *
> > > > > > + * Called for idle CPUs only.
> > > > > > + */
> > > > > > +ktime_t tick_nohz_get_next_wakeup(int cpu)
> > > > > > +{
> > > > > > +     struct clock_event_device *dev = per_cpu(tick_cpu_device.evtdev, cpu);
> > > > > > +
> > > > > > +     return dev->next_event;
> > > > > > +}
> > > > > > +
> > > > > >  static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
> > > > > >  {
> > > > > >  #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> > > > > >
> > > > >
> > > > > Well, I have concerns regarding this one.
> > > > >
> > > > > I don't believe it is valid to call this new function for non-idle CPUs and
> > > > > the kerneldoc kind of says so, but the next patch doesn't actually prevent
> > > > > it from being called for a non-idle CPU (at the time it is called in there
> > > > > the target CPU may not be idle any more AFAICS).
> > > >
> > > > You are correct, but let me clarify things.
> > > >
> > > > We are calling this new API from the new genpd governor, which may
> > > > have a cpumask indicating there is more than one CPU attached to its
> > > > PM domain+sub-PM domains. In other words, we may call the API for
> > > > another CPU than the one we are executing on.
> > > >
> > > > When the new genpd governor is called, all CPUs in the cpumask of the
> > > > genpd in question, are already runtime suspended and will remain so
> > > > throughout the decisions made by the governor.
> > > >
> > > > However, because of the race condition, which needs to be manged by
> > > > the genpd backend driver and its corresponding FW, one of the CPU in
> > > > the genpd cpumask could potentially wake up from idle when the genpd
> > > > governor runs. However, as a part of exiting from idle, that CPU needs
> > > > to wait for the call to pm_runtime_get_sync() to return before
> > > > completing the exit patch of idle. This also means waiting for the
> > > > genpd governor to finish.
> > >
> > > OK, so the CPU spins on a spin lock inside of the idle loop with interrupts off.
> >
> > Correct.
> >
> > This is the part that is not very nice, but ideally it should be a
> > rather rare condition as it only happens during the last man standing
> > point.
> >
> > >
> > > > The point is, no matter what decision the governor takes under these
> > > > circumstances, the genpd backend driver and its FW must manage this
> > > > race condition during the last man standing. For PSCI OSI mode, it
> > > > means that if a cluster idle state is suggested by Linux during these
> > > > circumstances, it must be prevented and aborted.
> > >
> > > I would suggest putting a comment to explain that somewhere as it is
> > > not really obvious.
> >
> > Let me see if can squeeze in that somewhere, probably it's best suited
> > in the new genpd governor code somewhere.
> >
> > >
> > > > >
> > > > > In principle, the cpuidle core can store this value, say in struct
> > > > > cpuidle_device of the given CPU, and expose a helper to access it from
> > > > > genpd, but that would be extra overhead totally unnecessary on everthing
> > > > > that doesn't use genpd for cpuidle.
> > > > >
> > > > > So maybe the driver could store it in its ->enter callback?  After all,
> > > > > the driver knows that genpd is going to be used later.
> > > >
> > > > This would work, but it wouldn't really change much when it comes to
> > > > the race condition described above.
> > >
> > > No, it wouldn't make the race go away.
> > >
> > > > Of course it would turn the code
> > > > into being more cpuidle specific, which seems reasonable to me.
> > > >
> > > > Anyway, if I understand your suggestion, in principle it means
> > > > changing $subject patch in such way that the API should not take "int
> > > > cpu" as an in-parameter, but instead only use __this_cpu() to read out
> > > > the next event for current idle CPU.
> > >
> > > Yes.
>
> I have looked closer to this and it turned out that it seems that I
> should probably not need introduce an entirely new thing here. Instead
> I should likely be able to re-factor the current
> tick_nohz_get_sleep_length() and tick_nohz_next_event(), as those are
> in principle doing the similar things as I need. So I started hacking
> on that, when Daniel Lezcano told me that he already have a patch
> doing exactly what I want. :-) However, in the context of his "next
> wakeup prediction" work, but that shouldn't matter.
>
> If I can make it work, I will fold in his patch in the next version of
> the series instead.
>
> Please tell if you already at this point, see any issues with this approach.

Not in principle as long as you do that in the context of the cpuidle
framework.  That is, I still would like to have this  "cpuidle, give
me the wakeup time of this CPU" I/F to the genpd governor, but you can
do the above to implement it as long as I'm concerned.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
