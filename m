From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 27 Jun 2013 22:42:57 +0800
Subject: [PATCH 2/2] ARM i.MX6Q: Use ENET_CLK_SEL defines in
 imx6q_1588_init
In-Reply-To: <1372252129-18898-2-git-send-email-p.zabel@pengutronix.de>
References: <1372252129-18898-1-git-send-email-p.zabel@pengutronix.de>
 <1372252129-18898-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130627144255.GE2695@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 03:08:49PM +0200, Philipp Zabel wrote:
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  arch/arm/mach-imx/mach-imx6q.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index db1db78..adabe2b 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -242,7 +242,9 @@ static void __init imx6q_1588_init(void)
>  
>  	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
>  	if (!IS_ERR(gpr))
> -		regmap_update_bits(gpr, 0x4, 1 << 21, 1 << 21);
> +		regmap_update_bits(gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_ENET_CLK_SEL_MASK,
> +				IMX6Q_GPR1_ENET_CLK_SEL_ANATOP);

It needs '#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>'.  I fixed it
up and applied both patches.

Shawn

>  	else
>  		pr_err("failed to find fsl,imx6q-iomux-gpr regmap\n");
>  
> -- 
> 1.8.3.1
> 
