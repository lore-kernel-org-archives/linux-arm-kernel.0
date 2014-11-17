From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Nov 2014 13:47:21 +0100
Subject: [PATCH 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb
 extensions
In-Reply-To: <1416224086-5698-3-git-send-email-hdegoede@redhat.com>
References: <1416224086-5698-1-git-send-email-hdegoede@redhat.com>
 <1416224086-5698-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20141117124721.GQ6414@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 12:34:46PM +0100, Hans de Goede wrote:
> If pre-filled framebuffer nodes are used, the firmware may need extra
> properties to find the right node. This documents the properties to use
> for this on sunxi platforms.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../bindings/video/simple-framebuffer-sunxi.txt    | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt b/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
> new file mode 100644
> index 0000000..84ca264
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
> @@ -0,0 +1,33 @@
> +Sunxi specific Simple Framebuffer bindings
> +
> +This binding documents sunxi specific extensions to the simple-framebuffer
> +bindings. The sunxi simplefb u-boot code relies on the devicetree containing
> +pre-populated simplefb nodes.
> +
> +These extensions are intended so that u-boot can select the right node based
> +on which pipeline and output is being used. As such they are solely intended
> +for firmware / bootloader use, and the OS should ignore them.
> +
> +Required properties:
> +- compatible: "sunxi,framebuffer"
> +- sunxi,pipeline:
> +  <0> for the de_be0 -> lcdc0 -> output pipeline
> +  <1> for the de_be1 -> lcdc1 -> output pipeline
> +- sunxi,output: One of: "hdmi", "lcd", "vga", and "composite"  
> +
> +Example:
> +
> +chosen {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges;
> +
> +	framebuffer at 0 {
> +		compatible = "sunxi,framebuffer", "simple-framebuffer";
> +		sunxi,pipeline = <0>;
> +		sunxi,output = "hdmi";
> +		clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
> +			 <&ahb_gates 44>;

If we're going that way, then maybe having to specify clock-names
would be better in order to know which clock is what?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/310b97ea/attachment.sig>
