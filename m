From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 29 May 2017 17:30:26 +0200
Subject: [PATCH v4 1/2] dt-bindings: i2c: Add Mediatek MT2701 i2c binding
In-Reply-To: <1495784107-6711-2-git-send-email-jun.gao@mediatek.com>
References: <1495784107-6711-1-git-send-email-jun.gao@mediatek.com>
 <1495784107-6711-2-git-send-email-jun.gao@mediatek.com>
Message-ID: <1d073e6a-e275-24e1-7954-f1af913bd03b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/05/17 09:35, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> Add MT2701 i2c binding to i2c-mt6577.txt and there is no need to
> modify i2c driver.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> ---
>   Documentation/devicetree/bindings/i2c/i2c-mt6577.txt | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> index 0ce6fa3..52f2023 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> @@ -4,11 +4,12 @@ The Mediatek's I2C controller is used to interface with I2C devices.
>   
>   Required properties:
>     - compatible: value should be either of the following.
> -      (a) "mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
> -      (b) "mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
> -      (c) "mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
> -      (d) "mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
> -      (e) "mediatek,mt8173-i2c", for i2c compatible with mt8173 i2c.
> +	"mediatek,mt2701-i2c", "mediatek,mt6577-i2c": for Mediatek MT2701

I send a cleanup patch for the file, which fixes all the other SoCs.
I can fold this one into it, a soon as I got a Signed-off from the DT 
maintainers.

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> +	"mediatek,mt6577-i2c": for Mediatek MT6577
> +	"mediatek,mt6589-i2c": for Mediatek MT6589
> +	"mediatek,mt8127-i2c": for Mediatek MT8127
> +	"mediatek,mt8135-i2c": for Mediatek MT8135
> +	"mediatek,mt8173-i2c": for Mediatek MT8173
>     - reg: physical base address of the controller and dma base, length of memory
>       mapped region.
>     - interrupts: interrupt number to the cpu.
> 
