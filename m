From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 9 Sep 2016 17:57:24 -0300
Subject: [PATCH 1/2] ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual
 initial support
In-Reply-To: <1473453312-2786-1-git-send-email-jagan@amarulasolutions.com>
References: <1473453312-2786-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <CAOMZO5Co0CXMY1uWcF+_vN=+0wFSw1VrN-+c9AuY7zNq2WKLTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 9, 2016 at 5:35 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:

> +/dts-v1/;
> +
> +#include "imx6q.dtsi"
> +#include "imx6qdl-icore.dtsi"
> +
> +/ {
> +       model = "Engicam i.CoreM6 Quad/Dual Starter Kit";
> +       compatible = "fsl,imx6-icore", "fsl,imx6q";

Should be:
 compatible = "engicam,imx6-icore", "fsl,imx6q";

You could also send a patch adding engicam entry to
Documentation/devicetree/bindings/vendor-prefixes.txt

> +};
> +
> +&can1 {
> +       status = "oaky";

Should be "okay"

> +};
> +
> +&can2 {
> +       status = "oaky";

Should be "okay"

> +&iomuxc {
> +       pinctrl_flexcan1: flexcan1grp {
> +               fsl,pins = <
> +                       MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX 0x80000000
> +                       MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX 0x80000000

No 0x80000000, please. Use the real IOMUX register value instead.


> +               >;
> +       };
> +
> +       pinctrl_flexcan2: flexcan2grp {
> +               fsl,pins = <
> +                       MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX 0x80000000
> +                       MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX 0x80000000

Same here.
