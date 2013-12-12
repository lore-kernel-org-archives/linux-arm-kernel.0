From: olof@lixom.net (Olof Johansson)
Date: Wed, 11 Dec 2013 17:09:06 -0800
Subject: [PATCH V2] ARM: tegra: add missing break to fuse initialization
 code
In-Reply-To: <1386365462-17635-1-git-send-email-swarren@wwwdotorg.org>
References: <1386365462-17635-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131212010906.GB21856@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 02:31:02PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Add a missing break to the switch in tegra_init_fuse() which determines
> which SoC the code is running on. This prevents the Tegra30+ fuse
> handling code from running on Tegra20.
> 
> Fixes: 3bd1ae57f7bb ("ARM: tegra: add fuses as device randomness")
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> v2: Add break to all cases
> ---
>  arch/arm/mach-tegra/fuse.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
> index 9a4e910c3796..3a9c1f1c219d 100644
> --- a/arch/arm/mach-tegra/fuse.c
> +++ b/arch/arm/mach-tegra/fuse.c
> @@ -198,10 +198,12 @@ void __init tegra_init_fuse(void)
>  	switch (tegra_chip_id) {
>  	case TEGRA20:
>  		tegra20_fuse_init_randomness();
> +		break;
>  	case TEGRA30:
>  	case TEGRA114:
>  	default:
>  		tegra30_fuse_init_randomness();
> +		break;
>  	}
>  
>  	pr_info("Tegra Revision: %s SKU: %d CPU Process: %d Core Process: %d\n",

Ah, yes, dropped previous version and applied this.


-Olof
