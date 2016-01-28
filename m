From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Thu, 28 Jan 2016 13:18:17 -0500
Subject: [PATCH v6 3/7] ARM: dts: imx: Add Advantech BA-16 Qseven module
In-Reply-To: <20160128054124.GD9070@tiger>
References: <1450908016-17384-1-git-send-email-akshay.bhat@timesys.com>
 <1450908016-17384-4-git-send-email-akshay.bhat@timesys.com>
 <20160128054124.GD9070@tiger>
Message-ID: <56AA5B69.8090906@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/28/2016 12:41 AM, Shawn Guo wrote:
> On Wed, Dec 23, 2015 at 05:00:12PM -0500, Akshay Bhat wrote:
>> From: Justin Waters <justin.waters@timesys.com>
>>
>> Add support for Advantech BA-16 module based on iMX6D processor
>>
>> http://www2.advantech.com/products/medical_computing_system/dms-ba16/mod_64aa1566-169c-483d-97c8-c2c22c163fc3.aspx
>> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
>> ---
>>   arch/arm/boot/dts/imx6q-ba16.dtsi | 641 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 641 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/imx6q-ba16.dtsi
>>
>> diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
>> new file mode 100644
>> index 0000000..f130037
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
>> @@ -0,0 +1,641 @@
>> +/*
>> + * Support for imx6 based Advantech DMS-BA16 Qseven module
>> + *
>> + * Copyright 2015 Timesys Corporation.
>> + * Copyright 2015 General Electric Company
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License
>> + *     version 2 as published by the Free Software Foundation.
>> + *
>> + *     This file is distributed in the hope that it will be useful
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +#include "imx6q.dtsi"
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +	memory {
>> +		reg = <0x10000000 0x40000000>;
>> +	};
>> +
>> +	clocks {
>> +		clk24m: clk24m {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <24000000>;
>> +		};
>
> How is this clock used on the board?
>
Was a leftover, will remove it in the next rev.

>> +	};
>> +
>> +	backlight_lvds: backlight {
>> +		compatible = "pwm-backlight";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_display>;
>> +		pwms = <&pwm1 0 5000000>;
>> +		brightness-levels = <  0   1   2   3   4   5   6   7   8   9
>> +				      10  11  12  13  14  15  16  17  18  19
>> +				      20  21  22  23  24  25  26  27  28  29
>> +				      30  31  32  33  34  35  36  37  38  39
>> +				      40  41  42  43  44  45  46  47  48  49
>> +				      50  51  52  53  54  55  56  57  58  59
>> +				      60  61  62  63  64  65  66  67  68  69
>> +				      70  71  72  73  74  75  76  77  78  79
>> +				      80  81  82  83  84  85  86  87  88  89
>> +				      90  91  92  93  94  95  96  97  98  99
>> +				     100 101 102 103 104 105 106 107 108 109
>> +				     110 111 112 113 114 115 116 117 118 119
>> +				     120 121 122 123 124 125 126 127 128 129
>> +				     130 131 132 133 134 135 136 137 138 139
>> +				     140 141 142 143 144 145 146 147 148 149
>> +				     150 151 152 153 154 155 156 157 158 159
>> +				     160 161 162 163 164 165 166 167 168 169
>> +				     170 171 172 173 174 175 176 177 178 179
>> +				     180 181 182 183 184 185 186 187 188 189
>> +				     190 191 192 193 194 195 196 197 198 199
>> +				     200 201 202 203 204 205 206 207 208 209
>> +				     210 211 212 213 214 215 216 217 218 219
>> +				     220 221 222 223 224 225 226 227 228 229
>> +				     230 231 232 233 234 235 236 237 238 239
>> +				     240 241 242 243 244 245 246 247 248 249
>> +				     250 251 252 253 254 255>;
>> +		default-brightness-level = <255>;
>> +		enable-gpios = <&gpio4 15 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	reg_1p8v: regulator-1p8v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "1P8V";
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		regulator-always-on;
>> +	};
>> +
>> +	reg_3p3v: regulator-3p3v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "3P3V";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-always-on;
>> +	};
>> +
>> +	reg_lvds: regulator-lvds {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "lvds_ppen";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +	};
>> +
>> +	reg_usb_h1_vbus: regulator-usb_h1_vbus {
>
> As a convention, hyphen instead of underscore should be used in node
> name.  I would suggest to simply name it like regulator-usbh1vbus to
> save additional hyphens.
>
Thanks, was not aware of the convention. Will fix this for all 
nodes/patches.

>> +		compatible = "regulator-fixed";
>> +		regulator-name = "usb_h1_vbus";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +	};
>> +
>> +	reg_usb_otg_vbus: regulator-usb_otg_vbus {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "usb_otg_vbus";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +	};
>> +};
>
> <snip>
>
>> +&usdhc2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usdhc2>;
>> +	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
>> +	no-1-8-v;
>> +	keep-power-in-suspend;
>> +	enable-sdio-wakeup;
>
> Since commit 0dbcdc0622ea (mmc: core: enable support for the standard
> "wakeup-source" property), enable-sdio-wakeup becomes a legacy property.
> Please use the new standard one.
>
> Shawn
>

Will fix this.
