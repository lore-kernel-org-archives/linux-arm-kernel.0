From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 Jan 2012 11:39:50 +0000
Subject: [PATCH V2 1/4] cpufreq: add arm soc generic cpufreq driver
In-Reply-To: <1324031462-24961-2-git-send-email-richard.zhao@linaro.org>
References: <1324031462-24961-1-git-send-email-richard.zhao@linaro.org>
 <1324031462-24961-2-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120118113949.GA22977@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 06:30:59PM +0800, Richard Zhao wrote:

> +	if (higher && cpu_reg)
> +		regulator_set_voltage(cpu_reg,
> +				cpu_volts[index], cpu_volts[index]);
> +
> +	ret = clk_set_rate(cpu_clk, freq);
> +	if (ret != 0) {
> +		printk(KERN_DEBUG "cannot set CPU clock rate\n");
> +		return ret;
> +	}
> +
> +	if (!higher && cpu_reg)
> +		regulator_set_voltage(cpu_reg,
> +				cpu_volts[index], cpu_volts[index]);

This appears to reintroduce the setting of an exact voltage which I'm
sure was fixed in previous versions of the patch.

> +static struct cpufreq_driver arm_cpufreq_driver = {
> +	.flags = CPUFREQ_STICKY,
> +	.verify = arm_verify_speed,
> +	.target = arm_set_target,
> +	.get = arm_get_speed,
> +	.init = arm_cpufreq_init,
> +	.exit = arm_cpufreq_exit,
> +	.name = "arm",
> +};

This code doesn't actually look terribly ARM specific...

> +	printk(KERN_INFO "ARM SoC generic CPU frequency driver\n");

Do we need this?
