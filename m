From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 11 Apr 2014 11:31:45 -0700
Subject: [PATCH] ARM: perf: save/restore pmu registers in pm notifier
In-Reply-To: <1397214083-30916-1-git-send-email-zhangwm@marvell.com>
References: <1397214083-30916-1-git-send-email-zhangwm@marvell.com>
Message-ID: <53483511.4000100@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/14 04:01, Neil Zhang wrote:
> @@ -217,6 +219,24 @@ static struct notifier_block cpu_pmu_hotplug_notifier = {
>  	.notifier_call = cpu_pmu_notify,
>  };
>  
> +static int cpu_pmu_pm_notify(struct notifier_block *b,
> +					unsigned long action, void *hcpu)
> +{
> +	int cpu = smp_processor_id();
> +	struct cpupmu_regs *pmuregs = &per_cpu(cpu_pmu_regs, cpu);

this_cpu_ptr(&cpu_pmu_regs)?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
