From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 21 Oct 2014 15:18:05 -0700
Subject: [PATCH 8/8] arm: perf: fold hotplug notifier into arm_pmu
In-Reply-To: <1413897084-19715-9-git-send-email-mark.rutland@arm.com>
References: <1413897084-19715-1-git-send-email-mark.rutland@arm.com>
 <1413897084-19715-9-git-send-email-mark.rutland@arm.com>
Message-ID: <5446DB9D.9020906@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2014 06:11 AM, Mark Rutland wrote:
> @@ -169,6 +192,11 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
>  	if (!cpu_hw_events)
>  		return -ENOMEM;
>  
> +	cpu_pmu->hotplug_nb.notifier_call = cpu_pmu_notify;
> +	err = register_cpu_notifier(&cpu_pmu->hotplug_nb);

Does this need to be unregistered if armpmu_register() fails?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
