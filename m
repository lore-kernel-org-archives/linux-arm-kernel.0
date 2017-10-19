From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 19 Oct 2017 14:38:15 +0200
Subject: [RFC resend 1/4] dt-bindings: display: mediatek: add drm binding
In-Reply-To: <20171019112610.13645-2-mbrugger@suse.com>
References: <20171019112610.13645-1-mbrugger@suse.com>
 <20171019112610.13645-2-mbrugger@suse.com>
Message-ID: <1508416695.7665.13.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Thu, 2017-10-19 at 13:26 +0200, Matthias Brugger wrote:
> DRM subysystem and clock driver shared the same compatible mmsys.
> This stopped does not work, as only the first driver for a compatible
> gets probed. We change the comaptible to the new DRM identifier to fix
> this.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt          | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index 383183a89164..6db652463e64 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -27,6 +27,7 @@ Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt.
>  
>  Required properties (all function blocks):
>  - compatible: "mediatek,<chip>-disp-<function>", one of
> +	"mediatek,<chip>-dispsys"    - central component for the DRM system
>  	"mediatek,<chip>-disp-ovl"   - overlay (4 layers, blending, csc)
>  	"mediatek,<chip>-disp-rdma"  - read DMA / line buffer
>  	"mediatek,<chip>-disp-wdma"  - write DMA
> @@ -71,6 +72,11 @@ mmsys: clock-controller at 14000000 {
>  	#clock-cells = <1>;
>  };
>  
> +dispsys: display-system {

Could we call this node display-subsystem for consistency with i.MX and
Rockchip device trees?

With that change,
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

> +	compatible = "mediatek,mt2701-dispsys";
> +	mediatek,mmsys = <&mmsys>;
> +}
> +
>  ovl0: ovl at 1400c000 {
>  	compatible = "mediatek,mt8173-disp-ovl";
>  	reg = <0 0x1400c000 0 0x1000>;

regards
Philipp
