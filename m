From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Sep 2015 17:51:52 +0200
Subject: [PATCH 1/4] ARM: sunxi: Introduce Allwinner for A83T support
In-Reply-To: <1442936337-3104-2-git-send-email-vishnupatekar0510@gmail.com>
References: <1442936337-3104-1-git-send-email-vishnupatekar0510@gmail.com>
 <1442936337-3104-2-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20150922155152.GJ4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 22, 2015 at 11:38:54PM +0800, Vishnu Patekar wrote:
> Allwinner A83T is octa-core cortex-a7 based SoC.
> It's clock control unit and prcm, pinmux are different from previous sun8i
> series.
> Its processor cores are arragned in two clusters 4 cores each,
> similar to A80.
> 
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
>  arch/arm/mach-sunxi/sunxi.c                     | 1 +
>  drivers/clk/sunxi/clk-sunxi.c                   | 6 ++++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
> index 67da205..cf5ed27 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.txt
> +++ b/Documentation/devicetree/bindings/arm/sunxi.txt
> @@ -11,4 +11,5 @@ using one of the following compatible strings:
>    allwinner,sun8i-a23
>    allwinner,sun8i-a33
>    allwinner,sun8i-h3
> +  allwinner,sun8i-a83t
>    allwinner,sun9i-a80
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 65bab28..b04aefa 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -69,6 +69,7 @@ static const char * const sun8i_board_dt_compat[] = {
>  	"allwinner,sun8i-a23",
>  	"allwinner,sun8i-a33",
>  	"allwinner,sun8i-h3",
> +	"allwinner,sun8i-a83t",
>  	NULL,
>  };
>  
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 413070d..f216d5d 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -1212,6 +1212,12 @@ CLK_OF_DECLARE(sun6i_a31s_clk_init, "allwinner,sun6i-a31s", sun6i_init_clocks);
>  CLK_OF_DECLARE(sun8i_a23_clk_init, "allwinner,sun8i-a23", sun6i_init_clocks);
>  CLK_OF_DECLARE(sun8i_a33_clk_init, "allwinner,sun8i-a33", sun6i_init_clocks);
>  
> +static void __init sun8ia83t_init_clocks(struct device_node *node)

Having an underscore between sun8i and a83t would be great :)

> +{
> +	sunxi_init_clocks(NULL, 0);
> +}
> +CLK_OF_DECLARE(sun9i_a83t_clk_init, "allwinner,sun8i-a83t", sun8ia83t_init_clocks);

                  ^ Is this a sun9i or sun8i SoC ?

Is the list of protected clocks always going to be empty, or will you
add some new clocks in that list in the future?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150922/ecdd8627/attachment-0001.sig>
