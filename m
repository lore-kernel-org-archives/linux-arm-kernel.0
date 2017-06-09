From: robh@kernel.org (Rob Herring)
Date: Fri, 9 Jun 2017 08:37:17 -0500
Subject: [PATCH v2 1/3] dt-bindings: arm: amlogic: Add SoC information
 bindings
In-Reply-To: <1496742340-10307-2-git-send-email-narmstrong@baylibre.com>
References: <1496742340-10307-1-git-send-email-narmstrong@baylibre.com>
 <1496742340-10307-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <20170609133717.gkqnyatqezkrcaeg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 11:45:38AM +0200, Neil Armstrong wrote:
> Add bindings for the SoC information register of the Amlogic SoCs.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt | 32 +++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
> index 5c01e65..ae3e8ed 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.txt
> +++ b/Documentation/devicetree/bindings/arm/amlogic.txt
> @@ -60,3 +60,35 @@ Board compatible values (alphabetically, grouped by SoC):
>    - "amlogic,q201" (Meson gxm s912)
>    - "kingnovel,r-box-pro" (Meson gxm S912)
>    - "nexbox,a1" (Meson gxm s912)
> +
> +Amlogic Meson Firmware registers Interface
> +------------------------------------------
> +
> +The Meson SoCs have a register bank with status and data shared with the
> +secure firmware.
> +
> +Required properties:
> + - compatible: For Meson GX SoCs, must be "amlogic,meson-gx-ao-secure", "syscon", "simple-mfd"
> +
> +Sub-nodes should indentify components of this register interface :
> +
> +Meson GX SoC Information
> +------------------------
> +A firmware register encodes the SoC type, package and revision information on
> +the Meson GX SoCs.
> +If present, a device node for this register should be added.
> +
> +Required properties:
> +  - compatible: For Meson GX SoCs, must be "amlogic,meson-gx-chipid".
> +
> +Example
> +-------
> +
> +ao-secure at 140 {
> +	compatible = "amlogic,meson-gx-ao-secure", "syscon", "simple-mfd";
> +	reg = <0x0 0x140 0x0 0x140>;
> +
> +	chipid {
> +		compatible = "amlogic,meson-gx-chipid";

No registers for this block? If not, this node is pointless. 
"amlogic,meson-gx-ao-secure" should be specific enough to determine if 
you have this block or not and the driver for it can create a device if 
the OS needs it.

Rob
