From: lee.jones@linaro.org (Lee Jones)
Date: Sun, 20 Sep 2015 05:17:22 +0100
Subject: [PATCH 1/3] mfd: axp20x: Rename supply names for AXP221 DC1SW
 and DC5LDO regulators
In-Reply-To: <1442372732-27434-2-git-send-email-wens@csie.org>
References: <1442372732-27434-1-git-send-email-wens@csie.org>
 <1442372732-27434-2-git-send-email-wens@csie.org>
Message-ID: <20150920041722.GI3039@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Sep 2015, Chen-Yu Tsai wrote:

> The DC1SW and DC5LDO regulators in the AXP221 are internally chained
> to DCDC1 and DCDC5, hence the names. The original bindings used the
> parent regulator names for the supply regulator property. This causes
> some confusion when we actually use it in the dts:
> 
> 	axp221 {
> 		/* self supplying? */
> 		dcdc1-supply = <&dcdc1>;
> 		dcdc5-supply = <&dcdc5>;
> 
> 		dcdc1: dcdc1 {
> 			...
> 		};
> 
> 		dcdc5: dcdc5 {
> 			...
> 		};
> 	};
> 
> Change them to the downstream regulator names, or "dc1sw" and "dc5ldo"
> respectively.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 41811223e5be..8e79252b1e7c 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -60,8 +60,8 @@ DCDC2		: DC-DC buck	: vin2-supply
>  DCDC3		: DC-DC	buck	: vin3-supply
>  DCDC4		: DC-DC	buck	: vin4-supply
>  DCDC5		: DC-DC	buck	: vin5-supply
> -DC1SW		: On/Off Switch	: dcdc1-supply		: DCDC1 secondary output
> -DC5LDO		: LDO		: dcdc5-supply		: input from DCDC5
> +DC1SW		: On/Off Switch	: dc1sw-supply		: DCDC1 secondary output
> +DC5LDO		: LDO		: dc5ldo-supply		: input from DCDC5
>  ALDO1		: LDO		: aldoin-supply		: shared supply
>  ALDO2		: LDO		: aldoin-supply		: shared supply
>  ALDO3		: LDO		: aldoin-supply		: shared supply

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
