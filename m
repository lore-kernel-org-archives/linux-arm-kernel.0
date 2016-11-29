From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 29 Nov 2016 17:26:02 +0000
Subject: [PATCH 16/22] arm64/cpuinfo: Convert to hotplug state machine
In-Reply-To: <20161126231350.10321-17-bigeasy@linutronix.de>
References: <20161126231350.10321-1-bigeasy@linutronix.de>
 <20161126231350.10321-17-bigeasy@linutronix.de>
Message-ID: <ca0da1d4-0034-c3cd-58d9-766df487a694@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/11/16 23:13, Sebastian Andrzej Siewior wrote:
> From: Anna-Maria Gleixner <anna-maria@linutronix.de>
>
> Install the callbacks via the state machine and let the core invoke
> the callbacks on the already online CPUs.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm64/kernel/cpuinfo.c | 37 +++++++++----------------------------
>  1 file changed, 9 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 19aad7041e14..7b7be71e87bf 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -227,7 +227,7 @@ static struct attribute_group cpuregs_attr_group = {
...
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/cpuinfo:online",
> +				cpuid_cpu_online, cpuid_cpu_offline);
> +	if (ret < 0) {
> +		pr_err("cpuinfo: failed to register hotplug callbacks.\n");
> +		return ret;
> +	}
>  	return 0;
>  }

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
