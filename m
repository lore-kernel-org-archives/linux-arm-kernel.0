From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 3 Sep 2015 20:59:10 -0700
Subject: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
In-Reply-To: <1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
 <1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
Message-ID: <20150904035910.GL15099@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03, Lina Iyer wrote:
> @@ -137,7 +138,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>  	}
>  
> -

Please remove noise.

>  	memset(&secondary_data, 0, sizeof(secondary_data));
>  	return ret;
>  }
> @@ -271,6 +271,16 @@ void __cpu_die(unsigned int cpu)
>  void __ref cpu_die(void)
>  {
>  	unsigned int cpu = smp_processor_id();
> +	struct device *cpu_dev;
> +
> +	/*
> +	 * We dont need the CPU device anymore.

s/dont/don't/

> +	 * Lets do this before IRQs are disabled to allow

s/Lets/Let's/

> +	 * runtime PM to suspend the domain as well.
> +	 */

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
