From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 12 Aug 2013 15:29:59 +0800
Subject: [PATCH 1/2] ARM: dts: mxs: add pinctrl header files to be able
 to use symbolic names in dts
In-Reply-To: <1375967472-7755-2-git-send-email-LW@KARO-electronics.de>
References: <1375967472-7755-1-git-send-email-LW@KARO-electronics.de>
 <1375967472-7755-2-git-send-email-LW@KARO-electronics.de>
Message-ID: <20130812072957.GB25061@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 03:11:11PM +0200, Lothar Wa?mann wrote:
> 

Can we make the subject a little abbreviated and have it elaborated
in commit log?

> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  include/dt-bindings/pinctrl/mx23.h |  333 ++++++++++++++++++++++++
>  include/dt-bindings/pinctrl/mx28.h |  506 ++++++++++++++++++++++++++++++++++++
>  include/dt-bindings/pinctrl/mxs.h  |   31 +++
>  3 files changed, 870 insertions(+), 0 deletions(-)
>  create mode 100644 include/dt-bindings/pinctrl/mx23.h
>  create mode 100644 include/dt-bindings/pinctrl/mx28.h
>  create mode 100644 include/dt-bindings/pinctrl/mxs.h

For definitions that are used by DTS only, I think it's fine to have
them in arch/arm/boot/dts, e.g. arch/arm/boot/dts/imx23-pinctrl.h.
I would only put those that are shared between kernel and device tree
into include/dt-bindings.

> 
> diff --git a/include/dt-bindings/pinctrl/mx23.h b/include/dt-bindings/pinctrl/mx23.h
> new file mode 100644
> index 0000000..a31c969
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/mx23.h
> @@ -0,0 +1,333 @@
> +/*
> + * Header providing constants for i.MX23 pinctrl bindings.
> + *
> + * Copyright (C) 2013 Lothar Wa?mann <LW@KARO-electronics.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#ifndef __DT_BINDINGS_MX23_PINCTRL_H__
> +#define __DT_BINDINGS_MX23_PINCTRL_H__
> +
> +#include "mxs.h"
> +
> +#define MX23_PAD_GPMI_D00__GPMI_D00			0x0000

With defining macros for these constants, we can clean up them from
Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt.

<snip>

> diff --git a/include/dt-bindings/pinctrl/mxs.h b/include/dt-bindings/pinctrl/mxs.h
> new file mode 100644
> index 0000000..c6da987
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/mxs.h
> @@ -0,0 +1,31 @@
> +/*
> + * Header providing constants for i.MX28 pinctrl bindings.
> + *
> + * Copyright (C) 2013 Lothar Wa?mann <LW@KARO-electronics.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#ifndef __DT_BINDINGS_MXS_PINCTRL_H__
> +#define __DT_BINDINGS_MXS_PINCTRL_H__
> +
> +/* fsl,drive-strength property */
> +#define MXS_DRIVE_4mA		0
> +#define MXS_DRIVE_8mA		1
> +#define MXS_DRIVE_12mA		2
> +#define MXS_DRIVE_16mA		3
> +
> +/* fsl,voltage property */
> +#define MXS_VOLTAGE_LOW		0
> +#define MXS_VOLTAGE_HIGH	1
> +
> +/* fsl,pull-up property */
> +#define MXS_PULL_DISABLE	0
> +#define MXS_PULL_ENABLE		1

You're adding these without moving the existing DTS files to use them.
We do not want to see that new entries use these macro while the
existing ones keep using numbers.  So either we do not have macros for
them or we use macros for all of them.

Shawn

> +
> +#endif /* __DT_BINDINGS_MXS_PINCTRL_H__ */
> -- 
> 1.7.2.5
> 
