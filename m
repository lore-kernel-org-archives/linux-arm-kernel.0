From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Mar 2017 09:45:03 -0800
Subject: [PATCH DO NOT MERGE 5/6] ARM: dts: omap4: add some sample
 clkctrl data
In-Reply-To: <1486992157-10673-6-git-send-email-t-kristo@ti.com>
References: <1486992157-10673-1-git-send-email-t-kristo@ti.com>
 <1486992157-10673-6-git-send-email-t-kristo@ti.com>
Message-ID: <20170302174503.GP20572@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Tero Kristo <t-kristo@ti.com> [170213 05:24]:
> Adds clkctrl nodes for cm_l4per and cm_abe as example. Peripherals using
> clocks from these nodes are modified also.

Finally got around testing these. Looks like applying this patch
breaks things for devices not using the new clocks entry?

For example, SPI now breaks causing "imprecise external abort" during boot
at least on droid 4.

> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> +				cm_l4per: cm_l4per at 0 {

Above should be cm_l4per: cm_l4per at 1400, right?

> +					compatible = "ti,omap4-cm";
> +					reg = <0x1400 0x200>;
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					ranges = <0 0x1400 0x200>;
> +
> +					cm_l4per_clkctrl: cm_l4per_clkctrl at 20 {
> +						compatible = "ti,omap4-clkctrl";
> +						reg = <0x20 0x1b0>;
> +						#clock-cells = <2>;
> +					};
> +				};

You should update the binding doc accordingly if the "cm_l4per at 0" node
there is not needed. I also noticed the binding doc still has
"#clock-cells = <4>" while it should be 2.

Regards,

Tony
