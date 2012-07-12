From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Jul 2012 09:46:43 +0800
Subject: [PATCH v6 5/7] ARM: mxs: clk_register_clkdev mx28 usb clocks
In-Reply-To: <1342006425-21008-6-git-send-email-richard.zhao@freescale.com>
References: <1342006425-21008-1-git-send-email-richard.zhao@freescale.com>
 <1342006425-21008-6-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120712014641.GF6971@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The subject prefix needs to be "clk: mxs: ...", as we will have it
go via clk tree.

Regards,
Shawn

On Wed, Jul 11, 2012 at 07:33:43PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Tested-by: Subodh Nijsure <snijsure@grid-net.com>
> ---
>  drivers/clk/mxs/clk-imx28.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
> index 7fad6c8..a3bb644 100644
> --- a/drivers/clk/mxs/clk-imx28.c
> +++ b/drivers/clk/mxs/clk-imx28.c
> @@ -328,6 +328,10 @@ int __init mx28_clocks_init(void)
>  	clk_register_clkdevs(clks[fec], fec_lookups, ARRAY_SIZE(fec_lookups));
>  	clk_register_clkdevs(clks[can0], can0_lookups, ARRAY_SIZE(can0_lookups));
>  	clk_register_clkdevs(clks[can1], can1_lookups, ARRAY_SIZE(can1_lookups));
> +	clk_register_clkdev(clks[usb0_pwr], NULL, "8007c000.usbphy");
> +	clk_register_clkdev(clks[usb1_pwr], NULL, "8007e000.usbphy");
> +	clk_register_clkdev(clks[usb0], NULL, "80080000.usb");
> +	clk_register_clkdev(clks[usb1], NULL, "80090000.usb");
>  
>  	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
>  		clk_prepare_enable(clks[clks_init_on[i]]);
> -- 
> 1.7.9.5
> 
> 
