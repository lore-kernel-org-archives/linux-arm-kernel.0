From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Jul 2012 09:40:11 +0800
Subject: [PATCH v6 4/7] ARM: dts: imx6q-sabrelite: add usb devices
In-Reply-To: <1342006425-21008-5-git-send-email-richard.zhao@freescale.com>
References: <1342006425-21008-1-git-send-email-richard.zhao@freescale.com>
 <1342006425-21008-5-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120712014009.GD6971@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 07:33:42PM +0800, Richard Zhao wrote:
> - add usbphy devices
> - add usb host controller and otg devices
> - add on-board hub reset gpio pinctrl
> - add usb h1 vbus regulator
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts |   28 +++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6q.dtsi          |   36 +++++++++++++++++++++++++++++++--
>  2 files changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index e0ec929..5bba0d1 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -41,10 +41,29 @@
>  					status = "okay";
>  				};
>  			};
> +			iomuxc at 020e0000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_gpio_hog>;
>  
> +				gpios {
> +					pinctrl_gpio_hog: gpiohog {
> +						fsl,pins = <1044 0x80000000	/* MX6Q_PAD_GPIO_17__GPIO_7_12 */

I guess this one is used for on-board hub reset.  Since you are using
it nowhere, please drop it for now.

Regards,
Shawn

> +							   144  0x80000000>;	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
> +					};
> +				};
> +			};
>  		};
