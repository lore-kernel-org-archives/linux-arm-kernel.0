From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jan 2014 11:17:32 +0800
Subject: [PATCH 5/6] arm: exynos4-dt: statically add platform device for
 cpufreq-cpu0 platform driver
In-Reply-To: <1389283165-17708-6-git-send-email-thomas.ab@samsung.com>
References: <1389283165-17708-1-git-send-email-thomas.ab@samsung.com>
 <1389283165-17708-6-git-send-email-thomas.ab@samsung.com>
Message-ID: <20140113031730.GE23525@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 09:29:24PM +0530, Thomas Abraham wrote:
> +static struct platform_device cpufreq_device = {
> +	.name		= "cpufreq-cpu0",
> +	.id		= -1,
> +};
> +
>  static void __init exynos4_dt_machine_init(void)
>  {
>  	exynos_cpuidle_init();
>  	exynos_cpufreq_init();
>  
> +	platform_device_register(&cpufreq_device);

It can just be:

	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);

Shawn

>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }
>  
> -- 
> 1.6.6.rc2
> 
