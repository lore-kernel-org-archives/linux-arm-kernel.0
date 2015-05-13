From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 13 May 2015 16:30:55 +0100
Subject: [PATCH RESEND v6 5/6] mfd: axp20x: Add AXP22x regulator
 information to DT bindings
In-Reply-To: <1428638946-24890-6-git-send-email-wens@csie.org>
References: <1428638946-24890-1-git-send-email-wens@csie.org>
 <1428638946-24890-6-git-send-email-wens@csie.org>
Message-ID: <20150513153055.GG3394@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Apr 2015, Chen-Yu Tsai wrote:

> Add the list of regulators for AXP22x to the DT bindings.
> This includes the names and supply names.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 25 ++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 3914a3f91ff6..753f14f46e85 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -49,6 +49,31 @@ LDO3		: LDO		: ldo3in-supply
>  LDO4		: LDO		: ldo24in-supply	: shared supply
>  LDO5		: LDO		: ldo5in-supply
>  
> +AXP221 regulators, type, and corresponding input supply names:
> +
> +Regulator	  Type		  Supply Name		  Notes
> +---------	  ----		  -----------		  -----
> +DCDC1		: DC-DC buck	: vin1-supply
> +DCDC2		: DC-DC buck	: vin2-supply
> +DCDC3		: DC-DC	buck	: vin3-supply
> +DCDC4		: DC-DC	buck	: vin4-supply
> +DCDC5		: DC-DC	buck	: vin5-supply
> +DC1SW		: On/Off Switch	: dcdc1-supply		: DCDC1 secondary output
> +DC5LDO		: LDO		: dcdc5-supply		: input from DCDC5
> +ALDO1		: LDO		: aldoin-supply		: shared supply
> +ALDO2		: LDO		: aldoin-supply		: shared supply
> +ALDO3		: LDO		: aldoin-supply		: shared supply
> +DLDO1		: LDO		: dldoin-supply		: shared supply
> +DLDO2		: LDO		: dldoin-supply		: shared supply
> +DLDO3		: LDO		: dldoin-supply		: shared supply
> +DLDO4		: LDO		: dldoin-supply		: shared supply
> +ELDO1		: LDO		: eldoin-supply		: shared supply
> +ELDO2		: LDO		: eldoin-supply		: shared supply
> +ELDO3		: LDO		: eldoin-supply		: shared supply
> +LDO_IO0		: LDO		: ips-supply		: GPIO 0
> +LDO_IO1		: LDO		: ips-supply		: GPIO 1
> +RTC_LDO		: LDO		: ips-supply		: always on
> +
>  Example:
>  
>  axp209: pmic at 34 {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
