From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 8 Dec 2015 00:30:59 -0200
Subject: [PATCH 2/3] doc: dt-binding: generic onboard USB HUB
In-Reply-To: <1449538670-7954-3-git-send-email-peter.chen@freescale.com>
References: <1449538670-7954-1-git-send-email-peter.chen@freescale.com>
 <1449538670-7954-3-git-send-email-peter.chen@freescale.com>
Message-ID: <CAOMZO5DfBW3hxp5odbefLQCmkocPy=LypVW5HJWzDkF__WD_sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 7, 2015 at 11:37 PM, Peter Chen <peter.chen@freescale.com> wrote:
> Add dt-binding documentation for generic onboard USB HUB.
>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  .../bindings/usb/generic-onboard-hub.txt           | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/generic-onboard-hub.txt
>
> diff --git a/Documentation/devicetree/bindings/usb/generic-onboard-hub.txt b/Documentation/devicetree/bindings/usb/generic-onboard-hub.txt
> new file mode 100644
> index 0000000..ea92205
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/generic-onboard-hub.txt
> @@ -0,0 +1,28 @@
> +Generic Onboard USB HUB
> +
> +Required properties:
> +- compatible: should be "generic-onboard-hub"
> +
> +Optional properties:
> +- clocks: the input clock for HUB.
> +
> +- clock-names: Should be "external_clk"
> +
> +- hub-reset-gpios: Should specify the GPIO for reset.
> +
> +- hub-reset-active-high: the active reset signal is high, if this property is
> +  not set, the active reset signal is low.
> +
> +- hub-reset-duration-us: the duration for assert reset signal, the time unit
> +  is microsecond.
> +
> +Example:
> +
> +       usb_hub1 {
> +               compatible = "generic-onboard-hub";
> +               clocks = <&clks IMX6QDL_CLK_CKO>;
> +               clock-names = "external_clk";
> +               hub-reset-gpios = <&gpio7 12 0>;
> +               hub-reset-active-high;

I think you could drop the 'hub-reset-active-high' property and do
like this instead:

hub-reset-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>;

or

hub-reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
