From: bcousson@baylibre.com (Benoit Cousson)
Date: Tue, 22 Oct 2013 14:48:45 +0200
Subject: [RFCv3 7/7] ARM: dts: N900: Add SSI information
In-Reply-To: <1381091235-18293-8-git-send-email-sre@debian.org>
References: <1381091235-18293-1-git-send-email-sre@debian.org>
 <1381091235-18293-8-git-send-email-sre@debian.org>
Message-ID: <5266742D.9050604@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

Thanks to Tony, I've just realized that I missed all your patches, that 
for some reason ended-up in my junk folder :-(

That being said, I cannot apply any of your DTS patches! What base 
branch are you using?

Could you repost all your pending DTS patches in one series rebased on 
top of my for_3.13/dts?

Thanks,
Benoit

On 06/10/2013 22:27, Sebastian Reichel wrote:
> Add SSI device tree data for OMAP3 and Nokia N900.
>
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> ---
>   arch/arm/boot/dts/omap3-n900.dts | 12 ++++++++++
>   arch/arm/boot/dts/omap3.dtsi     | 47 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 59 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 0582356..0fbb77e 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -186,6 +186,18 @@
>   	power = <50>;
>   };
>
> +&ssi_port1 {
> +	ti,ssi-cawake-gpio = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
> +
> +	ssi-char {
> +		compatible = "ssi-char";
> +	};
> +};
> +
> +&ssi_port2 {
> +	status = "disabled";
> +};
> +
>   &uart1 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&uart1_pins>;
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 7d95cda..9f60b82 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -532,5 +532,52 @@
>   			num-eps = <16>;
>   			ram-bits = <12>;
>   		};
> +
> +		ssi: ssi-controller at 48058000 {
> +			compatible = "ti,omap3-ssi";
> +			ti,hwmods = "ssi";
> +
> +			reg = <0x48058000 0x1000>,
> +			      <0x48059000 0x1000>;
> +			reg-names = "sys",
> +				    "gdd";
> +
> +			interrupts = <71>;
> +			interrupt-names = "gdd_mpu";
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			ssi_port1: ssi-port at 0 {
> +				compatible = "ti,omap3-ssi-port";
> +
> +				reg = <0x4805a000 0x800>,
> +				      <0x4805a800 0x800>;
> +				reg-names = "tx",
> +					    "rx";
> +
> +				interrupt-parent = <&intc>;
> +				interrupts = <67>,
> +					     <68>;
> +				interrupt-names = "mpu_irq0",
> +						  "mpu_irq1";
> +			};
> +
> +			ssi_port2: ssi-port at 1 {
> +				compatible = "ti,omap3-ssi-port";
> +
> +				reg = <0x4805b000 0x800>,
> +				      <0x4805b800 0x800>;
> +				reg-names = "tx",
> +					    "rx";
> +
> +				interrupt-parent = <&intc>;
> +				interrupts = <69>,
> +					     <70>;
> +				interrupt-names = "mpu_irq0",
> +						  "mpu_irq1";
> +			};
> +		};
>   	};
>   };
>


-- 
Beno?t Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
