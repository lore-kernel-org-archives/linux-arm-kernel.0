From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 21 Nov 2017 08:58:15 +0530
Subject: [PATCH] cpufreq: mediatek: add missing
 MODULE_DESCRIPTION/AUTHOR/LICENSE
In-Reply-To: <20171120213201.52606-1-jc@linux.com>
References: <20171120213201.52606-1-jc@linux.com>
Message-ID: <20171121032815.GF6125@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20-11-17, 13:32, Jesse Chan wrote:
> This change resolves a new compile-time warning
> when built as a loadable module:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/cpufreq/mediatek-cpufreq.o
> see include/linux/module.h for more information
> 
> This adds the license as "GPL v2", which matches the header of the file.
> 
> MODULE_DESCRIPTION and MODULE_AUTHOR are also added.
> 
> Signed-off-by: Jesse Chan <jc@linux.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 18c4bd9a5c65..e0d5090b303d 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -620,3 +620,7 @@ static int __init mtk_cpufreq_driver_init(void)
>  	return 0;
>  }
>  device_initcall(mtk_cpufreq_driver_init);
> +
> +MODULE_DESCRIPTION("MediaTek CPUFreq driver");
> +MODULE_AUTHOR("Pi-Cheng Chen <pi-cheng.chen@linaro.org>");
> +MODULE_LICENSE("GPL v2");

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
