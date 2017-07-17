From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 17 Jul 2017 11:43:58 +0100
Subject: [PATCH 2/6] dt-bindings: mfd: axp20x: Introduce bindings for
 AXP813
In-Reply-To: <20170622040833.15329-3-wens@csie.org>
References: <20170622040833.15329-1-wens@csie.org>
 <20170622040833.15329-3-wens@csie.org>
Message-ID: <20170717104358.ndplsnhzmcdx4sxo@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Jun 2017, Chen-Yu Tsai wrote:

> The X-Powers AXP813 is a PMIC designed to be paired with Allwinner's
> A83T SoC. There is also an AXP818, which is paired with the H8 SoC.
> 
> The two models seem to be identical, apart from the external markings.
> 
> This patch introduces the basic mfd and regulator bindings for the
> AXP813.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 49 +++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 211a100c6b20..1dff7e2ec375 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -9,6 +9,12 @@ axp223 (X-Powers)
>  axp803 (X-Powers)
>  axp806 (X-Powers)
>  axp809 (X-Powers)
> +axp813 (X-Powers)
> +
> +The AXP813 is 2 chips packaged into 1. The 2 chips do not share anything
> +other than the packaging. Pins are routed separately. As such they should
> +be treated as separate entities. The other half is an AC100 RTC/codec
> +combo chip. Please see ac100.txt for its bindings.

Please indicate where this lives using standard Linux syntax.

./ac100.txt
../<subsystem>/ac100.txt

etc.

Once that's been fixed, you may apply my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
  
-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
