From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 22 Jul 2018 14:10:33 +0800
Subject: [linux-sunxi] [PATCH v3 6/9] dt-bindings: phy: add binding for
 Allwinner USB3 PHY
In-Reply-To: <20180722055739.26464-7-icenowy@aosc.io>
References: <20180722055739.26464-1-icenowy@aosc.io>
 <20180722055739.26464-7-icenowy@aosc.io>
Message-ID: <CAGb2v65m6AEW=DO-cqLMyjfnaiZudm38hXufJL6LXdOrJqir_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2018 at 1:57 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
> external USB3 pins of the SoC.
>
> Add a device tree binding for the PHY.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v3:
> - Added Chen-Yu's Review tag.
>
> Rob,
> Although you mentioned that the supply is for the port, not the phy;
> currently in USB situation "powering on the PHY" also indicates
> "powering on the port" and nearly all usages of phy-supply is for Vbus.
>
> Maybe we should change the overall phy-supply to satisfy this.

Or maybe change it to vbus-supply, like we have for phy-sun4i-usb,
until USB port power sequencing is added. (I remember there were
patches for this. What happened?)

ChenYu

> Thanks,
> Icenowy
>
>  .../bindings/phy/sun50i-usb3-phy.txt          | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
>
> diff --git a/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> new file mode 100644
> index 000000000000..912d55f9f69d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> @@ -0,0 +1,24 @@
> +Allwinner sun50i USB3 PHY
> +-----------------------
> +
> +Required properties:
> +- compatible : should be one of
> +  * allwinner,sun60i-h6-usb3-phy
> +- reg : a list of offset + length pairs
> +- #phy-cells : from the generic phy bindings, must be 0
> +- clocks : phandle + clock specifier for the phy clock
> +- resets : phandle + reset specifier for the phy reset
> +
> +Optional Properties:
> +- phy-supply : from the generic phy bindings, a phandle to a regulator that
> +              provides power to VBUS.
> +
> +Example:
> +       usb3phy: phy at 5210000 {
> +               compatible = "allwinner,sun50i-h6-usb3-phy";
> +               reg = <0x5210000 0x10000>;
> +               clocks = <&ccu CLK_USB_PHY1>;
> +               resets = <&ccu RST_USB_PHY1>;
> +               #phy-cells = <0>;
> +               status = "disabled";
> +       };
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
