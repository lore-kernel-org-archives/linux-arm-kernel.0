From: geoff@infradead.org (Geoff Levand)
Date: Fri, 17 Jun 2016 09:37:12 -0700
Subject: [PATCH 1/2] arm64: smp: Add function to determine if cpus are
 stuck in the kernel
In-Reply-To: <1466156097-20028-2-git-send-email-james.morse@arm.com>
References: <1466156097-20028-1-git-send-email-james.morse@arm.com>
 <1466156097-20028-2-git-send-email-james.morse@arm.com>
Message-ID: <1466181432.7965.2.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-06-17 at 10:34 +0100, James Morse wrote:
> +bool cpus_are_stuck_in_kernel(void)
> +{
> +> 	> bool ret = !!cpus_stuck_in_kernel;
> +#ifdef CONFIG_HOTPLUG_CPU

How about using 'if (IS_ENABLED(CONFIG_HOTPLUG_CPU))' here?

> +	int any_cpu = raw_smp_processor_id();
> +
> +> 	> if (num_possible_cpus() > 1 && !cpu_ops[any_cpu]->cpu_die)
> +> 	> 	> ret = true;
> +#endif

-Geoff
