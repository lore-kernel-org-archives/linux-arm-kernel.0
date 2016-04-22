From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 22 Apr 2016 15:24:47 -0700
Subject: [PATCH 08/10] mvebu: Use dev_pm_opp_set_sharing_cpus() to mark
 OPP tables as shared
In-Reply-To: <3808dbeda9c233026ed78fa3ec94c0bbd898875c.1461228504.git.viresh.kumar@linaro.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <3808dbeda9c233026ed78fa3ec94c0bbd898875c.1461228504.git.viresh.kumar@linaro.org>
Message-ID: <20160422222447.GS13149@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21, Viresh Kumar wrote:
> @@ -683,10 +678,15 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
>  			clk_put(clk);
>  			return ret;
>  		}
> +
> +		ret = dev_pm_opp_set_sharing_cpus(cpu_dev,
> +				(struct cpumask *) cpumask_of(cpu_dev->id));

This cast doesn't look good. Why are we casting away const?
Shouldn't dev_pm_opp_set_sharing_cpus() take a const mask anyway?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
