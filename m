From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 1 Feb 2016 07:22:02 -0600
Subject: [PATCH 2/2] dt-bindings: Add TPO TPG110 binding
In-Reply-To: <1454316643-3931-1-git-send-email-linus.walleij@linaro.org>
References: <1454316643-3931-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAL_JsqJSR_fCnCvUnzJaD3-zA0SPgTxjKtbL=up2NyH0GL_56w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 1, 2016 at 2:50 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> This adds device tree bindings for the TPO TPG110 panel found
> mounted in the Nomadik NHK8815.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/display/panel/tpo,tpg110.txt          | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt
>
> diff --git a/Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt b/Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt
> new file mode 100644
> index 000000000000..acbc6bef3593
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt
> @@ -0,0 +1,47 @@
> +TPO TPG110 Panel
> +================
> +
> +This binding builds on the DPI bindings, adding a few properties
> +as a superset of a DPI. See panel-dpi.txt for the required DPI
> +bindings.
> +
> +Required properties:
> +- compatible : "tpo,tpg110"
> +- grestb-gpio : panel reset GPIO

-gpios

The example is correct.

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

> +- scen-gpios : serial control enable GPIO
> +- scl-gpios : serial control clock line GPIO
> +- sda-gpios : serial control data line GPIO
> +
> +Required nodes:
> +- Video port for DPI input, see panel-dpi.txt
> +- Panel timing for DPI setup, see panel-dpi.txt
> +
> +Example
> +-------
> +
> +panel {
> +       compatible = "tpo,tpg110", "panel-dpi";
> +       grestb-gpios = <&stmpe_gpio44 5 GPIO_ACTIVE_LOW>;
> +       scen-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
> +       scl-gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
> +       sda-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
> +       backlight = <&bl>;
> +
> +       port {
> +               nomadik_clcd_panel: endpoint {
> +                       remote-endpoint = <&nomadik_clcd_pads>;
> +               };
> +       };
> +
> +       panel-timing {
> +               clock-frequency = <33200000>;
> +               hactive = <800>;
> +               hback-porch = <216>;
> +               hfront-porch = <40>;
> +               hsync-len = <1>;
> +               vactive = <480>;
> +               vback-porch = <35>;
> +               vfront-porch = <10>;
> +               vsync-len = <1>;
> +       };
> +};
> --
> 2.4.3
>
