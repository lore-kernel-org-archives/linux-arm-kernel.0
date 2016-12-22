From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Thu, 22 Dec 2016 10:06:55 -0600
Subject: [3/3] ARM: da850: Add ti, da830-uart compatible for serial ports
In-Reply-To: <1482265384-715-4-git-send-email-david@lechnology.com>
References: <1482265384-715-4-git-send-email-david@lechnology.com>
Message-ID: <2982bdd0-0997-f4a7-71c3-9d232237cc23@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/20/2016 02:23 PM, David Lechner wrote:
> TI DA8xx/OMAPL13x/AM17xx/AM18xx SoCs have extra UART registers beyond

Similar comment about adding Keystone SoCs to the list of SoCs.

> the standard 8250 registers, so we need a new compatible string to
> indicate this. Also, at least one of these registers uses the full 32
> bits, so we need to specify reg-io-width in addition to reg-shift.
> 
> "ns16550a" is left in the compatible specification since it does work
> as long as the bootloader configures the SoC UART power management
> registers.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  arch/arm/boot/dts/da850.dtsi | 9 ++++++---

Similar changes should be made to the various Keystone dtsi files.

>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 104155d..f6cd212 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -266,22 +266,25 @@
>  			interrupt-names = "edm3_tcerrint";
>  		};
>  		serial0: serial at 42000 {
> -			compatible = "ns16550a";
> +			compatible = "ti,da830-uart", "ns16550a";
>  			reg = <0x42000 0x100>;
> +			reg-io-width = <4>;
>  			reg-shift = <2>;
>  			interrupts = <25>;
>  			status = "disabled";
>  		};
>  		serial1: serial at 10c000 {
> -			compatible = "ns16550a";
> +			compatible = "ti,da830-uart", "ns16550a";
>  			reg = <0x10c000 0x100>;
> +			reg-io-width = <4>;
>  			reg-shift = <2>;
>  			interrupts = <53>;
>  			status = "disabled";
>  		};
>  		serial2: serial at 10d000 {
> -			compatible = "ns16550a";
> +			compatible = "ti,da830-uart", "ns16550a";
>  			reg = <0x10d000 0x100>;
> +			reg-io-width = <4>;
>  			reg-shift = <2>;
>  			interrupts = <61>;
>  			status = "disabled";
> 
