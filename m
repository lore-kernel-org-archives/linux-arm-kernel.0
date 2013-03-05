From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 05 Mar 2013 11:33:57 -0700
Subject: [PATCH 03/10] ARM: tegra: get power management configurations
 for PMC from DT
In-Reply-To: <1362397207-5597-1-git-send-email-josephl@nvidia.com>
References: <1362397207-5597-1-git-send-email-josephl@nvidia.com>
Message-ID: <51363A95.8090000@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2013 04:40 AM, Joseph Lo wrote:
> If the system supports deep sleep mode (i.e. suspend), it should have
> the power management configuration for PMC in the DT under the sub-node
> of PMC. Different system may have different configurations, it should
> be parsed from DT.

> diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c

> @@ -143,6 +161,10 @@ static const struct of_device_id matches[] __initconst = {
>  static void tegra_pmc_parse_dt(void)
>  {
>  	struct device_node *np;
> +	u32 prop;
> +	enum tegra_suspend_mode suspend_mode;
> +	u32 core_good_time[2] = {0, 0};
> +	u32 lp0_vec[2] = {0, 0};
>  
>  	np = of_find_matching_node(NULL, matches);
>  	BUG_ON(!np);

This files doesn't look like that; the BUG_ON() isn't present upstream
yet. So, this series depends on some other patches not yet applied. You
need to explicitly document your patch dependencies somewhere. Hopefully
I can work it out...

The DT binding documentation patch (5/10) should be squashed into this
patch; both document and implement the bindings in the same patch.
