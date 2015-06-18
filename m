From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 18 Jun 2015 07:40:00 +0200
Subject: [PATCH 2/8] ARM: imx: add imx6ul clk tree support
In-Reply-To: <1434555569-8237-3-git-send-email-Frank.Li@freescale.com>
References: <1434555569-8237-1-git-send-email-Frank.Li@freescale.com>
 <1434555569-8237-3-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150618054000.GQ6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 11:39:23PM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> Add imx6ul support
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> Signed-off-by: Bai Ping <b51503@freescale.com>
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  drivers/clk/imx/Makefile                 |   1 +
>  drivers/clk/imx/clk-imx6ul.c             | 436 +++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/imx6ul-clock.h | 240 +++++++++++++++++
>  3 files changed, 677 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-imx6ul.c
>  create mode 100644 include/dt-bindings/clock/imx6ul-clock.h
> 
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 75fae16..1ada68a 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -22,5 +22,6 @@ obj-$(CONFIG_SOC_IMX5)   += clk-imx51-imx53.o
>  obj-$(CONFIG_SOC_IMX6Q)  += clk-imx6q.o
>  obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o
>  obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
> +obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
>  obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
>  obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
> +
> +	clk_register_clkdev(clks[IMX6UL_CLK_GPT1_BUS], "ipg",	"imx-gpt.0");
> +	clk_register_clkdev(clks[IMX6UL_CLK_GPT1_SERIAL], "per", "imx-gpt.0");
> +	clk_register_clkdev(clks[IMX6UL_CLK_GPT_3M], "gpt_3m", "imx-gpt.0");

These are not needed.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
