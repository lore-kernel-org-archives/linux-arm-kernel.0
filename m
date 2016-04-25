From: caesar.upstream@gmail.com (Caesar Wang)
Date: Mon, 25 Apr 2016 09:47:15 +0800
Subject: [PATCH RESEND v2 4/4] ARM64: dts: rockchip: add dts file for
 RK3399 evaluation board
In-Reply-To: <1461304307-14113-5-git-send-email-jay.xu@rock-chips.com>
References: <1461304307-14113-1-git-send-email-jay.xu@rock-chips.com>
 <1461304307-14113-5-git-send-email-jay.xu@rock-chips.com>
Message-ID: <571D7723.1020707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2016?04?22? 13:51, Jianqun Xu ??:
> This patch add rk3399-evb.dts for RK3399 evaluation board.
> Tested on RK3399 evb.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> ---
> changes in v2:
> - remove rk808 since without i2c, which will upstream independently
> - remove es8316 since without i2c, which will upstream independently
> - fix codingstyle issues
>
>   arch/arm64/boot/dts/rockchip/Makefile       |   1 +
>   arch/arm64/boot/dts/rockchip/rk3399-evb.dts | 122 ++++++++++++++++++++++++++++
>   2 files changed, 123 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-evb.dts
>
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index df37865..7037a16 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -1,6 +1,7 @@
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-evb-act8846.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-geekbox.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-r88.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-evb.dtb
>   
>   always		:= $(dtb-y)
>   subdir-y	:= $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> new file mode 100644
> index 0000000..309f870
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
> @@ -0,0 +1,122 @@
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
> +#include <dt-bindings/pwm/pwm.h>
> +#include "rk3399.dtsi"
> +
> +/ {
> +	compatible = "rockchip,rk3399-evb", "rockchip,rk3399";

I pick them up in my github. 
(https://github.com/Caesar-github/rockchip/tree/wip/fixes-thermal-0425)

Can we add the following strings to match the loader (coreboot)?
  No matter, we can match the loader(coreboot) to bring up the evb board 
on now or in the future.

...,"google,rk3399evb-rev3", 
google,rk3399evb-rev2",google,rk3399evb-rev1","google,rk3399evb-rev0"

Bring up my evb board:
...
Compat preference: google,rk3399evb-rev0
Config conf at 4, kernel kernel at 1, fdt fdt at 4, compat google,rk3399evb-rev0 
(match) rockchip,rk3399-evb rockchip,rk3399
Config conf at 3, kernel kernel at 1, fdt fdt at 3, compat rockchip,r88 
rockchip,rk3368
Config conf at 2, kernel kernel at 1, fdt fdt at 2, compat geekbuying,geekbox 
rockchip,rk3368
Config conf at 1 (default), kernel kernel at 1, fdt fdt at 1, compat 
rockchip,rk3368-evb-act8846 rockchip,rk3368
Choosing best match conf at 4.
Shutting down all USB controllers.
Exiting depthcharge with code 4 at timestamp: 6031792
WARNING: Skipping low memory range [0x0:0x500000]!
Relocating kernel to 0x680000
jumping to kernel
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 
4.6.0-rc4-next-20160422-00016-g0ac0bfb-dirty (wxt at nb) (gcc version 
4.9.x-google 20140827 (prerelease) (GCC) ) #16 SMP PR
....


--
<cut>


-
Caesar

-- 
Thanks,
Caesar
