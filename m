From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 21 Oct 2012 08:55:52 +0200
Subject: [PATCH 2/2] ARM: kirkwood: use gpio-fan DT binding on lsxl
In-Reply-To: <1350776094-16778-2-git-send-email-michael@walle.cc>
References: <1350776094-16778-1-git-send-email-michael@walle.cc>
 <1350776094-16778-2-git-send-email-michael@walle.cc>
Message-ID: <20121021065552.GH21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2012 at 01:34:54AM +0200, Michael Walle wrote:
> Remove board specific gpio-fan driver registration. Moved into device tree.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm/boot/dts/kirkwood-lsxl.dtsi |   11 ++++++++
>  arch/arm/mach-kirkwood/board-lsxl.c  |   47 ----------------------------------
>  2 files changed, 11 insertions(+), 47 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> index 8fea375..798e60e 100644
> --- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> @@ -94,4 +94,15 @@
>  			gpios = <&gpio1 16 1>;
>  		};
>  	};
> +
> +	gpio_fan {
> +		compatible = "gpio-fan";
> +		gpios = <&gpio0 19 1
> +		         &gpio0 18 1>;
> +		gpio-fan,speed-map = <0    3
> +		                      1500 2
> +		                      3250 1
> +		                      5000 0>;
> +		alarm-gpios = <&gpio1 8 0>;
> +	};
>  };
> diff --git a/arch/arm/mach-kirkwood/board-lsxl.c b/arch/arm/mach-kirkwood/board-lsxl.c
> index 64e5cc6..7e18cad 100644
> --- a/arch/arm/mach-kirkwood/board-lsxl.c
> +++ b/arch/arm/mach-kirkwood/board-lsxl.c
> @@ -16,7 +16,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/mv643xx_eth.h>
>  #include <linux/gpio.h>
> -#include <linux/gpio-fan.h>
>  #include "common.h"
>  #include "mpp.h"

Hi Michael

You might also be able to remove platform_device.h.

Otherwise, it looks good.

	   Andrew
