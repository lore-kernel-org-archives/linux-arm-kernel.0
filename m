From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 31 Jul 2014 18:24:26 +0400
Subject: [PATCH 5/6] ARM: DTS: da850-evm: Add node for tlv320aic3106 codec
In-Reply-To: <1406801934-23334-6-git-send-email-peter.ujfalusi@ti.com>
References: <1406801934-23334-1-git-send-email-peter.ujfalusi@ti.com>
 <1406801934-23334-6-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <53DA519A.4090905@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/31/2014 02:18 PM, Peter Ujfalusi wrote:

> The board uses aic3106 for audio.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   arch/arm/boot/dts/da850-evm.dts | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index 09118c72e83f..b9ef2be0b145 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -51,6 +51,20 @@
>   			tps: tps at 48 {
>   				reg = <0x48>;
>   			};
> +			tlv320aic3106: tlv320aic3106 at 1b {

    The "reg" property is <0x18>, why the unit-address part of a name is 
different? Also, the ePAPR standard [1] says:

The name of a node should be somewhat generic, reflecting the function of the 
device and not its precise programming model.

> +				#sound-dai-cells = <0>;
> +				compatible = "ti,tlv320aic3106";
> +				reg = <0x18>;
> +				status = "okay";
> +
> +				/* Regulators */
> +				IOVDD-supply = <&vdcdc2_reg>;
> +				/* Derived from VBAT: Baseboard 3.3V / 1.8V */
> +				AVDD-supply = <&vbat>;
> +				DRVDD-supply = <&vbat>;
> +				DVDD-supply = <&vbat>;
> +			};
> +

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei
