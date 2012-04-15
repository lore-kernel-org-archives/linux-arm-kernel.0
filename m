From: olof@lixom.net (Olof Johansson)
Date: Sat, 14 Apr 2012 17:33:03 -0700
Subject: [PATCH 1/5] ARM: tegra: Add pllc clock init table
In-Reply-To: <1334356926-4275-1-git-send-email-swarren@wwwdotorg.org>
References: <1334356926-4275-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120415003303.GA10967@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 04:42:02PM -0600, Stephen Warren wrote:
> From: Allen Martin <amartin@nvidia.com>
> 
> (cherry picked from commit 54f28b336f2ba3da93a459d22e32944823960d08
> in the chromeos-2.6.38 kernel)
> 
> swarren adds:

The above 4 lines make no sense for upstream, so you can just say "from the
Chrome OS 2.6.38 tree" or similar.

> pll_c will be used as a clock source. Fill in tegra_pll_c_freq_table[]
> so that it's possible to explicitly initialize the PLL.
> 
> NVIDIA's downstream nv-3.1 kernel and the ChromeOS kernel have different
> pll_c tables. nv-3.1 contains entries for 522MHz and 598MHz output,
> whereas the ChromeOS kernel contains entries for 600MHz output. I chose
> to upstream the ChromeOS values for now, since the 600MHz rate appears
> to match the default rate of this PLL when the HW boots.
> 
> Signed-off-by: Allen Martin <amartin@nvidia.com>
> Signed-off-by: Olof Johansson <olofj@chromium.org>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/mach-tegra/tegra2_clocks.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
> index cf4999b..0bf0f2d 100644
> --- a/arch/arm/mach-tegra/tegra2_clocks.c
> +++ b/arch/arm/mach-tegra/tegra2_clocks.c
> @@ -1486,6 +1486,10 @@ static struct clk tegra_clk_m = {
>  };
>  
>  static struct clk_pll_freq_table tegra_pll_c_freq_table[] = {
> +	{ 12000000, 600000000, 600, 12, 1, 8 },
> +	{ 13000000, 600000000, 600, 13, 1, 8 },
> +	{ 19200000, 600000000, 500, 16, 1, 6 },
> +	{ 26000000, 600000000, 600, 26, 1, 8 },
>  	{ 0, 0, 0, 0, 0, 0 },
>  };
>  
> -- 
> 1.7.0.4
> 
