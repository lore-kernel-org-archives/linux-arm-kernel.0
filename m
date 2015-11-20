From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Nov 2015 08:37:18 -0600
Subject: [PATCH v2 5/6] dt-bindings: add binding for marvell berlin4ct SoC
In-Reply-To: <1448008952-1787-6-git-send-email-jszhang@marvell.com>
References: <1448008952-1787-1-git-send-email-jszhang@marvell.com>
 <1448008952-1787-6-git-send-email-jszhang@marvell.com>
Message-ID: <20151120143718.GA9883@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 04:42:31PM +0800, Jisheng Zhang wrote:
> This adds a dt-binding include for Marvell berlin4ct clock IDs.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Acked-by: Rob Herring <robh@kernel.org>

One typo below though.

> +Required Properties:
> +
> +- compatible: should be one of the following.
> +  - "marvell,berlin-pll" - pll compatible
> +  - "marvell,berlin4ct-clk" - berlin clk compatible
> +  - "marvell,berlin4ct-gateclk" - gateclk compatible
> +- reg: physical base address of the clock controller and length of memory mapped
> +  region. For pll, the second reg defines the bypass register base address and
> +  length of memory mapped region.
> +- #clock-cells: for pll should 0, for gateclk and berlin clk should be 1.
> +- #bypass-shift: the bypass bit in bypass register.
     ^

This should be dropped.

> +
> +Example:
> +
> +syspll: syspll {
> +	compatible = "marvell,berlin-pll";
> +	reg = <0xea0200 0x14>, <0xea0710 4>;
> +	#clock-cells = <0>;
> +	clocks = <&osc>;
> +	bypass-shift = /bits/ 8 <0>;
> +};
