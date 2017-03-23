From: cl@rock-chips.com (=?UTF-8?B?6ZmI5Lqu?=)
Date: Thu, 23 Mar 2017 10:06:02 +0800
Subject: [PATCH v2 4/6] arm64: dts: rockchip: add core dtsi file for
 RK3328 SoCs
In-Reply-To: <14610453.rKm3MBREMz@diego>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
 <1489670244-13328-5-git-send-email-cl@rock-chips.com>
 <14610453.rKm3MBREMz@diego>
Message-ID: <58D32D8A.1030506@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi? Heiko
? 2017?03?21? 16:55, Heiko St?bner ??:
> Hi,
>
> Am Donnerstag, 16. M?rz 2017, 21:17:22 CET schrieb cl at rock-chips.com:
>> From: Liang Chen <cl@rock-chips.com>
>>
>> This patch adds core dtsi file for Rockchip RK3328 SoCs.
>>
>> Signed-off-by: Liang Chen <cl@rock-chips.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1362
>> ++++++++++++++++++++++++++++++ 1 file changed, 1362 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3328.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk3328.dtsi new file mode 100644
>> index 0000000..a92955c
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> @@ -0,0 +1,1362 @@
>> +/*
>> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd
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
>> +#include <dt-bindings/clock/rk3328-cru.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/pinctrl/rockchip.h>
>> +#include <dt-bindings/soc/rockchip,boot-mode.h>
>> +#include <dt-bindings/power/rk3328-power.h>
>> +
>> +/ {
>> +	compatible = "rockchip,rk3328";
>> +
>> +	interrupt-parent = <&gic>;
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +		serial1 = &uart1;
>> +		serial2 = &uart2;
>> +		i2c0 = &i2c0;
>> +		i2c1 = &i2c1;
>> +		i2c2 = &i2c2;
>> +		i2c3 = &i2c3;
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <2>;
> #address-cells = <1>? You most likely don't need the 2 field cpu regs?

This is likely copy from juno board of arm, and i find that #address-cells = <1> in some  boards and  #address-cells = <2> in the other boards.
All of ROCKCHIP Socs set  #address-cells = <2>, so we set #address-cells = <2> to keep compatibility?
