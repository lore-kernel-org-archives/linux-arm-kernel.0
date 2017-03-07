From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 07 Mar 2017 18:27:21 +0100
Subject: [PATCH v2] ARM: mvebu: add support for the Linksys WRT1900ACS
 (Shelby)
In-Reply-To: <87inobcwk3.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Wed, 15 Feb 2017 16:18:04 +0100")
References: <20170214191744.9419-1-ralph.sennhauser@gmail.com>
 <87inobcwk3.fsf@free-electrons.com>
Message-ID: <87zigxngjq.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,
 
 On mer., f?vr. 15 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Ralph,
>  
>  On mar., f?vr. 14 2017, Ralph Sennhauser <ralph.sennhauser@gmail.com> wrote:
>
>> The Linksys WRT1900ACS (Shelby) is another Armada 385 based router in
>> the Linksys WRT AC Series which got released in October 2015.
>>
>> The file armada-385-linksys-shelby.dts is taken from OpenWrt as-is and
>> originally authored by Imre Kaloz.
>>
>> URL: https://github.com/openwrt/openwrt/blob/8466384db1154a107b86bf3ca10b166a21bd81d0/target/linux/mvebu/files/arch/arm/boot/dts/armada-385-linksys-shelby.dts
>> CC: Imre Kaloz <kaloz@openwrt.org>
>> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
>> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> Acked-by: Jason Cooper <jason@lakedaemon.net>
>
> Applied on mvebu/dt-4.12

It is now in mvebu/dt and in the same time I fixed the title to:
"ARM: dts: armada-385: add support for the Linksys WRT1900ACS (Shelby)"

Gregory

>
> Thanks,
>
> Gregory
>
>> ---
>>
>> Notes:
>>     V1 -> V2:
>>     - Use full instead of shortened URL in commit message (suggested by Jason Cooper)
>>     - add collected tags, thanks to donors ;)
>>
>>  arch/arm/boot/dts/Makefile                      |   1 +
>>  arch/arm/boot/dts/armada-385-linksys-shelby.dts | 114 ++++++++++++++++++++++++
>>  2 files changed, 115 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/armada-385-linksys-shelby.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 0118084..16f1748 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -970,6 +970,7 @@ dtb-$(CONFIG_MACH_ARMADA_38X) += \
>>  	armada-385-db-ap.dtb \
>>  	armada-385-linksys-caiman.dtb \
>>  	armada-385-linksys-cobra.dtb \
>> +	armada-385-linksys-shelby.dtb \
>>  	armada-385-turris-omnia.dtb \
>>  	armada-388-clearfog.dtb \
>>  	armada-388-clearfog-base.dtb \
>> diff --git a/arch/arm/boot/dts/armada-385-linksys-shelby.dts b/arch/arm/boot/dts/armada-385-linksys-shelby.dts
>> new file mode 100644
>> index 0000000..c7a8ddd
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/armada-385-linksys-shelby.dts
>> @@ -0,0 +1,114 @@
>> +/*
>> + * Device Tree file for the Linksys WRT1900ACS (Shelby)
>> + *
>> + * Copyright (C) 2015 Imre Kaloz <kaloz@openwrt.org>
>> + *
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is licensed under the terms of the GNU General Public
>> + *     License version 2.  This program is licensed "as is" without
>> + *     any warranty of any kind, whether express or implied.
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
>> +#include "armada-385-linksys.dtsi"
>> +
>> +/ {
>> +	model = "Linksys WRT1900ACS";
>> +	compatible = "linksys,shelby", "linksys,armada385", "marvell,armada385",
>> +		     "marvell,armada380";
>> +
>> +	soc {
>> +		internal-regs{
>> +			i2c at 11000 {
>> +
>> +				pca9635 at 68 {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +					wan_amber at 0 {
>> +						label = "shelby:amber:wan";
>> +						reg = <0x0>;
>> +					};
>> +
>> +					wan_white at 1 {
>> +						label = "shelby:white:wan";
>> +						reg = <0x1>;
>> +					};
>> +
>> +					wlan_2g at 2 {
>> +						label = "shelby:white:wlan_2g";
>> +						reg = <0x2>;
>> +					};
>> +
>> +					wlan_5g at 3 {
>> +						label = "shelby:white:wlan_5g";
>> +						reg = <0x3>;
>> +					};
>> +
>> +					usb2 at 5 {
>> +						label = "shelby:white:usb2";
>> +						reg = <0x5>;
>> +					};
>> +
>> +					usb3_1 at 6 {
>> +						label = "shelby:white:usb3_1";
>> +						reg = <0x6>;
>> +					};
>> +
>> +					usb3_2 at 7 {
>> +						label = "shelby:white:usb3_2";
>> +						reg = <0x7>;
>> +					};
>> +
>> +					wps_white at 8 {
>> +						label = "shelby:white:wps";
>> +						reg = <0x8>;
>> +					};
>> +
>> +					wps_amber at 9 {
>> +						label = "shelby:amber:wps";
>> +						reg = <0x9>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>> +	gpio-leds {
>> +		power {
>> +			label = "shelby:white:power";
>> +		};
>> +
>> +		sata {
>> +			label = "shelby:white:sata";
>> +		};
>> +	};
>> +};
>> -- 
>> 2.10.2
>>
>
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
