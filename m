From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Sep 2012 13:58:12 -0700
Subject: [PATCH v6 2/3] arm/dts: AM33XX: Configure pinmuxs for user
 leds control on Bone
In-Reply-To: <1346845260-10978-3-git-send-email-anilkumar@ti.com>
References: <1346845260-10978-1-git-send-email-anilkumar@ti.com>
 <1346845260-10978-3-git-send-email-anilkumar@ti.com>
Message-ID: <20120906205811.GO1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* AnilKumar Ch <anilkumar@ti.com> [120905 04:42]:
> Adds GPIO pinctrl nodes to am3358_pinmux master node to control
> user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.
> 
> [koen at dominion.thruhere.net: led0, led1 suggested by koen]
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/boot/dts/am335x-bone.dts |   43 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index c634f87..822efe6 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -18,11 +18,54 @@
>  		reg = <0x80000000 0x10000000>; /* 256 MB */
>  	};
>  
> +	am3358_pinmux: pinmux at 44e10800 {
> +		userled_pins: pinmux_userled_pins {
> +			pinctrl-single,pins = <
> +				0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
> +				0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
> +				0x5c 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
> +				0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
> +			>;
> +		};
> +	};
> +

Just checking.. am3358_pinmux should be am33xx_pinmux in this patch
too as discussed.

Regards,

Tony
