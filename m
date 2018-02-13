From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 13 Feb 2018 09:44:49 -0600
Subject: [PATCHv4 1/3] dt-bindings: documentation: add clock bindings
 information for Stratix10
In-Reply-To: <1518516286-14428-1-git-send-email-dinguyen@kernel.org>
References: <1518516286-14428-1-git-send-email-dinguyen@kernel.org>
Message-ID: <CAL_JsqJNbMQOXxxDbHc=sVJFOmBWMjR25vHR-Jsqde_GnBsF0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 4:04 AM, Dinh Nguyen <dinguyen@kernel.org> wrote:
> Document that Stratix10 clock bindings, and add the clock header file. The
> clock header is an enumeration of all the different clocks on the Stratix10
> platform.
>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v4:
> - remove '_' in node names
> - remove stray tab
> - add clock-frequency property for fixed-clocks
> - put SPDX license as the very top line
> v3:
> - s/intc/intel for correct vendor prefix
> - fixup node name to "intel,stratix10-clkmgr"
> - document the required fixed-clock for oscillators
> v2:
> - use a single binding for the clock controller
> ---
>  .../devicetree/bindings/clock/intc_stratix10.txt   | 51 +++++++++++++
>  include/dt-bindings/clock/stratix10-clock.h        | 84 ++++++++++++++++++++++
>  2 files changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/intc_stratix10.txt
>  create mode 100644 include/dt-bindings/clock/stratix10-clock.h
>
> diff --git a/Documentation/devicetree/bindings/clock/intc_stratix10.txt b/Documentation/devicetree/bindings/clock/intc_stratix10.txt
> new file mode 100644
> index 0000000..0652ff1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/intc_stratix10.txt
> @@ -0,0 +1,51 @@
> +Device Tree Clock bindings for Intel's SoCFPGA Stratix10 platform
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : shall be
> +       "intel,stratix10-clkmgr"
> +
> +- reg : shall be the control register offset from CLOCK_MANAGER's base for the clock.
> +
> +- #clock-cells : from common clock binding, shall be set to 1.
> +
> +- clocks : Should contain fixed-clock sources, such as oscillators.
> +
> +Example:
> +       clkmgr: clock-controller at ffd10000 {
> +               compatible = "intel,stratix10-clkmgr";
> +               reg = <0xffd10000 0x1000>;
> +               #clock-cells = <1>;
> +
> +               clocks {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
> +                               #clock-cells = <0>;
> +                               compatible = "fixed-clock";
> +                               clock-frequency = <25000000>;
> +                       };
> +
> +                       cb_intosc_ls_clk: cb-intosc-ls-clk {
> +                               #clock-cells = <0>;
> +                               compatible = "fixed-clock";
> +                               clock-frequency = <25000000>;
> +                       };
> +
> +                       f2s_free_clk: f2s-free-clk {
> +                               #clock-cells = <0>;
> +                               compatible = "fixed-clock";
> +                               clock-frequency = <25000000>;
> +                       };
> +
> +                       osc1: osc1 {
> +                               #clock-cells = <0>;
> +                               compatible = "fixed-clock";
> +                               clock-frequency = <25000000>;
> +                       };
> +               };
> +       };
> diff --git a/include/dt-bindings/clock/stratix10-clock.h b/include/dt-bindings/clock/stratix10-clock.h
> new file mode 100644
> index 0000000..5be885d
> --- /dev/null
> +++ b/include/dt-bindings/clock/stratix10-clock.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier:    GPL-2.0

Sigh. Should be a single line comment and a single space:

/* SPDX-License-Identifier: GPL-2.0 */

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
