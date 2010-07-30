From: linux@dominikbrodowski.net (Dominik Brodowski)
Date: Fri, 30 Jul 2010 15:11:25 +0200
Subject: [PATCH 9/9] [ARM] tegra: Add cpufreq support
In-Reply-To: <1280449771-24043-10-git-send-email-ccross@google.com>
References: <1280449771-24043-1-git-send-email-ccross@google.com>
	<1280449771-24043-10-git-send-email-ccross@google.com>
Message-ID: <20100730131124.GA3117@isilmar-3.linta.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

just a few minor comments:

On Thu, Jul 29, 2010 at 05:29:30PM -0700, Colin Cross wrote:
> +int tegra_verify_speed(struct cpufreq_policy *policy)
static int

> +unsigned int tegra_getspeed(unsigned int cpu)
static unsined int

> +	for_each_online_cpu(freqs.cpu)
> +		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +
> +#ifdef CONFIG_CPU_FREQ_DEBUG
> +	printk(KERN_DEBUG "cpufreq-tegra: transition: %u --> %u\n",
> +	       freqs.old, freqs.new);
> +#endif
What about using cpufreq_debug_printk(CPUFREQ_DEBUG_DRIVER, ... ) here?

> +
> +	ret = clk_set_rate_cansleep(cpu_clk, freqs.new * 1000);
"can sleep"? For how long?

Best,
	Dominik
