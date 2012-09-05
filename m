From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 05 Sep 2012 15:46:58 +0200
Subject: [PATCH RESEND v5 3/3] arm/dts: AM33XX: Add D_CAN device tree data
In-Reply-To: <1346845260-10978-4-git-send-email-anilkumar@ti.com>
References: <1346845260-10978-1-git-send-email-anilkumar@ti.com>
 <1346845260-10978-4-git-send-email-anilkumar@ti.com>
Message-ID: <504757D2.90601@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2012 01:41 PM, AnilKumar Ch wrote:
> Add Bosch D_CAN controller device tree data to AM33XX dtsi
> file by adding d_can device nodes with all the necessary
> parameters.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index bf5f713..ab744d6 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -177,5 +177,23 @@
>  			compatible = "ti,omap3-wdt";
>  			ti,hwmods = "wd_timer2";
>  		};
> +
> +		dcan0: d_can at 481cc000 {
> +			compatible = "bosch,d_can";

On imx/mxs we also add a compatible for the current hardware, this may
look like this:

			compatible = "ti,am33xx-can", "bosch,d_can";

But I don't know if this is a generic policy or just an imx/mxs thing :)

Marc

> +			ti,hwmods = "d_can0";
> +			reg = <0x481cc000 0x2000>;
> +			interrupts = <52>;
> +			interrupt-parent = <&intc>;
> +			status = "disabled";
> +		};
> +
> +		dcan1: d_can at 481d0000 {
> +			compatible = "bosch,d_can";
> +			ti,hwmods = "d_can1";
> +			reg = <0x481d0000 0x2000>;
> +			interrupts = <55>;
> +			interrupt-parent = <&intc>;
> +			status = "disabled";
> +		};
>  	};
>  };
> 


-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120905/e976f849/attachment.sig>
