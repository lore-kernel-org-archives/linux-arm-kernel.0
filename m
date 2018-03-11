From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 11 Mar 2018 20:07:37 +0100
Subject: [PATCH v3 01/15] dt-bindings: clock: mediatek: add missing
 required #reset-cells
In-Reply-To: <7365f2286ff2cebcfb590715cb4a15dedd089046.1518895232.git.sean.wang@mediatek.com>
References: <cover.1518895232.git.sean.wang@mediatek.com>
 <7365f2286ff2cebcfb590715cb4a15dedd089046.1518895232.git.sean.wang@mediatek.com>
Message-ID: <6e155672-2544-3148-e664-72b830d1cdc2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/17/2018 08:54 PM, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> All ethsys, pciesys and ssusbsys internally include reset controller, so
> explicitly add back these missing cell definitions to related bindings
> and examples.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-clk at vger.kernel.org
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt   | 1 +
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt  | 2 ++
>  Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt | 2 ++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
> index 6cc7840..8f5335b 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
> @@ -9,6 +9,7 @@ Required Properties:
>  	- "mediatek,mt2701-ethsys", "syscon"
>  	- "mediatek,mt7622-ethsys", "syscon"
>  - #clock-cells: Must be 1
> +- #reset-cells: Must be 1
>  
>  The ethsys controller uses the common clk binding from
>  Documentation/devicetree/bindings/clock/clock-bindings.txt
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
> index d5d5f12..7fe5dc6 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
> @@ -8,6 +8,7 @@ Required Properties:
>  - compatible: Should be:
>  	- "mediatek,mt7622-pciesys", "syscon"
>  - #clock-cells: Must be 1
> +- #reset-cells: Must be 1
>  
>  The PCIESYS controller uses the common clk binding from
>  Documentation/devicetree/bindings/clock/clock-bindings.txt
> @@ -19,4 +20,5 @@ pciesys: pciesys at 1a100800 {
>  	compatible = "mediatek,mt7622-pciesys", "syscon";
>  	reg = <0 0x1a100800 0 0x1000>;
>  	#clock-cells = <1>;
> +	#reset-cells = <1>;
>  };
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
> index 00760019..b8184da 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
> @@ -8,6 +8,7 @@ Required Properties:
>  - compatible: Should be:
>  	- "mediatek,mt7622-ssusbsys", "syscon"
>  - #clock-cells: Must be 1
> +- #reset-cells: Must be 1
>  
>  The SSUSBSYS controller uses the common clk binding from
>  Documentation/devicetree/bindings/clock/clock-bindings.txt
> @@ -19,4 +20,5 @@ ssusbsys: ssusbsys at 1a000000 {
>  	compatible = "mediatek,mt7622-ssusbsys", "syscon";
>  	reg = <0 0x1a000000 0 0x1000>;
>  	#clock-cells = <1>;
> +	#reset-cells = <1>;
>  };
> 
