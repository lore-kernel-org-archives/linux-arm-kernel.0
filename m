From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 21 Apr 2016 16:02:19 -0500
Subject: [PATCH] ARM64: dts: rockchip: add core dtsi file for RK3399 SoCs
In-Reply-To: <1461211092-26331-1-git-send-email-jay.xu@rock-chips.com>
References: <1461122150-9042-1-git-send-email-jay.xu@rock-chips.com>
 <1461211092-26331-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <CAL_JsqJ-kyCc=3XdVGvtK4MvRqWOr2RA=9t4kgy73K+cE=JOUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 10:58 PM, Jianqun Xu <jay.xu@rock-chips.com> wrote:
> This patch adds rk3399.dtsi for rk3399 found on Rockchip
> RK3399 SoCs, also add rk3399-evb.dts for Rockchip RK3399
> Evaluation Board.
>
> Patch is tested on RK3399 evb.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile       |    1 +
>  arch/arm64/boot/dts/rockchip/rk3399-evb.dts |  537 ++++++++
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi    | 1757 +++++++++++++++++++++++++++
>  3 files changed, 2295 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-evb.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399.dtsi
>
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index df37865..7037a16 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -1,6 +1,7 @@
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-evb-act8846.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-geekbox.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-r88.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-evb.dtb
>
>  always         := $(dtb-y)
>  subdir-y       := $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> new file mode 100644
> index 0000000..4cb0028
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> @@ -0,0 +1,537 @@
> +/*
> + * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
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
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/pwm/pwm.h>
> +#include "rk3399.dtsi"
> +
> +/ {
> +       model = "Rockchip RK3399 Evaluation Board";
> +       compatible = "rockchip,evb", "rockchip,rk3399-evb";
> +
> +       chosen {
> +               bootargs = "console=uart,mmio32,0xff1a0000";
> +       };
> +
> +       ramoops_mem: ramoops_mem {
> +               reg = <0x0 0x100000 0x0 0x100000>;
> +               reg-names = "ramoops_mem";
> +       };
> +
> +       ramoops {
> +               compatible = "ramoops";
> +               record-size = <0x0 0x20000>;
> +               console-size = <0x0 0x80000>;
> +               ftrace-size = <0x0 0x10000>;
> +               pmsg-size = <0x0 0x50000>;
> +               memory-region = <&ramoops_mem>;
> +       };

This binding is not upstream yet. It would be great if it was if you
want to pick up the last try.

Rob
