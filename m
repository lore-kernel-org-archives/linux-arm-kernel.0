From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 10 Oct 2018 09:55:14 -0300
Subject: [PATCH] config: arm: imx: remove PROVE_LOCKING from defconfig
In-Reply-To: <20181009153526eucas1p2cdbb125bc7a66e0685f2277740a25630~b_q7Stknv2226522265eucas1p2C@eucas1p2.samsung.com>
References: <CGME20181009153526eucas1p2cdbb125bc7a66e0685f2277740a25630@eucas1p2.samsung.com>
 <20181009153526eucas1p2cdbb125bc7a66e0685f2277740a25630~b_q7Stknv2226522265eucas1p2C@eucas1p2.samsung.com>
Message-ID: <CAOMZO5DGNu-oabp+U2DcTYQ4ozBESaOvaSW5pcJJJCWmw5+Szg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On Tue, Oct 9, 2018 at 12:36 PM Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> PROVE_LOCKING enables LOCKDEP, which causes big overhead on cache and
> bus transactions.
>
> On some ARM big.LITTLE architecutres (Exynos 5433) the overhead is really big.
> The overhead can be measures using hackbench which will speed up
> by x3 times (11sec -> 3.4sec).
> When you check transaction on cache or buses, the results are way higher
> than normal for the same hackbench test:
> L1d cache invalidations: 26mln vs 4mln
> L2u cache invalidations: 42mln vs 12mln
> bus cyc/access: 30cyc/access vs. 20cyc/access
> context switch is x3 times cheaper
>
> Enable this option only when you have some locking issue to investigate.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 7eca43f..f55cd2d 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -425,7 +425,6 @@ CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_FS=y
>  CONFIG_MAGIC_SYSRQ=y
>  # CONFIG_SCHED_DEBUG is not set
> -CONFIG_PROVE_LOCKING=y

Russell explains here why it is desirable to have
CONFIG_PROVE_LOCKING=y for development:
https://www.spinics.net/lists/kernel/msg2929513.html
