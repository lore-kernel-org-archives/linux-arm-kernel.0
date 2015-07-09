From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 9 Jul 2015 10:36:34 +0800
Subject: [PATCH 3/8] Document: dt: binding: imx: update document for
 imx6ul support
In-Reply-To: <1434555569-8237-4-git-send-email-Frank.Li@freescale.com>
References: <1434555569-8237-1-git-send-email-Frank.Li@freescale.com>
 <1434555569-8237-4-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150709023634.GM28488@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 11:39:24PM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> This part just add necessary change to boot imx6ul.
> Update clock and pinctrl for imx6ul
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Double SoB.  Drop one.

> ---
>  .../devicetree/bindings/clock/imx6ul-clock.txt     | 13 ++++++++
>  .../bindings/pinctrl/fsl,imx6ul-pinctrl.txt        | 36 ++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx6ul-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx6ul-clock.txt b/Documentation/devicetree/bindings/clock/imx6ul-clock.txt
> new file mode 100644
> index 0000000..3ff362e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx6ul-clock.txt
> @@ -0,0 +1,13 @@
> +* Clock bindings for Freescale i.MX6 UltraLite
> +
> +Required properties:
> +- compatible: Should be "fsl,imx6ul-ccm"
> +- reg: Address and length of the register set
> +- #clock-cells: Should be <1>
> +- clocks: list of clock specifiers, must contain an entry for each required
> +  entry in clock-names
> +- clock-names: should include entries "ckil", "osc", "ipp_di0" and "ipp_di1"
> +
> +The clock consumer should specify the desired clock by having the clock
> +ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx6ul-clock.h
> +for the full list of i.MX6 UltraLite  clock IDs.
                                       ^^
Double spaces.  Drop one.

Shawn

> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
> new file mode 100644
> index 0000000..a81bbf3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
> @@ -0,0 +1,36 @@
> +* Freescale i.MX6 UltraLite IOMUX Controller
> +
> +Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
> +and usage.
> +
> +Required properties:
> +- compatible: "fsl,imx6ul-iomuxc"
> +- fsl,pins: each entry consists of 6 integers and represents the mux and config
> +  setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg mux_val
> +  input_val> are specified using a PIN_FUNC_ID macro, which can be found in
> +  imx6ul-pinfunc.h under device tree source folder.  The last integer CONFIG is
> +  the pad setting value like pull-up on this pin.  Please refer to i.MX6 UltraLite
> +  Reference Manual for detailed CONFIG settings.
> +
> +CONFIG bits definition:
> +PAD_CTL_HYS                     (1 << 16)
> +PAD_CTL_PUS_100K_DOWN           (0 << 14)
> +PAD_CTL_PUS_47K_UP              (1 << 14)
> +PAD_CTL_PUS_100K_UP             (2 << 14)
> +PAD_CTL_PUS_22K_UP              (3 << 14)
> +PAD_CTL_PUE                     (1 << 13)
> +PAD_CTL_PKE                     (1 << 12)
> +PAD_CTL_ODE                     (1 << 11)
> +PAD_CTL_SPEED_LOW               (0 << 6)
> +PAD_CTL_SPEED_MED               (1 << 6)
> +PAD_CTL_SPEED_HIGH              (3 << 6)
> +PAD_CTL_DSE_DISABLE             (0 << 3)
> +PAD_CTL_DSE_260ohm              (1 << 3)
> +PAD_CTL_DSE_130ohm              (2 << 3)
> +PAD_CTL_DSE_87ohm               (3 << 3)
> +PAD_CTL_DSE_65ohm               (4 << 3)
> +PAD_CTL_DSE_52ohm               (5 << 3)
> +PAD_CTL_DSE_43ohm               (6 << 3)
> +PAD_CTL_DSE_37ohm               (7 << 3)
> +PAD_CTL_SRE_FAST                (1 << 0)
> +PAD_CTL_SRE_SLOW                (0 << 0)
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
