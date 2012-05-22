From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 22 May 2012 13:10:08 +0800
Subject: [PATCH v2 10/12] ARM: dts: imx6q-sabrelite: add usb devices
In-Reply-To: <1337592237-5090-11-git-send-email-richard.zhao@freescale.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-11-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120522051005.GN8140@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 05:23:55PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts |   18 ++++++++++++-
>  arch/arm/boot/dts/imx6q.dtsi          |   44 +++++++++++++++++++++++++++++++-
>  2 files changed, 59 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index 1dd2261..1d28957 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -48,10 +48,26 @@
>  					status = "okay";
>  				};
>  			};
> -
> +			iomuxc at 020e0000 {
> +				gpios {
> +					pinctrl_gpio_hog: gpiohog {

This isn't really welcomed, and should really be removed after we have
gpio_request() be able to call pinctrl to set the mux.

> +						fsl,pins = <1044 0x80000000
> +							   144  0x80000000>;	/* MX6Q_PAD_GPIO_17__GPIO_7_12 */

Here are what I get from fsl,imx6q-pinctrl.txt.  The comment was put on
the wrong line?

MX6Q_PAD_EIM_D22__GPIO_3_22                     144
MX6Q_PAD_GPIO_17__GPIO_7_12                     1044 

> +					};
> +				};
> +			};
>  		};
>  
...

> @@ -495,6 +500,11 @@
>  					};
>  				};
>  
> +				gpios {
> +					pinctrl_gpio_hog: gpiohog {
> +					};
> +				};
> +
Why the empty nodes?

-- 
Regards,
Shawn
