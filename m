From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 1 May 2017 15:45:58 +0200
Subject: [PATCH v5 03/20] dt-bindings: net: Add DT bindings documentation
 for Allwinner dwmac-sun8i
In-Reply-To: <20170501124520.3769-4-clabbe.montjoie@gmail.com>
References: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
 <20170501124520.3769-4-clabbe.montjoie@gmail.com>
Message-ID: <20170501134558.GC31281@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 01, 2017 at 02:45:03PM +0200, Corentin Labbe wrote:
> +emac: ethernet at 1c0b000 {
> +	compatible = "allwinner,sun8i-h3-emac";
> +	syscon = <&syscon>;
> +	reg = <0x01c0b000 0x104>;
> +	interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "macirq";
> +	resets = <&ccu RST_BUS_EMAC>;
> +	reset-names = "stmmaceth";
> +	clocks = <&ccu CLK_BUS_EMAC>;
> +	clock-names = "stmmaceth";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	phy = <&int_mii_phy>;

Hi Corentin

Should this be phy-handle?

       Andrew
