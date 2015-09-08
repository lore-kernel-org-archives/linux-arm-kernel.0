From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 7 Sep 2015 22:08:14 -0300
Subject: [PATCH 4/4] ARM: dts: imx: add Boundary Devices Nitrogen6_Lite
 board
In-Reply-To: <1441645069-27263-5-git-send-email-gary.bisson@boundarydevices.com>
References: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
 <1441645069-27263-5-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <CAOMZO5Bb5TwtV4=C4jtU9KpuwtYSdYcSCgQVMMOY0FMf7hZx8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gary,

On Mon, Sep 7, 2015 at 1:57 PM, Gary Bisson
<gary.bisson@boundarydevices.com> wrote:

> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-nit6xlite.dts
> @@ -0,0 +1,21 @@
> +/*
> + * Copyright 2015 Boundary Devices, Inc.
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright 2011 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:

Could you do this dual license GPLv2/X11?

Take a look at arch/arm/boot/dts/imx6qdl-cubox-i.dtsi for a reference.

> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +#include "imx6dl.dtsi"
> +#include "imx6qdl-nit6xlite.dtsi"
> +
> +/ {
> +       model = "Freescale i.MX6 Solo Nitrogen6_Lite Board";
> +       compatible = "fsl,imx6dl-nit6xlite", "fsl,imx6dl";

As this board is manufactured by Boundary Devices and not by Freescale
shouldn't this be:

       model = "Boundary Devices i.MX6 Solo Nitrogen6_Lite Board";
       compatible = "boundarydevices,imx6dl-nit6xlite", "fsl,imx6dl";

Then you can add the symbol for Boundary Devices at
Documentation/devicetree/bindings/vendor-prefixes.txt in a separate
patch.

Regards,

Fabio Estevam
