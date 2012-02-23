From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 23 Feb 2012 09:25:34 -0800
Subject: [PATCH] ARM: tegra: Enable CPUIdle on Tegra20
In-Reply-To: <1330014056-26125-1-git-send-email-pdeschrijver@nvidia.com>
References: <1330014056-26125-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC9AB@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Thursday, February 23, 2012 9:21 AM:
> As the LP3 code also works for Tegra20, we can enable cpuidle for Tegra20.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Acked-by: Stephen Warren <swarren@nvidia.com>
Tested-by: Stephen Warren <swarren@nvidia.com>

Note that the commit which added this line appears to have been made in
Nicolas's idle branch, which was merged into Russell's for-armsoc branch.
This presumably impacts the path through which this fix should get merged.

(hence leaving the patch below for Nicolas/Russell to see)

> ---
>  arch/arm/mach-tegra/common.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
> index e2a2c1f..2f86fcc 100644
> --- a/arch/arm/mach-tegra/common.c
> +++ b/arch/arm/mach-tegra/common.c
> @@ -113,8 +113,6 @@ static void __init tegra_init_cache(u32 tag_latency, u32 data_latency)
>  #ifdef CONFIG_ARCH_TEGRA_2x_SOC
>  void __init tegra20_init_early(void)
>  {
> -	disable_hlt();  /* idle WFI usage needs to be confirmed */
> -
>  	tegra_init_fuse();
>  	tegra2_init_clocks();
>  	tegra_clk_init_from_table(tegra20_clk_init_table);
> --
> 1.7.7.rc0.72.g4b5ea.dirty

-- 
nvpublic
