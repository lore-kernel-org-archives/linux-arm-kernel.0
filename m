From: scott.branden@broadcom.com (Scott Branden)
Date: Thu, 31 Aug 2017 13:10:18 -0700
Subject: [PATCH 2/2] ARM: dts: Add the PWM node to Cygnus
In-Reply-To: <20170831185416.8181-2-eric@anholt.net>
References: <20170831185416.8181-1-eric@anholt.net>
 <20170831185416.8181-2-eric@anholt.net>
Message-ID: <d0f4b326-9efb-5dd2-d7fb-5ccd84f713ba@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pwm node is correct.


On 17-08-31 11:54 AM, Eric Anholt wrote:
> This is connected up to the backlight on 911360_entphn, which we'll
> need for a panel driver.  For now, leave the node disabled in the
> shared dtsi.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   arch/arm/boot/dts/bcm-cygnus.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 74f73ff24aec..b9a654d733ae 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -585,6 +585,14 @@
>   			status = "disabled";
>   		};
>   
> +		pwm: pwm at 180aa500 {
> +			compatible = "brcm,kona-pwm";
> +			reg = <0x180aa500 0xc4>;
> +			#pwm-cells = <3>;
> +			clocks = <&asiu_clks BCM_CYGNUS_ASIU_PWM_CLK>;
> +			status = "disabled";
> +		};
> +
>   		keypad: keypad at 180ac000 {
>   			compatible = "brcm,bcm-keypad";
>   			reg = <0x180ac000 0x14c>;
