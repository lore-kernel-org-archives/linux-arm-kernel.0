From: zhangwm@marvell.com (Neil Zhang)
Date: Sun, 13 Apr 2014 18:36:16 -0700
Subject: [PATCH] ARM: perf: save/restore pmu registers in pm notifier
In-Reply-To: <53483511.4000100@codeaurora.org>
References: <1397214083-30916-1-git-send-email-zhangwm@marvell.com>
 <53483511.4000100@codeaurora.org>
Message-ID: <175CCF5F49938B4D99B2E3EF7F558EBE55075F139F@SC-VEXCH4.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at codeaurora.org]
> Sent: 2014?4?12? 2:32
> To: Neil Zhang
> Cc: will.deacon at arm.com; linux at arm.linux.org.uk; Sudeep KarkadaNagesha;
> linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: perf: save/restore pmu registers in pm notifier
> 
> On 04/11/14 04:01, Neil Zhang wrote:
> > @@ -217,6 +219,24 @@ static struct notifier_block
> cpu_pmu_hotplug_notifier = {
> >  	.notifier_call = cpu_pmu_notify,
> >  };
> >
> > +static int cpu_pmu_pm_notify(struct notifier_block *b,
> > +					unsigned long action, void *hcpu) {
> > +	int cpu = smp_processor_id();
> > +	struct cpupmu_regs *pmuregs = &per_cpu(cpu_pmu_regs, cpu);
> 
> this_cpu_ptr(&cpu_pmu_regs)?

Thanks for the suggestion, I will update it.

> 
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted
> by The Linux Foundation


Best Regards,
Neil Zhang
