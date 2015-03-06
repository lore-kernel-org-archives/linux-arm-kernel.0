From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 6 Mar 2015 11:13:38 +0000
Subject: [PATCH 3/5] dt-bindings: mediatek: Add smi dts binding
In-Reply-To: <1425638900-24989-4-git-send-email-yong.wu@mediatek.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-4-git-send-email-yong.wu@mediatek.com>
Message-ID: <20150306111338.GD8700@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 06, 2015 at 10:48:18AM +0000, yong.wu at mediatek.com wrote:
> From: Yong Wu <yong.wu@mediatek.com>
> 
> This patch add smi binding document.

Please move binding documents to the start of the series. It makes
things far easier to review.

> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mediatek,smi.txt   | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
> new file mode 100644
> index 0000000..0fc9d1a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
> @@ -0,0 +1,17 @@
> +SMI hardware block diagram please help check <bindings/iommu/mediatek,iommu.txt>
> +
> +Required properties:
> +- compatible : must be "mediatek,mediatek,mt8173-smi-larb"

Double vendor prefix?

What does "larb" mean? It would be nice for the intorductory paragraph
in this file to explain.

> +- reg : the register of each local arbiter
> +- clocks : the clocks of each local arbiter
> +- clock-name: larb_sub*(3 clockes at most)

The names required _must_ be specified here, or clock-names is
pointless.

The clock names should be from the PoV of _this_ device (i.e. they
should be the names of the inputs) not from the PoV of the provider
(i.e. they should not be the names of the outputs from the provider).

Mark.

> +
> +Example:
> +	larb1:larb at 16010000 {
> +	        compatible = "mediatek,mt8173-smi-larb";
> +		reg = <0 0x16010000 0 0x1000>;
> +		clocks = <&mmsys MM_SMI_COMMON>,
> +		        <&vdecsys VDEC_CKEN>,
> +                        <&vdecsys VDEC_LARB_CKEN>;
> +		clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
> +	};
> -- 
> 1.8.1.1.dirty
> 
> 
