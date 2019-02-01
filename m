Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654F9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:23:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A702075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XMtBIgmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A702075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H1RSoC+64G3pbpq9jb4YenOfXrrgGCEGE6vgVi16mog=; b=XMtBIgmjrXNB3b
	2BO5gwiEuP2WY1AuCFoqIGw301xkRd+MKXRqX32K2Q4QJeyvr2UzogSILPh5yknOSauyo8vG6YPZm
	qR+9h9Zwmzw+NUtgEVnr06r5l4dwdN/N6pzFJDkGRXKmqK8Mst8s/9rPP/8ZsbbysAF7P82eq3zff
	cQlVg/DHVhTwe5Mp75X5yoY01RqLi051bPNh3JpQ+3UOZwK4qbVYCoeiQIdt0KJbNFQYt8gndCCE+
	lG3nZM0SHwSJMtUCwKVZQgUlzbQQ0izzPfYPjsMZKYnyY4yPmsUdraphtmxpzfC6WaIy7d3+Cf1Yg
	0c1plr99o3mokQp9fZ+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpPQY-0007X2-Sk; Fri, 01 Feb 2019 03:23:38 +0000
Received: from mail.windriver.com ([147.11.1.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpPQV-0007Wa-3Z
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 03:23:36 +0000
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
 by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x113NQGI018477
 (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
 Thu, 31 Jan 2019 19:23:27 -0800 (PST)
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.97]) by
 ALA-HCB.corp.ad.wrs.com ([147.11.189.41]) with mapi id 14.03.0435.000; Thu,
 31 Jan 2019 19:23:09 -0800
From: "Li, Meng" <Meng.Li@windriver.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>
Subject: RE: Could you please help to have a look a bug trace in pmu arm-cci.c
Thread-Topic: Could you please help to have a look a bug trace in pmu arm-cci.c
Thread-Index: AdS22Un8FBtNV5wWSu2itgnPZkA9GACMmHkAAAGvPQAAMlHO8A==
Date: Fri, 1 Feb 2019 03:23:08 +0000
Message-ID: <529F9A9100AE8045A7A5B5A00A39FBB86209CC86@ALA-MBD.corp.ad.wrs.com>
References: <529F9A9100AE8045A7A5B5A00A39FBB862099B8E@ALA-MBD.corp.ad.wrs.com>
 <20190130182128.GM18558@fuggles.cambridge.arm.com>
 <e28ec0ff-aaab-da22-44c3-19b5eaba0f32@arm.com>
In-Reply-To: <e28ec0ff-aaab-da22-44c3-19b5eaba0f32@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.224.163.151]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_192335_172334_A777A6CF 
X-CRM114-Status: GOOD (  26.17  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: Thursday, January 31, 2019 3:10 AM
> To: Will Deacon; Li, Meng
> Cc: mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; suzuki.poulose@arm.com
> Subject: Re: Could you please help to have a look a bug trace in pmu arm-cci.c
> 
> On 2019-01-30 6:21 pm, Will Deacon wrote:
> > [+Suzuki and Robin]
> >
> > On Mon, Jan 28, 2019 at 07:19:20AM +0000, Li, Meng wrote:
> >> When enable kernel configure CONFIG_DEBUG_ATOMIC_SLEEP, there is
> below trace
> >> during pmu arm cci driver probe phase.
> >>
> >> [ 1.983337] BUG: sleeping function called from invalid context at
> kernel/locking/rtmutex.c:2004
> >> [ 1.983340] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
> >> [ 1.983342] Preemption disabled at:
> >> [ 1.983353] [<ffffff80089801f4>] cci_pmu_probe+0x1dc/0x488
> >> [ 1.983360] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.20-rt8-yocto-
> preempt-rt #1
> >> [ 1.983362] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
> >> [ 1.983364] Call trace:
> >> [ 1.983369] dump_backtrace+0x0/0x158
> >> [ 1.983372] show_stack+0x24/0x30
> >> [ 1.983378] dump_stack+0x80/0xa4
> >> [ 1.983383] ___might_sleep+0x138/0x160
> >> [ 1.983386] __might_sleep+0x58/0x90
> >> [ 1.983391] __rt_mutex_lock_state+0x30/0xc0
> >> [ 1.983395] _mutex_lock+0x24/0x30
> >> [ 1.983400] perf_pmu_register+0x2c/0x388
> >> [ 1.983404] cci_pmu_probe+0x2bc/0x488
> >> [ 1.983409] platform_drv_probe+0x58/0xa8
> >>
> >> Because get_cpu() is invoked, preempt is disable, finally, trace occurs
> when
> >> call might_sleep()
> >
> > Hmm, the {get,put}_cpu() usage here looks very broken to me. There's the
> > fact that it might sleep, but also the assignment to g_cci_pmu is done after
> > we've re-enabled preemption, so there's a race with CPU hotplug there
> too.
> 
> Hmm, looks like I failed to appreciate that particular race at the time
> - indeed the global should probably be assigned immediately after
> cci_pmu_init() has succeeded.
> 
> > I don't think we can simply register the hotplug notifier before registering
> > the PMU, because we can't call into perf_pmu_migrate_context() until the
> PMU
> > has been registered. Perhaps we need to use the _cpuslocked() versions
> of
> > the hotplug notifier registration functions.
> >
> > I tried looking at some other drivers, but they all look broken to me, so
> > there's a good chance I'm missing something. Anybody know how this is
> > supposed to work?
> 
> As I understand the general pattern, we register the notifier last to
> avoid taking a hotplug callback with a partly-initialised PMU state,
> however since the CPU we've picked is part of that PMU state, we also
> want to avoid getting migrated off that CPU before the notifier is in
> place lest things get out of sync, hence disabling preemption. As far as
> the correctness of implementing that logic, though, it was like that
> when I got here so I've always just assumed it was fine :)
> 
> I guess the question is whether we actually need to pick our nominal CPU
> before perf_pmu_register(), or if something like the below would suffice
> - what do you reckon?
> 
> Robin.
> 
> ----->8-----
> diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
> index 1bfeb160c5b1..da9309ff80d7 100644
> --- a/drivers/perf/arm-cci.c
> +++ b/drivers/perf/arm-cci.c
> @@ -1692,19 +1692,18 @@ static int cci_pmu_probe(struct platform_device
> *pdev)
>          raw_spin_lock_init(&cci_pmu->hw_events.pmu_lock);
>          mutex_init(&cci_pmu->reserve_mutex);
>          atomic_set(&cci_pmu->active_events, 0);
> -       cci_pmu->cpu = get_cpu();
> +       cci_pmu->cpu = -1; /* Avoid races until hotplug notifier is alive */

If we set cci_pmu->cpu = -1 here, I think we should modify code of cci_pmu_event_init() as below:
//////// original ////////////////////////
	if (event->cpu < 0)
		return -EINVAL;
	event->cpu = cci_pmu->cpu;
//////// original ////////////////////////
Change into
//////// new ////////////////////////
	event->cpu = cci_pmu->cpu;
	if (event->cpu < 0)
		return -EINVAL;
//////// new ////////////////////////
Move this if condition after the assignment value operation.
Otherwise, when call perf_event_open()->find_get_context(), 
int cpu = event->cpu = -1;
-1 as a parameter passed into per_cpu_ptr(), and return a wrong cpuctx,
If we continue to execute code with the wrong cpuctx, kernel may crash.

I am not sure whether my analysis is reasonable, only just for your reference.

Thanks,
Limeng

> 
>          ret = cci_pmu_init(cci_pmu, pdev);
> -       if (ret) {
> -               put_cpu();
> +       if (ret)
>                  return ret;
> -       }
> +       g_cci_pmu = cci_pmu;
> 
>          cpuhp_setup_state_nocalls(CPUHP_AP_PERF_ARM_CCI_ONLINE,
>                                    "perf/arm/cci:online", NULL,
>                                    cci_pmu_offline_cpu);
> -       put_cpu();
> -       g_cci_pmu = cci_pmu;
> +       cci_pmu->cpu = smp_processor_id();
> +
>          pr_info("ARM %s PMU driver probed", cci_pmu->model->name);
>          return 0;
>   }
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
