From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Sep 2012 16:32:05 -0700
Subject: [PATCH v5 1/5] arm/dts: AM33XX: Add basic pinctrl device tree data
In-Reply-To: <1346405361-29711-2-git-send-email-anilkumar@ti.com>
References: <1346405361-29711-1-git-send-email-anilkumar@ti.com>
 <1346405361-29711-2-git-send-email-anilkumar@ti.com>
Message-ID: <20120905233205.GO1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* AnilKumar Ch <anilkumar@ti.com> [120831 02:30]:
> Adds basic pinctrl device tree data for AM33XX family of devices.
> This patch is based on the pinctrl-single driver.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index be43511..bf5f713 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -40,6 +40,15 @@
>  		};
>  	};
>  
> +	am3358_pinmux: pinmux at 44e10800 {
> +		compatible = "pinctrl-single";
> +		reg = <0x44e10800 0x0238>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0x7f>;
> +	};
> +

Is this controller the same for all am33xx? If so, please use
am33xx_pinmux naming. Note that some padconf registers may not
be listed for all the variants, but the registers may still be
there for all the variants. So a generic entry is a better
choice here as otherwise you'l need to include am33xx.dtsi into
am3358.dtsi.

Regards,

Tony
