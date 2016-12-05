From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Dec 2016 17:09:39 -0600
Subject: [PATCH 1/3] Add DT bindings documentation for NS2 USB DRD phy
In-Reply-To: <1480485338-23451-2-git-send-email-raviteja.garimella@broadcom.com>
References: <1480485338-23451-1-git-send-email-raviteja.garimella@broadcom.com>
 <1480485338-23451-2-git-send-email-raviteja.garimella@broadcom.com>
Message-ID: <20161205230939.j6kmns3oll4eddsv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2016 at 11:25:36AM +0530, Raviteja Garimella wrote:
> This patch adds documentation for NS2 DRD Phy driver DT bindings
> 
> Signed-off-by: Raviteja Garimella <raviteja.garimella@broadcom.com>
> ---
>  .../devicetree/bindings/phy/brcm,ns2-drd-phy.txt   | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,ns2-drd-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,ns2-drd-phy.txt b/Documentation/devicetree/bindings/phy/brcm,ns2-drd-phy.txt
> new file mode 100644
> index 0000000..5857f99
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,ns2-drd-phy.txt
> @@ -0,0 +1,40 @@
> +BROADCOM NORTHSTAR2 USB2 (DUAL ROLE DEVICE) PHY
> +
> +Required properties:
> + - compatible: brcm,ns2-drd-phy
> + - reg: offset and length of the NS2 PHY related registers.
> + - reg-names
> +   The below registers must be provided.
> +   icfg - for DRD ICFG configurations
> +   rst-ctrl - for DRD IDM reset
> +   crmu-ctrl - for CRMU core vdd, PHY and PHY PLL reset
> +   usb2-strap - for port over current polarity reversal
> + - #phy-cells: Must be 0. No args required.
> + - vbus-gpios: vbus gpio binding
> + - id-gpios: id gpio binding
> +
> +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> +
> +Example:
> +	gpio_g: gpio at 660a0000 {

You don't really need to show gpio node for the example. Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

Rob
