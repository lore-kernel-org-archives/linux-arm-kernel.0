From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Jan 2013 09:54:55 -0800
Subject: [PATCH v4 10/14] mmc: omap_hsmmc: add generic DMA request
 support to the DT binding
In-Reply-To: <1357883330-5364-11-git-send-email-mporter@ti.com>
References: <1357883330-5364-1-git-send-email-mporter@ti.com>
 <1357883330-5364-11-git-send-email-mporter@ti.com>
Message-ID: <20130111175454.GI14149@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matt Porter <mporter@ti.com> [130110 21:47]:
> The binding definition is based on the generic DMA request binding.

Acked-by: Tony Lindgren <tony@atomide.com>
 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   25 +++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index ed271fc..826cc51 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -20,8 +20,28 @@ ti,dual-volt: boolean, supports dual voltage cards
>  ti,non-removable: non-removable slot (like eMMC)
>  ti,needs-special-reset: Requires a special softreset sequence
>  ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
> +dmas: DMA controller phandle and DMA request value ordered pair
> +One tx and one rx pair is required.
> +dma-names: DMA request names. These strings correspond 1:1 with
> +the ordered pairs in dmas. The RX request must be "rx" and the
> +TX request must be "tx".
> +
> +Examples:
> +
> +[hwmod populated DMA resources]
> +
> +	mmc1: mmc at 0x4809c000 {
> +		compatible = "ti,omap4-hsmmc";
> +		reg = <0x4809c000 0x400>;
> +		ti,hwmods = "mmc1";
> +		ti,dual-volt;
> +		bus-width = <4>;
> +		vmmc-supply = <&vmmc>; /* phandle to regulator node */
> +		ti,non-removable;
> +	};
> +
> +[generic DMA request binding]
>  
> -Example:
>  	mmc1: mmc at 0x4809c000 {
>  		compatible = "ti,omap4-hsmmc";
>  		reg = <0x4809c000 0x400>;
> @@ -30,4 +50,7 @@ Example:
>  		bus-width = <4>;
>  		vmmc-supply = <&vmmc>; /* phandle to regulator node */
>  		ti,non-removable;
> +		dmas = <&edma 24
> +			&edma 25>;
> +		dma-names = "tx", "rx";
>  	};
> -- 
> 1.7.9.5
> 
