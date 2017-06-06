From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 6 Jun 2017 13:07:44 +0200
Subject: [PATCH 1/4] dt-bindings: rng: add generic bindings for MediaTek
 SoCs
In-Reply-To: <1d9c981e1b45bf2f04732a02d90e6857cc203ce5.1496255334.git.sean.wang@mediatek.com>
References: <cover.1496255334.git.sean.wang@mediatek.com>
 <1d9c981e1b45bf2f04732a02d90e6857cc203ce5.1496255334.git.sean.wang@mediatek.com>
Message-ID: <9eb87222-ca89-0abb-4532-3887008f6e7a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 31/05/17 20:44, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add the generic binding for allowing the support of RNG on MediaTek SoCs
> such as MT7622.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>   Documentation/devicetree/bindings/rng/mtk-rng.txt | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rng/mtk-rng.txt b/Documentation/devicetree/bindings/rng/mtk-rng.txt
> index a6d62a2..0772913 100644
> --- a/Documentation/devicetree/bindings/rng/mtk-rng.txt
> +++ b/Documentation/devicetree/bindings/rng/mtk-rng.txt
> @@ -2,7 +2,8 @@ Device-Tree bindings for Mediatek random number generator
>   found in Mediatek SoC family
>   
>   Required properties:
> -- compatible	    : Should be "mediatek,mt7623-rng"
> +- compatible	    : Should be "mediatek,generic-rng" or
> +				"mediatek,mt7623-rng".

What does generic-rng mean. Is it for all mt7xxx, or also for mt6xxx and 
mt8xxx based SoCs? I think we should stick with SoC specific bindings, 
as we don't know if Mediatek won't publish a new IP block next year 
which is differnet.

Just in case we should add a binding for the actual SoC + a fallback. 
For example.
- compatible " Should be
	"mediatek,mt7622-rng", 	"mediatek,mt7623-rng" for SoC mt7622
	"mediatek,mt7623-rng" for SoC mt7623

This will also eliminate the need of adding mt6722-rng to the driver, as 
it will use mt7623-rng as fallback. If in the future we realize that 
mt7622-rng has a extra feature/bug, we can still work around it, without 
breaking the bindings.

Makes sense?

Regards,
Matthias

>   - clocks	    : list of clock specifiers, corresponding to
>   		      entries in clock-names property;
>   - clock-names	    : Should contain "rng" entries;
> 
