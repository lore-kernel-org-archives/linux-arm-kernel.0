From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 6 Oct 2014 12:54:34 +0200
Subject: [PATCH v7 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
In-Reply-To: <1412175188-28278-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412175188-28278-7-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141006105433.GG25202@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 04:53:03PM +0200, Boris Brezillon wrote:
> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
> 
> The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoCs (i.e.
> at91sam9n12, at91sam9x5 family or sama5d3 family) provides a display
> controller device.
> 
> The HLCDC block provides a single RGB output port, and only supports LCD
> panels connection to LCD panels for now.
> 
> The atmel,panel property link the HLCDC RGB output with the LCD panel
> connected on this port (note that the HLCDC RGB connector implementation
> makes use of the DRM panel framework).
> 
> Connection to other external devices (DRM bridges) might be added later by
> mean of a new atmel,xxx (atmel,bridge) property.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> 
> diff --git a/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> new file mode 100644
> index 0000000..ebc1a91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> @@ -0,0 +1,53 @@
> +Device-Tree bindings for Atmel's HLCDC (High LCD Controller) DRM driver
> +
> +The Atmel HLCDC Display Controller is subdevice of the HLCDC MFD device.
> +See ../mfd/atmel-hlcdc.txt for more details.
> +
> +Required properties:
> + - compatible: value should be "atmel,hlcdc-display-controller"
> + - pinctrl-names: the pin control state names. Should contain "default".
> + - pinctrl-0: should contain the default pinctrl states.
> + - #address-cells: should be set to 1.
> + - #size-cells: should be set to 0.
> +
> +Required children nodes:
> + Children nodes are encoding available output ports and their connections
> + to external devices using the OF graph reprensentation (see ../graph.txt).
> + At least one port node is required.

Are the connections configurable at runtime? Does the SoC have IP blocks
for HDMI or other types of outputs or does it provide only RGB output to
external blocks?

When you say "at least one port", how are multiple ports going to work
if you have only a single display controller?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/76f0af7b/attachment.sig>
