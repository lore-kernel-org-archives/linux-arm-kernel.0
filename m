From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 05 Mar 2013 11:41:17 -0700
Subject: [PATCH 03/10] ARM: tegra: get power management configurations
 for PMC from DT
In-Reply-To: <1362397207-5597-1-git-send-email-josephl@nvidia.com>
References: <1362397207-5597-1-git-send-email-josephl@nvidia.com>
Message-ID: <51363C4D.9090702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2013 04:40 AM, Joseph Lo wrote:
> If the system supports deep sleep mode (i.e. suspend), it should have
> the power management configuration for PMC in the DT under the sub-node
> of PMC. Different system may have different configurations, it should
> be parsed from DT.

> diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c

> +struct pmc_pm_data {
> +	unsigned long cpu_good_time;	/* CPU power good time in uS */
> +	unsigned long cpu_off_time;	/* CPU power off time in uS */
> +	unsigned long core_osc_time;	/* Core power good osc time in uS */
> +	unsigned long core_pmu_time;	/* Core power good pmu time in uS */
> +	unsigned long core_off_time;	/* Core power off time in uS */

Since those values are all coming from DT, shouldn't they be u32 to
match the DT cell type?
