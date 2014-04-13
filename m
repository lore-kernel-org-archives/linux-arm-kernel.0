From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 13 Apr 2014 17:28:40 +0200
Subject: [PATCH 21/29] ARM: orion5x: use DT to describe I2C devices on
 edmini_v2
In-Reply-To: <1397400006-4315-22-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-22-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140413152840.GC10033@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 13, 2014 at 04:39:58PM +0200, Thomas Petazzoni wrote:
> This commit converts the already partially DT-converted edmini_v2
> platform to use the Device Tree for I2C bus and devices.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    | 14 +++++++++++++
>  arch/arm/mach-orion5x/edmini_v2-setup.c            | 24 ----------------------
>  2 files changed, 14 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> index eee42f7..f077b7b 100644
> --- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> +++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> @@ -10,6 +10,7 @@
>  
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
>  #include "orion5x-mv88f5182.dtsi"
>  
>  / {
> @@ -54,6 +55,19 @@
>  				};
>  			};
>  
> +			i2c at 11000 {
> +				status = "okay";
> +				clock-frequency = <100000>;
> +				#address-cells = <1>;
> +
> +				rtc at 32 {
> +					compatible = "rs5c372a";

Hi Thomas

This should have a vendor prefix.

     Andrew
