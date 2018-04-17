From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 17 Apr 2018 11:21:02 +0300
Subject: [PATCH v6 07/11] ARM: sun9i: smp: Rename clusters's power-off
In-Reply-To: <20180416215032.5023-8-mylene.josserand@bootlin.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-8-mylene.josserand@bootlin.com>
Message-ID: <fd19ec26-9240-5ae2-fc6e-d3918ab91d01@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 4/17/2018 12:50 AM, Myl?ne Josserand wrote:

> To prepare the support for sun8i-a83t, rename the variable name

    s/variable/macro/ maybe? Also "rename the ... name" sounds tautological...

> that handles the power-off of clusters because it is different from
> sun9i-a80 to sun8i-a83t.
> 
> The power off register for clusters are different from a80 and a83t.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
>   arch/arm/mach-sunxi/mc_smp.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> index 727968d6a3e5..03f021d0c73e 100644
> --- a/arch/arm/mach-sunxi/mc_smp.c
> +++ b/arch/arm/mach-sunxi/mc_smp.c
> @@ -60,7 +60,7 @@
>   #define PRCM_CPU_PO_RST_CTRL_CORE(n)	BIT(n)
>   #define PRCM_CPU_PO_RST_CTRL_CORE_ALL	0xf
>   #define PRCM_PWROFF_GATING_REG(c)	(0x100 + 0x4 * (c))
> -#define PRCM_PWROFF_GATING_REG_CLUSTER	BIT(4)
> +#define PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I	BIT(4)
>   #define PRCM_PWROFF_GATING_REG_CORE(n)	BIT(n)
>   #define PRCM_PWR_SWITCH_REG(c, cpu)	(0x140 + 0x10 * (c) + 0x4 * (cpu))
>   #define PRCM_CPU_SOFT_ENTRY_REG		0x164
> @@ -255,7 +255,7 @@ static int sunxi_cluster_powerup(unsigned int cluster)
>   
>   	/* clear cluster power gate */
>   	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
> -	reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER;
> +	reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
>   	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
>   	udelay(20);
>   
> @@ -452,7 +452,7 @@ static int sunxi_cluster_powerdown(unsigned int cluster)
>   	/* gate cluster power */
>   	pr_debug("%s: gate cluster power\n", __func__);
>   	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
> -	reg |= PRCM_PWROFF_GATING_REG_CLUSTER;
> +	reg |= PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
>   	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
>   	udelay(20);
>   

MBR, Sergei
