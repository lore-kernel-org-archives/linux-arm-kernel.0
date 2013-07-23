From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 23 Jul 2013 11:33:13 +0200
Subject: [PATCH RFC 1/8] clk: sunxi: fix initialization of basic clocks
In-Reply-To: <1374541272-32173-2-git-send-email-emilio@elopez.com.ar>
References: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
 <1374541272-32173-2-git-send-email-emilio@elopez.com.ar>
Message-ID: <20130723093313.GB10389@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Mon, Jul 22, 2013 at 10:01:05PM -0300, Emilio L?pez wrote:
> With the recent move towards CLK_OF_DECLARE(...), the driver stopped
> initializing osc32k, which is compatible "fixed-clock". This is because
> we never called of_clk_init(NULL). Fix this by moving the only other
> simple clock (osc24M) to use CLK_OF_DECLARE(...) and call of_clk_init(NULL)
> to initialize both of them.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
>  drivers/clk/sunxi/clk-sunxi.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 412912b..323366b 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -411,10 +411,7 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
>  }
>  
>  /* Matches for of_clk_init */
> -static const __initconst struct of_device_id clk_match[] = {
> -	{.compatible = "allwinner,sun4i-osc-clk", .data = sunxi_osc_clk_setup,},
> -	{}
> -};
> +CLK_OF_DECLARE(sunxi_osc, "allwinner,sun4i-osc-clk", sunxi_osc_clk_setup);

Maybe we can drop the comment and the newline above?

Apart from this nitpick,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130723/2c6476d6/attachment.sig>
