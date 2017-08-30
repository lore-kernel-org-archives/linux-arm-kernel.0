From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Aug 2017 15:51:02 +0200
Subject: [PATCH] arm64: dts: marvell: fix number of GPIOs in Armada AP806
 description
In-Reply-To: <20170830101537.8260-1-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Wed, 30 Aug 2017 12:15:37 +0200")
References: <20170830101537.8260-1-thomas.petazzoni@free-electrons.com>
Message-ID: <874lsp4115.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mer., ao?t 30 2017, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> The Armada AP806 has 20 pins, and therefore 20 GPIOs (from 0 to 19
> included) and not 19 pins. Therefore, we fix the Device Tree
> description for the GPIO controller.
>
> Before this patch:
>
> $ cat /sys/kernel/debug/pinctrl/f06f4000.system-controller:pinctrl/gpio-ranges
> GPIO ranges handled:
> 0: mvebu-gpio GPIOS [0 - 19] PINS [0 - 19]
> 0: f06f4000.system-controller:gpio GPIOS [0 - 18] PINS [0 - 18]
>
> After this patch:
>
> $ cat /sys/kernel/debug/pinctrl/f06f4000.system-controller:pinctrl/gpio-ranges
> GPIO ranges handled:
> 0: mvebu-gpio GPIOS [0 - 19] PINS [0 - 19]
> 0: f06f4000.system-controller:gpio GPIOS [0 - 19] PINS [0 - 19]
>
> Fixes: 63dac0f4924b9 ("arm64: dts: marvell: add gpio support for Armada 7K/8K")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied on mvebu/fixes

Thanks,

Gregory

> ---
> Note: this is a fix, that should go in the 4.13 cycle, as
> 63dac0f4924b9 was introduced in 4.13.
> ---
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 1eb1f1e..4d36071 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -268,10 +268,10 @@
>  				ap_gpio: gpio {
>  					compatible = "marvell,armada-8k-gpio";
>  					offset = <0x1040>;
> -					ngpios = <19>;
> +					ngpios = <20>;
>  					gpio-controller;
>  					#gpio-cells = <2>;
> -					gpio-ranges = <&ap_pinctrl 0 0 19>;
> +					gpio-ranges = <&ap_pinctrl 0 0 20>;
>  				};
>  			};
>  		};
> -- 
> 2.9.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
