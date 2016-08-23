From: robh@kernel.org (Rob Herring)
Date: Tue, 23 Aug 2016 12:51:20 -0500
Subject: [PATCH 1/9] mfd: axp20x: Add bindings for AXP806 PMIC
In-Reply-To: <20160821021125.1521-2-wens@csie.org>
References: <20160821021125.1521-1-wens@csie.org>
 <20160821021125.1521-2-wens@csie.org>
Message-ID: <20160823175120.GA26572@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2016 at 10:11:17AM +0800, Chen-Yu Tsai wrote:
> This patch adds the basic and regulator bindings for the X-Powers AXP809
> PMIC.

Looks like you're adding the AXP806 to me.

> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 28 ++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 585a95546288..8f3ad9ab4637 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -10,7 +10,8 @@ axp809 (X-Powers)
>  
>  Required properties:
>  - compatible: "x-powers,axp152", "x-powers,axp202", "x-powers,axp209",
> -	      "x-powers,axp221", "x-powers,axp223", "x-powers,axp809"
> +	      "x-powers,axp221", "x-powers,axp223", "x-powers,axp806",
> +	      "x-powers,axp809"

Reformat this to one valid combination per line.

>  - reg: The I2C slave address or RSB hardware address for the AXP chip
>  - interrupt-parent: The parent interrupt controller
>  - interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
> @@ -47,7 +48,6 @@ Optional properties for DCDC regulators:
>  			  probably makes sense for HiFi audio related
>  			  applications that aren't battery constrained.
>  
> -
>  AXP202/AXP209 regulators, type, and corresponding input supply names:
>  
>  Regulator	  Type		  Supply Name		  Notes
> @@ -86,6 +86,30 @@ LDO_IO1		: LDO		: ips-supply		: GPIO 1
>  RTC_LDO		: LDO		: ips-supply		: always on
>  DRIVEVBUS	: Enable output	: drivevbus-supply	: external regulator
>  
> +AXP806 regulators, type, and corresponding input supply names:
> +
> +Regulator	  Type		  Supply Name		  Notes
> +---------	  ----		  -----------		  -----
> +DCDCA		: DC-DC buck	: vina-supply		: poly-phase capable
> +DCDCB		: DC-DC buck	: vinb-supply		: poly-phase capable
> +DCDCC		: DC-DC	buck	: vinc-supply		: poly-phase capable
> +DCDCD		: DC-DC	buck	: vind-supply		: poly-phase capable
> +DCDCE		: DC-DC	buck	: vine-supply		: poly-phase capable
> +ALDO1		: LDO		: aldoin-supply		: shared supply
> +ALDO2		: LDO		: aldoin-supply		: shared supply
> +ALDO3		: LDO		: aldoin-supply		: shared supply
> +BLDO1		: LDO		: bldoin-supply		: shared supply
> +BLDO2		: LDO		: bldoin-supply		: shared supply
> +BLDO3		: LDO		: bldoin-supply		: shared supply
> +BLDO4		: LDO		: bldoin-supply		: shared supply
> +CLDO1		: LDO		: cldoin-supply		: shared supply
> +CLDO2		: LDO		: cldoin-supply		: shared supply
> +CLDO3		: LDO		: cldoin-supply		: shared supply
> +SW		: On/Off Switch : swin-supply
> +
> +Additionally, the AXP806 DC-DC regulators support poly-phase arrangements
> +for higher output current. The possible groupings are: A+B, A+B+C, D+E.
> +
>  AXP809 regulators, type, and corresponding input supply names:
>  
>  Regulator	  Type		  Supply Name		  Notes
> -- 
> 2.9.3
> 
