From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Dec 2013 13:04:32 +0800
Subject: [PATCH V1 1/7] ARM: dts: imx: pinfunc: add
 MX6QDL_PAD_GPIO_6__ENET_IRQ
In-Reply-To: <1387406497-26430-2-git-send-email-troy.kisky@boundarydevices.com>
References: <1387406497-26430-1-git-send-email-troy.kisky@boundarydevices.com>
 <1387406497-26430-2-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <20131219050430.GS6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 03:41:31PM -0700, Troy Kisky wrote:
> Quoting from Ranjani Vaidyanathan
> 
> All of the interrupts from the ENET block are not routed to
> the GPC block. Hence ENET interrupts are not able to wake
> up the SOC when the system is in WAIT mode. And the ENET
> interrupt gets serviced only when another interrupt causes
> the SOC to exit WAIT mode. This impacts the ENET performance.

We should probably also quote the IMX6Q errata document below.

 http://cache.freescale.com/files/32bit/doc/errata/IMX6DQCE.pdf?fpsp=1

ERR006687 ENET: Only the ENET wake-up interrupt request can wake the
system from Wait mode.

> 
> Adding MX6QDL_PAD_GPIO_6__ENET_IRQ is the 1st step to
> workaround this problem.
> 
> The input reg is set to 0x3c to set IOMUX_OBSRV_MUX1 to ENET_IRQ.

It seems this is an undocumented register?  Is the info available
somewhere?

> The mux reg value is 0x11, so that the observable mux is routed to
> this pin and to the gpio controller(sion bit).
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> CC: ra5478 at freescale.com

When having people in the tag, please put their name in there as well,
so Ranjani Vaidyanathan <ra5478@freescale.com> please.

Shawn

> ---
>  arch/arm/boot/dts/imx6dl-pinfunc.h | 1 +
>  arch/arm/boot/dts/imx6q-pinfunc.h  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-pinfunc.h b/arch/arm/boot/dts/imx6dl-pinfunc.h
> index 7499eee..0ead323 100644
> --- a/arch/arm/boot/dts/imx6dl-pinfunc.h
> +++ b/arch/arm/boot/dts/imx6dl-pinfunc.h
> @@ -755,6 +755,7 @@
>  #define MX6QDL_PAD_GPIO_5__I2C3_SCL                 0x230 0x600 0x878 0x6 0x2
>  #define MX6QDL_PAD_GPIO_5__ARM_EVENTI               0x230 0x600 0x000 0x7 0x0
>  #define MX6QDL_PAD_GPIO_6__ESAI_TX_CLK              0x234 0x604 0x840 0x0 0x1
> +#define MX6QDL_PAD_GPIO_6__ENET_IRQ		    0x234 0x604 0x03c 0x11 0xff000609
>  #define MX6QDL_PAD_GPIO_6__I2C3_SDA                 0x234 0x604 0x87c 0x2 0x2
>  #define MX6QDL_PAD_GPIO_6__GPIO1_IO06               0x234 0x604 0x000 0x5 0x0
>  #define MX6QDL_PAD_GPIO_6__SD2_LCTL                 0x234 0x604 0x000 0x6 0x0
> diff --git a/arch/arm/boot/dts/imx6q-pinfunc.h b/arch/arm/boot/dts/imx6q-pinfunc.h
> index e5834b2..9fc6120 100644
> --- a/arch/arm/boot/dts/imx6q-pinfunc.h
> +++ b/arch/arm/boot/dts/imx6q-pinfunc.h
> @@ -673,6 +673,7 @@
>  #define MX6QDL_PAD_GPIO_3__USB_H1_OC                0x22c 0x5fc 0x948 0x6 0x1
>  #define MX6QDL_PAD_GPIO_3__MLB_CLK                  0x22c 0x5fc 0x900 0x7 0x1
>  #define MX6QDL_PAD_GPIO_6__ESAI_TX_CLK              0x230 0x600 0x870 0x0 0x1
> +#define MX6QDL_PAD_GPIO_6__ENET_IRQ		    0x230 0x600 0x03c 0x11 0xff000609
>  #define MX6QDL_PAD_GPIO_6__I2C3_SDA                 0x230 0x600 0x8ac 0x2 0x1
>  #define MX6QDL_PAD_GPIO_6__GPIO1_IO06               0x230 0x600 0x000 0x5 0x0
>  #define MX6QDL_PAD_GPIO_6__SD2_LCTL                 0x230 0x600 0x000 0x6 0x0
> -- 
> 1.8.1.2
> 
