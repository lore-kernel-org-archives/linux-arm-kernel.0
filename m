From: bcousson@baylibre.com (Benoit Cousson)
Date: Tue, 13 Aug 2013 15:21:19 +0200
Subject: [PATCH] arm: omap5: dts: split SMPS10 dt node
In-Reply-To: <1376300221-15172-1-git-send-email-kishon@ti.com>
References: <1376300221-15172-1-git-send-email-kishon@ti.com>
Message-ID: <520A32CF.1010701@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On 12/08/2013 11:37, Kishon Vijay Abraham I wrote:
> SMPS10 has two outputs OUT1 and OUT2. Hence SMPS10 is modeled as
> two regulators. The dt node is split to reflect it.

Mmm, I'm curious. How is it supposed to work?

Do you have dedicated control on each output?

Otherwise, it should be seen as one output with two potential consumers.

Regards,
Benoit

>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   arch/arm/boot/dts/omap5-uevm.dts |   13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 65d7b60..05b9b12 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -334,9 +334,18 @@
>   					ti,smps-range = <0x80>;
>   				};
>
> -				smps10_reg: smps10 {
> +				smps10_out2_reg: smps10_out2 {
>   					/* VBUS_5V_OTG */
> -					regulator-name = "smps10";
> +					regulator-name = "smps10_out2";
> +					regulator-min-microvolt = <5000000>;
> +					regulator-max-microvolt = <5000000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> +
> +				smps10_out1_reg: smps10_out1 {
> +					/* VBUS_5V_OTG */
> +					regulator-name = "smps10_out1";
>   					regulator-min-microvolt = <5000000>;
>   					regulator-max-microvolt = <5000000>;
>   					regulator-always-on;
>
