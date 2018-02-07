From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 Feb 2018 10:20:27 -0200
Subject: [PATCH v3 1/2] Document: dt: binding: imx: update pinctrl doc for
 imx6sll
In-Reply-To: <1517969226-13076-1-git-send-email-ping.bai@nxp.com>
References: <1517969226-13076-1-git-send-email-ping.bai@nxp.com>
Message-ID: <CAOMZO5A1a48jVdimwjhF+L9now2ceYpzt6cfmig_0bV9A245nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bai Ping,

On Wed, Feb 7, 2018 at 12:07 AM, Bai Ping <ping.bai@nxp.com> wrote:
> Add pinctrl binding doc update for imx6sll.
>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
> changes v2-v3:
>  - add generic config binding
> ---
>  .../bindings/pinctrl/fsl,imx6sll-pinctrl.txt       |  70 ++
>  arch/arm/boot/dts/imx6sll-pinfunc.h                | 882 +++++++++++++++++++++
>  2 files changed, 952 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6sll-pinctrl.txt
>  create mode 100644 arch/arm/boot/dts/imx6sll-pinfunc.h
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx6sll-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx6sll-pinctrl.txt
> new file mode 100644
> index 0000000..335f14a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx6sll-pinctrl.txt
> @@ -0,0 +1,70 @@
> +* Freescale i.MX6 SLL IOMUX Controller
> +
> +Please refer to the pinctrl-bindings.txt in this directory for generic pinctrl binding.
> +
> +=== Pin Controller Node ===
> +
> +Required properties:
> +- compatible: "fsl,imx6sll-iomuxc"
> +- reg: Should contain the base physical address and size of the iomuxc registers.
> +
> +
> +=== Pin Configuration Node ===
> +- pinmux: One integers array, represents a group of pins mux setting.
> +       The format is pinmux = <PIN_FUNC_ID>, PIN_FUNC_ID is a pin working on
> +       a specific function. which can be found in imx6sll-pinfunc.h under device
> +       tree source folder. Please also refer to i.MX6SLL Reference Manual for detailed
> +       CONFIG settings.
> +
> +Optional Properties:
> +- drive-strength               Integer. Controls Drive Strength
> +                                       0: HI-Z
> +                                       1: 260 ohm at 3.3v, 150 ohm at 1.8v
> +                                       2: 130 ohm at 3.3v, 75 ohm at 1.8v
> +                                       3: 86 ohm at 3.3v, 50 ohm at 1.8v
> +                                       4: 65 ohm at 3.3v, 37 ohm at 1.8v
> +                                       5: 52 ohm at 3.3v, 30 ohm at 1.8v
> +                                       6: 43 ohm at 3.3v, 25 ohm at 1.8v
> +                                       7: 37 ohm at 3.3v, 21 ohm at 1.8v
> +- drive-open-drain             Bool. Enable Pin Open-drian
> +- slew-rate:                   Integer. Controls Slew Rate
> +                                       0: slow
> +                                       1: fast
> +- fsl,pin-speed:               Integer, Controls the pin speed
> +                                       0: reserverd
> +                                       1: low(50 MHz)
> +                                       2: medium(100 MHz)
> +                                       3: maximum(200 MHz)
> +
> +- bias-pull-down:              Integer. Pull down on pin
> +                                       0: 100K ohm pull down
> +- bias-pull-up:                        Integer. Pull up on pin
> +                                       1: 47K ohm pull up
> +                                       2: 100K ohm pull up
> +                                       3: 22K ohm pull up
> +- input-schmitt-enable:                bool, Schmitt trigger input enable
> +- fsl,low-voltage-enable:      Integer. low voltage enable
> +                                       0: High voltage
> +                                       1: Low voltage

Under this generic pinctrl method: how do we set the SION bit in the board dts?

Thanks
