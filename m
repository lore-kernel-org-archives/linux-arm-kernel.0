From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 24 Sep 2012 15:52:29 +0400
Subject: [PATCH 3/3] ARM: dts: cfa10049: Add the i2c muxer buses to the
 CFA-10049
In-Reply-To: <1348480425-13848-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1348474926-12763-1-git-send-email-maxime.ripard@free-electrons.com>
 <1348480425-13848-1-git-send-email-maxime.ripard@free-electrons.com>
 <1348480425-13848-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <5060497D.9090104@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 24-09-2012 13:53, Maxime Ripard wrote:

> This will allow to add the 3 Nuvoton NAU7802 ADCs and the NXP PCA9555
> GPIO expander eventually.

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>   arch/arm/boot/dts/imx28-cfa10049.dts |   33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)

> diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
> index a9288fb..9a55632 100644
> --- a/arch/arm/boot/dts/imx28-cfa10049.dts
> +++ b/arch/arm/boot/dts/imx28-cfa10049.dts
> @@ -76,6 +76,39 @@
>   				status = "okay";
>   			};
>
> +			i2cmux {
> +				compatible = "i2c-mux-gpio";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				mux-gpios = <&gpio1 22 0 &gpio1 23 0>;
> +				i2c-parent = <&i2c1>;
> +
> +				i2c at 0 {
> +					reg = <0>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;

    If you don't have any subnodes the above to props have no sense.

> +				};
> +

WBR, Sergei
