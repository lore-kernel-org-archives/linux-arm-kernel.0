From: robh@kernel.org (Rob Herring)
Date: Sat, 16 Jul 2016 18:01:13 -0500
Subject: [PATCH 2/4] dt-bindings: Add a binding for Mediatek MDP
In-Reply-To: <1468498681-19955-3-git-send-email-minghsiu.tsai@mediatek.com>
References: <1468498681-19955-1-git-send-email-minghsiu.tsai@mediatek.com>
 <1468498681-19955-3-git-send-email-minghsiu.tsai@mediatek.com>
Message-ID: <20160716230113.GA31551@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2016 at 08:17:59PM +0800, Minghsiu Tsai wrote:
> Add a DT binding documentation of MDP for the MT8173 SoC
> from Mediatek
> 
> Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
> ---
>  .../devicetree/bindings/media/mediatek-mdp.txt     |   92 ++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek-mdp.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek-mdp.txt b/Documentation/devicetree/bindings/media/mediatek-mdp.txt
> new file mode 100644
> index 0000000..ef570c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek-mdp.txt
> @@ -0,0 +1,92 @@
> +* Mediatek Media Data Path
> +
> +Media Data Path is used for scaling and color space conversion.
> +
> +Required properties:
> +  - compatible : should contain them as below:
> +        "mediatek,mt8173-mdp"
> +        "mediatek,mt8173-mdp-rdma"
> +        "mediatek,mt8173-mdp-rsz"
> +        "mediatek,mt8173-mdp-wdma"
> +        "mediatek,mt8173-mdp-wrot"
> +  - clocks : device clocks
> +  - power-domains : a phandle to the power domain.
> +  - mediatek,larb : should contain the larbes of current platform
> +  - iommus : Mediatek IOMMU H/W has designed the fixed associations with
> +        the multimedia H/W. and there is only one multimedia iommu domain.
> +        "iommus = <&iommu portid>" the "portid" is from
> +        dt-bindings\iommu\mt8173-iommu-port.h, it means that this portid will
> +        enable iommu. The portid default is disable iommu if "<&iommu portid>"
> +        don't be added.
> +  - mediatek,vpu : the node of video processor unit

These properties don't apply to all the nodes. I think you need a 
section for each IP block.
