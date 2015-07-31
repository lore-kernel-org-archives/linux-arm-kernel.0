From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jul 2015 22:43:56 -0700
Subject: [PATCH V3 06/16] PM / OPP: Break _opp_add_dynamic() into smaller
 functions
In-Reply-To: <f5778b7bf5d30d888297c9e2fd7097901e9c47d9.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <f5778b7bf5d30d888297c9e2fd7097901e9c47d9.1438166099.git.viresh.kumar@linaro.org>
Message-ID: <20150731054356.GI3159@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29, Viresh Kumar wrote:
> Later commits would add support for new OPP bindings and this would be
> required then. So, lets do it in a separate patch to make it easily
> reviewable.
> 
> Another change worth noticing is INIT_LIST_HEAD(&opp->node). We weren't
> doing it earlier as we never tried to delete a list node before it is
> added to list. But this wouldn't be the case anymore. We might try to
> delete a node (just to reuse the same code paths), without it being
> getting added to the list.
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
