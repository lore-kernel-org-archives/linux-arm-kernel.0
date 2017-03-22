From: robh@kernel.org (Rob Herring)
Date: Wed, 22 Mar 2017 09:04:59 -0500
Subject: [PATCH] ARM: dts: imx: add Gateworks Ventana GW5903 support
In-Reply-To: <1490125452-5712-1-git-send-email-tharvey@gateworks.com>
References: <1490125452-5712-1-git-send-email-tharvey@gateworks.com>
Message-ID: <CAL_JsqKVxpdS0cuXnwkux7zESXdjRA7RO0Pu0gGLdqKUTaMDpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 2:44 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> The Gateworks Ventana GW5903 is a single-board computer based on the NXP
> IMX6 SoC with the following features:
>  * IMX6 DualLite Soc (supports IMX6S,IMX6DL,IMX6Q)
>  * 4GiB DDR3 DRAM
>  * 32GB eMMC
>  * 1x microSD connector
>  * Gateworks System Controller:
>   - hardware watchdog
>   - hardware monitor
>   - pushbutton controller
>   - EEPROM storage
>   - power control
>  * JTAG programmable
>  * Inertial Module
>  * uBlox EMMY-W1 (bluetooth/nfc/802.11ac)
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm/boot/dts/Makefile            |   2 +
>  arch/arm/boot/dts/imx6dl-gw5903.dts   |  55 +++
>  arch/arm/boot/dts/imx6q-gw5903.dts    |  55 +++
>  arch/arm/boot/dts/imx6qdl-gw5903.dtsi | 660 ++++++++++++++++++++++++++++++++++
>  4 files changed, 772 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-gw5903.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-gw5903.dts
>  create mode 100644 arch/arm/boot/dts/imx6qdl-gw5903.dtsi
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7e2adf0..9e907cd 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -352,6 +352,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>         imx6dl-gw551x.dtb \
>         imx6dl-gw552x.dtb \
>         imx6dl-gw553x.dtb \
> +       imx6dl-gw5903.dtb \
>         imx6dl-gw5904.dtb \
>         imx6dl-hummingboard.dtb \
>         imx6dl-icore.dtb \
> @@ -396,6 +397,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>         imx6q-gw551x.dtb \
>         imx6q-gw552x.dtb \
>         imx6q-gw553x.dtb \
> +       imx6q-gw5903.dtb \
>         imx6q-gw5904.dtb \
>         imx6q-h100.dtb \
>         imx6q-hummingboard.dtb \
> diff --git a/arch/arm/boot/dts/imx6dl-gw5903.dts b/arch/arm/boot/dts/imx6dl-gw5903.dts
> new file mode 100644
> index 0000000..103261e
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-gw5903.dts
> @@ -0,0 +1,55 @@
> +/*
> + * Copyright 2017 Gateworks Corporation
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of
> + *     the License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + *     You should have received a copy of the GNU General Public
> + *     License along with this file; if not, write to the Free
> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> + *     MA 02110-1301 USA
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

You can use SPDX tag here:

SPDX-License-Identifier: (GPL-2.0+ OR MIT)

While it says X11, this is really MIT license text as defined by SPDX.
