From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Feb 2017 17:04:57 -0600
Subject: [PATCH v3 2/4] arm: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual
 OpenFrame Cap 10.1 initial support
In-Reply-To: <1487653593-3457-2-git-send-email-jagan@openedev.com>
References: <1487653593-3457-1-git-send-email-jagan@openedev.com>
 <1487653593-3457-2-git-send-email-jagan@openedev.com>
Message-ID: <CAL_JsqLZFsBdZyBeJfe-mhxcEc_tUS1GrtPBcMvkwUL0VDcr1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 11:06 PM, Jagan Teki <jagan@openedev.com> wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
>
> i.CoreM6 Quad/Dual OpenFrame modules are "system on modules plus
> openframe display carriers" which are good solution for develop
> user friendly graphic user interface.
>
> General features:
> CPU           NXP i.MX6Q rev1.2 at 792 MHz
> RAM           1GB, 32, 64 bit, DDR3-800/1066
> NAND          SLC,512MB
> LVDS Display  TFT 10.1" industrial, 1280x800 resolution
> Backlight     LED backlight, brightness 350 Cd/m2
> Power supply  15 to 30 Vdc
>
> Cc: Domenico Acri <domenico.acri@engicam.com>
> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - Use native-mode as timing0 since this is the initial lvds-channel
> - Rename hsd100pxn1 reference as timing0
> Changes for v2:
> - none
>
>  arch/arm/boot/dts/Makefile                |  1 +
>  arch/arm/boot/dts/imx6q-icore-ofcap10.dts | 76 +++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-icore-ofcap10.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 0118084..458ec09 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -398,6 +398,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>         imx6q-h100.dtb \
>         imx6q-hummingboard.dtb \
>         imx6q-icore.dtb \
> +       imx6q-icore-ofcap10.dtb \
>         imx6q-icore-rqs.dtb \
>         imx6q-marsboard.dtb \
>         imx6q-mccmon6.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-icore-ofcap10.dts b/arch/arm/boot/dts/imx6q-icore-ofcap10.dts
> new file mode 100644
> index 0000000..8f40812
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-icore-ofcap10.dts
> @@ -0,0 +1,76 @@
> +/*
> + * Copyright (C) 2016 Amarula Solutions B.V.
> + * Copyright (C) 2016 Engicam S.r.l.
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License
> + *     version 2 as published by the Free Software Foundation.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */

If you respin, use SPDX tags here:

SPDX-License-Identifier: (GPL-2.0 OR MIT)

While it says X11, this is really MIT license text.
