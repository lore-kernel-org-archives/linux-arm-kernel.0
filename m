From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Oct 2017 17:16:50 -0500
Subject: [PATCH 8/9] dt-bindings: usb: mtk-xhci: add a optional property
 to disable u3ports
In-Reply-To: <fd8b6099192ddee3b277f5ca3a699c20fb273ffe.1506503880.git.chunfeng.yun@mediatek.com>
References: <994382d16d6bdc0f3d7c11b22f1710252e056e34.1506503879.git.chunfeng.yun@mediatek.com>
 <fd8b6099192ddee3b277f5ca3a699c20fb273ffe.1506503880.git.chunfeng.yun@mediatek.com>
Message-ID: <20171005221650.yfyh72op6azm2nri@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27, 2017 at 05:23:04PM +0800, Chunfeng Yun wrote:
> Add a new optional property to disable u3ports
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mediatek,mtk-xhci.txt  |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
> index 5611a2e..2d9b459 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
> @@ -38,6 +38,8 @@ Optional properties:
>  	mode;
>   - mediatek,syscon-wakeup : phandle to syscon used to access USB wakeup
>  	control register, it depends on "mediatek,wakeup-src".
> + - mediatek,u3p-dis-msk : mask to disable u3ports, bit0 for u3port0,
> +	bit1 for u3port1, ... etc;

I think you should have child nodes for ports and use "status" to 
disable them (or omit them). IIRC, the common USB bus binding already 
defines ports.

>   - vbus-supply : reference to the VBUS regulator;
>   - usb3-lpm-capable : supports USB3.0 LPM
>   - pinctrl-names : a pinctrl state named "default" must be defined
> -- 
> 1.7.9.5
> 
