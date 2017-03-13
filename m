From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Mar 2017 14:15:21 -0700
Subject: [PATCH 3/4] ARM: dts: dm8168-evm: add SATA node
In-Reply-To: <1489423399-3824-4-git-send-email-bgolaszewski@baylibre.com>
References: <1489423399-3824-1-git-send-email-bgolaszewski@baylibre.com>
 <1489423399-3824-4-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <20170313211520.GW20572@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Bartosz Golaszewski <bgolaszewski@baylibre.com> [170313 09:45]:
> Add the SATA controller node to the dm8168-evm device tree.
> --- a/arch/arm/boot/dts/dm816x.dtsi
> +++ b/arch/arm/boot/dts/dm816x.dtsi
> @@ -293,6 +293,13 @@
>  			phy-handle = <&phy1>;
>  		};
>  
> +		sata: sata at 4a140000 {
> +			compatible = "ti,dm816-ahci";
> +			reg = <0x4a140000 0xffff>;
> +			interrupts = <16>;
> +			ti,hwmods = "sata";
> +		};

The size should be 0x10000 instead of 0xffff, right?

Tony
