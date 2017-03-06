From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 Mar 2017 14:45:36 -0800
Subject: [PATCH DO NOT MERGE 5/6] ARM: dts: omap4: add some sample
 clkctrl data
In-Reply-To: <1486992157-10673-6-git-send-email-t-kristo@ti.com>
References: <1486992157-10673-1-git-send-email-t-kristo@ti.com>
 <1486992157-10673-6-git-send-email-t-kristo@ti.com>
Message-ID: <20170306224535.GP20572@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [170213 05:24]:
> @@ -304,6 +339,8 @@
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> +			clocks = <&cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL 0>;
> +			clock-names = "clkctrl";
>  		};
>  
>  		gpio3: gpio at 48057000 {
> @@ -315,6 +352,8 @@
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> +			clocks = <&cm_l4per_clkctrl OMAP4_GPIO3_CLKCTRL 0>;
> +			clock-names = "clkctrl";
>  		};
>  
>  		gpio4: gpio at 48059000 {
> @@ -384,6 +423,8 @@
>  			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>  			ti,hwmods = "uart1";
>  			clock-frequency = <48000000>;
> +			clocks = <&cm_l4per_clkctrl OMAP4_UART1_CLKCTRL 0>;
> +			clock-names = "clkctrl";
>  		};

BTW, one thing you might want to test also is that the opt clocks
can be mapped here properly for gpios to reset. That can be easily
tested by kexec booting on beagle-x15 where we currently get warnings
on kexec boot about GPIOs failing to reset.

Regards,

Tony
