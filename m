From: robh@kernel.org (Rob Herring)
Date: Fri, 28 Apr 2017 13:24:01 -0500
Subject: [PATCH 1/2] clk: Add bindings for the Gemini Clock Controller
In-Reply-To: <20170424185545.26608-1-linus.walleij@linaro.org>
References: <20170424185545.26608-1-linus.walleij@linaro.org>
Message-ID: <20170428182401.rpn7ytxvu6shy5sn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 08:55:45PM +0200, Linus Walleij wrote:
> This adds device tree bindings and a header for the Gemini SoC
> Clock Controller.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../clock/cortina,gemini-clock-controller.txt      | 25 +++++++++++++++++++
>  include/dt-bindings/clock/cortina,gemini-clock.h   | 29 ++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/cortina,gemini-clock-controller.txt
>  create mode 100644 include/dt-bindings/clock/cortina,gemini-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/cortina,gemini-clock-controller.txt b/Documentation/devicetree/bindings/clock/cortina,gemini-clock-controller.txt
> new file mode 100644
> index 000000000000..7af84acfcbce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/cortina,gemini-clock-controller.txt
> @@ -0,0 +1,25 @@
> +Clock bindings for the Cortina Systems Gemini SoC Clock Controller
> +
> +Required properties :
> +- compatible : shall contain the following:
> +  "cortina,gemini-clock-controller"
> +- #clock-cells should be <1>
> +
> +The Gemini clock controller needs to be placed as a subnode of the
> +system controller.
> +
> +All available clocks are defined as preprocessor macros in
> +dt-bindings/clock/cortina,gemini-clock.h header and can be used in device
> +tree sources.
> +
> +Example:
> +
> +syscon: syscon at 40000000 {
> +	compatible = "cortina,gemini-syscon", "syscon", "simple-mfd";
> +	reg = <0x40000000 0x1000>;
> +
> +	clock-controller {
> +		compatible = "cortina,gemini-clock-controller";
> +		#clock-cells = <1>;

There's not really much reason to have a child node here. The parent can 
be the clock provider.

Rob
