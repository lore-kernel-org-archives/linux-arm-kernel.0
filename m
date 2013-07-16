From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 16 Jul 2013 18:22:08 +0400
Subject: [PATCH v4 1/2] ARM: dts: twl: Add GPADC data to device tree
In-Reply-To: <1373974500-23609-1-git-send-email-oleksandr.kozaruk@ti.com>
References: <1373974500-23609-1-git-send-email-oleksandr.kozaruk@ti.com>
Message-ID: <51E55710.8060907@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/16/2013 03:34 PM, Oleksandr Kozaruk wrote:

> GPADC is the general purpose ADC present on twl6030.
> The dt data is interrupt used to trigger end of ADC
> conversion.

> Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
> ---
>   arch/arm/boot/dts/twl6030.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)

> diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
> index 2e3bd31..434842c 100644
> --- a/arch/arm/boot/dts/twl6030.dtsi
> +++ b/arch/arm/boot/dts/twl6030.dtsi
> @@ -103,4 +103,10 @@
>   		compatible = "ti,twl6030-pwmled";
>   		#pwm-cells = <2>;
>   	};
> +
> +	gpadc: twl6030_gpadc {
> +		compatible = "ti,twl6030_gpadc";
> +		interrupts = <3>;
> +		#io-channel-cells = <1>;
> +	};

    ePAPR [1] says: "The name of a node should be somewhat generic, 
reflecting the function of the device and not its precise programming 
model."

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei
