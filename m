From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 18 Mar 2018 23:57:39 +0200
Subject: [PATCH v5 3/4] clk: lpc32xx: Set name of regmap_config
In-Reply-To: <20180312095142.30854-4-jeffy.chen@rock-chips.com>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
 <20180312095142.30854-4-jeffy.chen@rock-chips.com>
Message-ID: <23a9cbf8-9b1d-f7ec-b980-a16c9b2c4d84@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

On 03/12/2018 11:51 AM, Jeffy Chen wrote:
> We are now allowing to register debugfs without a valid device, and not
> having a valid name will end up using "dummy*" to create debugfs dir.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> 
>  drivers/clk/nxp/clk-lpc32xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
> index f5d815f577e0..a2a0a7f3bc57 100644
> --- a/drivers/clk/nxp/clk-lpc32xx.c
> +++ b/drivers/clk/nxp/clk-lpc32xx.c
> @@ -67,6 +67,7 @@
>  #define LPC32XX_USB_CLK_STS		0xF8
>  
>  static struct regmap_config lpc32xx_scb_regmap_config = {
> +	.name = "lpc32xx-scb",

please rename it to "scb", LPC32xx SoC name is already known from the context.

When it's done, feel free to add to the next version my

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

>  	.reg_bits = 32,
>  	.val_bits = 32,
>  	.reg_stride = 4,
> 

Thank you for the change.

--
With best wishes,
Vladimir
