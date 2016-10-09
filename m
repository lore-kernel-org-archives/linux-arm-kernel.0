From: robh@kernel.org (Rob Herring)
Date: Sat, 8 Oct 2016 20:29:27 -0500
Subject: [RFC 02/10] dt-bindings: interrupt-controller: add DT binding
 for meson GPIO interrupt controller
In-Reply-To: <1475593708-10526-3-git-send-email-jbrunet@baylibre.com>
References: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
 <1475593708-10526-3-git-send-email-jbrunet@baylibre.com>
Message-ID: <20161009012927.GV18158@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 05:08:20PM +0200, Jerome Brunet wrote:
> This commit adds the device tree bindings description for Amlogic's GPIO
> interrupt controller available on the meson8, meson8b and gxbb SoC families
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../amlogic,meson-gpio-intc.txt                    | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
> new file mode 100644
> index 000000000000..bd4cceefcda1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
> @@ -0,0 +1,39 @@
> +Amlogic meson GPIO interrupt controller
> +
> +Meson SoCs contains an interrupt controller which is able watch the SoC pads
> +and generate an interrupt on edges or level. The controller is essentially a
> +256 pads to 8 GIC interrupt multiplexer, with a filter block to select edge
> +or level and polarity. We don?t expose all 256 mux inputs because the
> +documentation shows that upper part is not mapped to any pad. The actual number
> +of interrupt exposed depends on the SoC.
> +
> +Required properties:
> +
> +- compatible : should be: "amlogic,meson8-gpio-intc? or
> +  ?amlogic,meson8b-gpio-intc? or ?amlogic,gxbb-gpio-intc?

One per line please if you respin the series.

Acked-by: Rob Herring <robh@kernel.org>
