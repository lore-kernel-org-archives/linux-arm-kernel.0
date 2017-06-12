From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 12 Jun 2017 14:19:58 +0530
Subject: [PATCH v2] arm64: allwinner: h5: Add initial Orangepi Zero Plus 2
 support
In-Reply-To: <20170612083801.guu4gv5osbjs2qe5@flea.home>
References: <1497099474-5435-1-git-send-email-jteki@openedev.com>
 <20170612083801.guu4gv5osbjs2qe5@flea.home>
Message-ID: <CAD6G_RRAd=ga3figC+mxNbt6Z_f4hEgdPTpSgFkFVwrfCTXcdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 2:08 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Jun 10, 2017 at 06:27:54PM +0530, Jagan Teki wrote:
>> From: Jagan Teki <jagan@amarulasolutions.com>
>>
>> Orangepi Zero Plus 2 is an open-source single-board computer
>> using the Allwinner h5 SOC.
>>
>> H5 Orangepi Zero Plus 2 has
>> - Quad-core Cortex-A53
>> - 512MB DDR3
>> - micrSD slot and 8GB eMMC
>> - Debug TTL UART
>> - HDMI
>> - Wifi + BT
>> - OTG+power supply
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>> Changes for v2:
>> - Add emmc node
>>
>>  arch/arm64/boot/dts/allwinner/Makefile             |  1 +
>>  .../allwinner/sun50i-h5-orangepi-zero-plus2.dts    | 98 ++++++++++++++++++++++
>>  2 files changed, 99 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
>> index 1ea7709..8adba9c 100644
>> --- a/arch/arm64/boot/dts/allwinner/Makefile
>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
>>
>>  always               := $(dtb-y)
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
>> new file mode 100644
>> index 0000000..6136a3f
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
>> @@ -0,0 +1,98 @@
>> +/*
>> + * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This library is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This library is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sun50i-h5.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +     model = "OrangePi Zero Plus2";
>> +     compatible = "xunlong,orangepi-zero-plus2", "allwinner,sun50i-h5";
>> +
>> +     aliases {
>> +             serial0 = &uart0;
>> +     };
>> +
>> +     chosen {
>> +             stdout-path = "serial0:115200n8";
>> +     };
>> +
>> +     memory {
>> +             reg = <0x40000000 0x20000000>;
>> +     };
>
> You don't need the memory node, it will be added at runtime.
>
>> +
>> +     soc {
>
> Why is it under /soc ?

May be based on the existing added dts have soc, will drop.

thanks!
-- 
Jagan Teki
Free Software Engineer | www.openedev.com
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
