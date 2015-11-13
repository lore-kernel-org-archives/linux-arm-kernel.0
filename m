From: robh@kernel.org (Rob Herring)
Date: Fri, 13 Nov 2015 08:40:32 -0600
Subject: [PATCH v2 1/9] mfd: axp20x: Add AXP223 to list of supported
 PMICs in DT bindings
In-Reply-To: <1447387456-9912-2-git-send-email-wens@csie.org>
References: <1447387456-9912-1-git-send-email-wens@csie.org>
 <1447387456-9912-2-git-send-email-wens@csie.org>
Message-ID: <20151113144032.GA17530@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2015 at 12:04:06PM +0800, Chen-Yu Tsai wrote:
> The AXP223 is a new PMIC commonly paired with Allwinner A23/A33 SoCs.
> It is functionally identical to AXP221; only the regulator default
> voltage/status and the external host interface are different.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index a474359dd206..fd39fa54571b 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -5,11 +5,12 @@ axp152 (X-Powers)
>  axp202 (X-Powers)
>  axp209 (X-Powers)
>  axp221 (X-Powers)
> +axp223 (X-Powers)
>  
>  Required properties:
>  - compatible: "x-powers,axp152", "x-powers,axp202", "x-powers,axp209",
> -	      "x-powers,axp221"
> -- reg: The I2C slave address for the AXP chip
> +	      "x-powers,axp221", "x-powers,axp223"
> +- reg: The I2C slave address or RSB hardware address for the AXP chip
>  - interrupt-parent: The parent interrupt controller
>  - interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
>  - interrupt-controller: The PMIC has its own internal IRQs
> @@ -51,7 +52,7 @@ LDO3		: LDO		: ldo3in-supply
>  LDO4		: LDO		: ldo24in-supply	: shared supply
>  LDO5		: LDO		: ldo5in-supply
>  
> -AXP221 regulators, type, and corresponding input supply names:
> +AXP221/AXP223 regulators, type, and corresponding input supply names:
>  
>  Regulator	  Type		  Supply Name		  Notes
>  ---------	  ----		  -----------		  -----
> -- 
> 2.6.2
> 
