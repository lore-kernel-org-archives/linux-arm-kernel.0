From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 11 Jul 2013 02:33:59 -0700
Subject: [RFC PATCH 4/5] arm64: add CPU_HOTPLUG infrastructure
In-Reply-To: <1373494549-24972-1-git-send-email-mark.rutland@arm.com>
References: <1373494279-24712-1-git-send-email-mark.rutland@arm.com>
 <1373494549-24972-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20130711093359.GF830@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10, Mark Rutland wrote:
> +void __ref cpu_die(void)
> +{
> +	unsigned int cpu = smp_processor_id();
> +
> +	idle_task_exit();
> +
> +	local_irq_disable();
> +	mb();
> +
> +	/* Tell __cpu_die() that this CPU is now safe to dispose of */
> +	RCU_NONIDLE(complete(&cpu_died));

This isn't true anymore.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
