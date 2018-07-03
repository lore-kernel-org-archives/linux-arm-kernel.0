From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jul 2018 12:25:59 -0600
Subject: [PATCH v4 1/2] devicetree/bindings: display: Add document for
 rockchip RGB output
In-Reply-To: <1529997340-156879-2-git-send-email-hjc@rock-chips.com>
References: <1529997340-156879-1-git-send-email-hjc@rock-chips.com>
 <1529997340-156879-2-git-send-email-hjc@rock-chips.com>
Message-ID: <20180703182559.GA12809@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 03:15:39PM +0800, Sandy Huang wrote:
> This path add support rv1108 and px30 rgb output interface driver.

Bindings are for h/w, not drivers.

> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/1509522765-118759-1-git-send-email-hjc at rock-chips.com
> ---
> 
> Changes in v4: Add support px30
> Changes in v3: None
> Changes in v2: None
> 
> .../bindings/display/rockchip/rockchip-rgb.txt     | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> new file mode 100644
> index 0000000..077b9ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> @@ -0,0 +1,73 @@
> +Rockchip RV1108 RGB interface
> +================================
> +
> +Required properties:
> +- compatible: matching the soc type:
> +	- "rockchip,px30-rgb";
> +	- "rockchip,rv1108-rgb";

This doesn't look right? What (and how) is getting programmed here 
because you don't have any register interface.

> +
> +Optional properties:
> +- pinctrl-names: should be a "lcdc" entry or a "default" entry.
> +- pinctrl-0: pin control group to be used for this interface.
> +
> +The rgb has two video ports described by:
> +	Documentation/devicetree/bindings/media/video-interfaces.txt
> +Their connections are modeled using the OF graph bindings specified in
> +	Documentation/devicetree/bindings/graph.txt.
> +
> +- video port 0 for the VOP input, the remote endpoint maybe vopb/vopl/vop

So there is a mux for these inputs and they are switched with pinctrl? 

Just put the pinctrl nodes of the sources and enable whichever one is 
active.

Rob
