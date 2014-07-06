From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 06 Jul 2014 19:21:28 +0400
Subject: [PATCH v2 10/8] ARM: sun7i: cubietruck: add an SPIdev device
 for testing
In-Reply-To: <1404619518-7592-11-git-send-email-emilio@elopez.com.ar>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
 <1404619518-7592-11-git-send-email-emilio@elopez.com.ar>
Message-ID: <53B96978.4060001@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/06/2014 08:05 AM, Emilio L?pez wrote:

    You need to sign off on your patches, else they couldn't be applied.

> ---
>   arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index b87fea9..4ef421f 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -66,6 +66,18 @@
>   			status = "okay";
>   		};
>
> +		spi2: spi at 01c17000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&spi2_pins_a>;
> +			status = "okay";
> +
> +			dac0: dh2228 at 2 {

    The ePAPR standard [1] says:

The name of a node should be somewhat generic, reflecting the function of the 
device and not its precise programming model.

> +				compatible = "rohm,dh2228fv";
> +				reg = <2>;
> +				spi-max-frequency = <100000>;
> +			};
> +		};
> +

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei
