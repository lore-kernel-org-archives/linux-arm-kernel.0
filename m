From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 25 Feb 2014 14:32:03 -0300
Subject: [RFC PATCH v4 4/8] staging: imx-drm: Document imx-hdmi device
 tree bindings
In-Reply-To: <1393338203-25051-5-git-send-email-p.zabel@pengutronix.de>
References: <1393338203-25051-1-git-send-email-p.zabel@pengutronix.de>
 <1393338203-25051-5-git-send-email-p.zabel@pengutronix.de>
Message-ID: <CAOMZO5BpBi0nuejHQfV2DyBZmnbvBK+aZL+5oPhzBibNiX_Taw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 11:23 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> +Required properties:
> + - #address-cells : should be <1>
> + - #size-cells : should be <0>
> + - compatible : should be "fsl,imx6q-hdmi" or "fsl,imx6dl-hdmi".
> + - gpr : should be <&gpr>.
> +   The phandle points to the iomuxc-gpr region containing the HDMI
> +   multiplexer control register.
> + - clocks, clock-names : phandles to the HDMI iahb and isrf clocks, as described
> +   in Documentation/devicetree/bindings/clock/clock-bindings.txt and
> +   Documentation/devicetree/bindings/clock/imx6q-clock.txt.
> + - port@[0-4]: Up to four port nodes with endpoint definitions as defined in
> +   Documentation/devicetree/bindings/media/video-interfaces.txt,
> +   corresponding to the four inputs to the HDMI multiplexer.
> +
> +example:
> +
> +       gpr: iomuxc-gpr at 020e0000 {
> +               /* ... */
> +       };
> +
> +        hdmi: hdmi at 0120000 {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg = <0x00120000 0x9000>;
> +                interrupts = <0 115 0x04>;
> +                gpr = <&gpr>;
> +                clocks = <&clks 123>, <&clks 124>;
> +                clock-names = "iahb", "isfr";

The 'compatible' property is missing in the example.
