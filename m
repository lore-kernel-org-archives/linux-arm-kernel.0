From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 17 Jul 2015 12:03:38 +0200
Subject: [PATCH V3 03/19] memory: tegra: add flush operation for Tegra30
 memory clients
In-Reply-To: <1436791197-32358-4-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-4-git-send-email-jonathanh@nvidia.com>
Message-ID: <20150717100337.GH3057@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 01:39:41PM +0100, Jon Hunter wrote:
> From: Vince Hsu <vinceh@nvidia.com>
> 
> This patch adds the hot reset register table and flush related callback
> functions for Tegra30.
> 
> Signed-off-by: Vince Hsu <vinceh@nvidia.com>
> [jonathanh at nvidia.com: Removed tegra_mc_ops and added
>  metastable_flush_reads.]
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> 
> ---
> v3: removal of tegra_mc_ops
> ---
>  drivers/memory/tegra/tegra30.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
> index 1abcd8f6f3ba..3b4987f39b52 100644
> --- a/drivers/memory/tegra/tegra30.c
> +++ b/drivers/memory/tegra/tegra30.c
> @@ -6,6 +6,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/device.h>

What do you need this for?

>  #include <linux/of.h>
>  #include <linux/mm.h>
>  
> @@ -936,6 +937,26 @@ static const struct tegra_smmu_swgroup tegra30_swgroups[] = {
>  	{ .name = "isp",  .swgroup = TEGRA_SWGROUP_ISP,  .reg = 0x258 },
>  };
>  
> +static struct tegra_mc_flush tegra30_mc_flush[] = {

const

> +	{TEGRA_SWGROUP_AFI,        0x200, 0x204,  0},
> +	{TEGRA_SWGROUP_AVPC,       0x200, 0x204,  1},
> +	{TEGRA_SWGROUP_DC,         0x200, 0x204,  2},
> +	{TEGRA_SWGROUP_DCB,        0x200, 0x204,  3},
> +	{TEGRA_SWGROUP_EPP,        0x200, 0x204,  4},
> +	{TEGRA_SWGROUP_G2,         0x200, 0x204,  5},
> +	{TEGRA_SWGROUP_HC,         0x200, 0x204,  6},
> +	{TEGRA_SWGROUP_HDA,        0x200, 0x204,  7},
> +	{TEGRA_SWGROUP_ISP,        0x200, 0x204,  8},
> +	{TEGRA_SWGROUP_MPCORE,     0x200, 0x204,  9},
> +	{TEGRA_SWGROUP_MPCORELP,   0x200, 0x204, 10},
> +	{TEGRA_SWGROUP_MPE,        0x200, 0x204, 11},
> +	{TEGRA_SWGROUP_NV,         0x200, 0x204, 12},
> +	{TEGRA_SWGROUP_NV2,        0x200, 0x204, 13},
> +	{TEGRA_SWGROUP_PPCS,       0x200, 0x204, 14},
> +	{TEGRA_SWGROUP_VDE,        0x200, 0x204, 16},
> +	{TEGRA_SWGROUP_VI,         0x200, 0x204, 17},

Spaces around { and }, please.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150717/c897e0ba/attachment.sig>
