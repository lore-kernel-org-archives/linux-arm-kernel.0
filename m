From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jul 2015 23:10:23 -0700
Subject: [PATCH V3 12/16] PM / OPP: add dev_pm_opp_is_turbo() helper
In-Reply-To: <1e1445bc7f79eb4adc5bf1a0f5eddf118dc60345.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <1e1445bc7f79eb4adc5bf1a0f5eddf118dc60345.1438166099.git.viresh.kumar@linaro.org>
Message-ID: <20150731061023.GL3159@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29, Viresh Kumar wrote:
> +bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
> +{
> +	struct dev_pm_opp *tmp_opp;
> +
> +	opp_rcu_lockdep_assert();
> +
> +	tmp_opp = rcu_dereference(opp);
> +	if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available) {

IS_ERR_OR_NULL already has unlikely inside it on the error
pointer path so it seems redundant here.

Otherwise

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
