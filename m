From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 24 Apr 2017 13:07:50 +0100
Subject: [PATCH v3 03/12] dt-bindings: make AXP20X compatible strings one
 per line
In-Reply-To: <20170417115747.7300-4-icenowy@aosc.io>
References: <20170417115747.7300-1-icenowy@aosc.io>
 <20170417115747.7300-4-icenowy@aosc.io>
Message-ID: <20170424120750.icfv5cvavxrid27d@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Apr 2017, Icenowy Zheng wrote:

> In the binding documentation of AXP20X mfd, the compatible strings used
> to be listed for three per line, which leads to some mess when trying to
> add AXP803 compatible string (as we have already AXP806 and AXP809
> compatibles, which is after AXP803 in ascending order).
> 
> Make the compatible strings one per line, so that inserting a new
> compatible string will be directly a new line.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> New patch in v3.
> 
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index b41d2601c6ba..a3e813f6060a 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -9,9 +9,14 @@ axp223 (X-Powers)
>  axp809 (X-Powers)
>  
>  Required properties:
> -- compatible: "x-powers,axp152", "x-powers,axp202", "x-powers,axp209",
> -	      "x-powers,axp221", "x-powers,axp223", "x-powers,axp806",
> -	      "x-powers,axp809"
> +- compatible: should be one of:
> +    * "x-powers,axp152"
> +    * "x-powers,axp202"
> +    * "x-powers,axp209"
> +    * "x-powers,axp221"
> +    * "x-powers,axp223"
> +    * "x-powers,axp806"
> +    * "x-powers,axp809"
>  - reg: The I2C slave address or RSB hardware address for the AXP chip
>  - interrupt-parent: The parent interrupt controller
>  - interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
