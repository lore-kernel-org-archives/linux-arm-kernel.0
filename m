From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 5 Jul 2016 09:04:46 -0300
Subject: [PATCH 2/3] ARM: dts: imx6sx: Add UDOO Neo support
In-Reply-To: <1467691450-22975-3-git-send-email-afaerber@suse.de>
References: <1467691450-22975-1-git-send-email-afaerber@suse.de>
 <1467691450-22975-3-git-send-email-afaerber@suse.de>
Message-ID: <CAOMZO5CQWz++TVKBKEMSQuyks3C+7Tx5=Frh6R+Qubcab=EbjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 5, 2016 at 1:04 AM, Andreas F?rber <afaerber@suse.de> wrote:

> +/dts-v1/;
> +
> +#include "imx6sx-udoo-neo.dtsi"
> +
> +/ {
> +       model = "UDOO Neo Basic";

This should be something like:

model = "Udoo i.MX6 SoloX UDOO Neo Basic";

> +       compatible = "fsl,imx6sx";

compatible = "udoo,imx6sx-udoo-neo", "fsl,imx6sx";

Then you can also send a separate patch to add udoo to
Documentation/devicetree/bindings/vendor-prefixes.txt.

Same applies to other places in this patch.

> +&fec1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_enet1>;
> +       phy-mode = "rmii";
> +       phy-reset-gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;

Shouldn't this be GPIO_ACTIVE_LOW instead?
