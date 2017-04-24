From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 24 Apr 2017 13:09:32 +0100
Subject: [PATCH v3 07/12] dt-bindings: add AXP803's regulator info
In-Reply-To: <20170417115747.7300-8-icenowy@aosc.io>
References: <20170417115747.7300-1-icenowy@aosc.io>
 <20170417115747.7300-8-icenowy@aosc.io>
Message-ID: <20170424120932.sf2hivaviqct7jpd@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Apr 2017, Icenowy Zheng wrote:

> AXP803 have the most regulators in currently supported AXP PMICs.
> 
> Add info for the regulators in the dt-bindings document.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v3:
> - Added Rob's ACK.
> Changes in v2:
> - Place AXP803 regulators before AXP806/809 ones.
> 
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 27 ++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 44df88be3c89..aca09af66514 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -96,6 +96,33 @@ LDO_IO1		: LDO		: ips-supply		: GPIO 1
>  RTC_LDO		: LDO		: ips-supply		: always on
>  DRIVEVBUS	: Enable output	: drivevbus-supply	: external regulator
>  
> +AXP803 regulators, type, and corresponding input supply names:
> +
> +Regulator	  Type		  Supply Name		  Notes
> +---------	  ----		  -----------		  -----
> +DCDC1		: DC-DC buck	: vin1-supply
> +DCDC2		: DC-DC buck	: vin2-supply		: poly-phase capable
> +DCDC3		: DC-DC	buck	: vin3-supply		: poly-phase capable
> +DCDC4		: DC-DC	buck	: vin4-supply
> +DCDC5		: DC-DC	buck	: vin5-supply		: poly-phase capable
> +DCDC6		: DC-DC	buck	: vin6-supply		: poly-phase capable
> +DC1SW		: On/Off Switch	:			: DCDC1 secondary output
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
> +FLDO1		: LDO		: fldoin-supply		: shared supply
> +FLDO2		: LDO		: fldoin-supply		: shared supply
> +LDO_IO0		: LDO		: ips-supply		: GPIO 0
> +LDO_IO1		: LDO		: ips-supply		: GPIO 1
> +RTC_LDO		: LDO		: ips-supply		: always on
> +
>  AXP806 regulators, type, and corresponding input supply names:
>  
>  Regulator	  Type		  Supply Name		  Notes

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
