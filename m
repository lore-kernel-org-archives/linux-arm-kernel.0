From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 15 Jul 2015 15:46:31 -0500
Subject: [PATCH] ARM: dts: socfpga: Add support of Terasic DE0 Atlas board
In-Reply-To: <20150715080258.GA29885@pengutronix.de>
References: <1436908987-16038-1-git-send-email-dinguyen@opensource.altera.com>
 <20150715080258.GA29885@pengutronix.de>
Message-ID: <55A6C6A7.5040100@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2015 03:02 AM, Steffen Trumtrar wrote:
> Hi!
> 
> On Tue, Jul 14, 2015 at 04:23:07PM -0500, dinguyen at opensource.altera.com wrote:
>> From: Dalon Westergreen <dwesterg@gmail.com>
>>
>> The Terasic DE0 Atlas board is also known as the DE0-Nano board.
>>
>> Signed-off-by: Dalon Westergreen <dwesterg@gmail.com>
>> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
>> ---
>>  arch/arm/boot/dts/Makefile                        |    1 +
>>  arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts |  109 +++++++++++++++++++++
>>  2 files changed, 110 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 246473a..29e33aa 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -522,6 +522,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) += \
>>  	socfpga_arria5_socdk.dtb \
>>  	socfpga_arria10_socdk_sdmmc.dtb \
>>  	socfpga_cyclone5_socdk.dtb \
>> +	socfpga_cyclone5_de0_sockit.dtb \
>                              ^^^^^^
> 
> Is that intentional? Terasic doesn't mention sockit at all in the name
> of the board.
> 

Yes. From the Terasic website[1], they name it DE0-Nano-SoCKit/Atlas-SoCKit.

>>  	socfpga_cyclone5_sockit.dtb \
>>  	socfpga_cyclone5_socrates.dtb \
>>  	socfpga_vt.dtb
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
>> new file mode 100644
>> index 0000000..3172c82
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
>> @@ -0,0 +1,109 @@
>> +/*
>> + * Copyright Altera Corporation (C) 2015. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include "socfpga_cyclone5.dtsi"
>> +
>> +/ {
>> +	model = "Terasic DE-0(Atlas)";
>> +	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
>> +
>> +	chosen {
>> +		bootargs = "console=ttyS0,115200";

Use stdpath-out here.

>> +	};
>> +
>> +	memory {
>> +		name = "memory";
>> +		device_type = "memory";
>> +		reg = <0x0 0x40000000>; /* 1GB */
>> +	};
>> +
>> +	aliases {
>> +		/* this allow the ethaddr uboot environmnet variable contents
>> +		 * to be added to the gmac1 device tree blob.
>> +		 */
> 
> I'd personally like to get rid of these types of comments in the dts.
> It doesn't matter what uboot needs or does IMHO.
> 

Thats fine, I can remove the comment.

Dinh

[1]
http://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=165&No=941
