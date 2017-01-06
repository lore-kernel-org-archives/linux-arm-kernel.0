From: puck.chen@hisilicon.com (Chen Feng)
Date: Fri, 6 Jan 2017 08:59:19 +0800
Subject: [RESEND 2/2] arm64: dts: Add dts files for Hisilicon Hi3660 SoC
In-Reply-To: <20170105141456.GA5710@hector.attlocal.net>
References: <1482744972-56622-1-git-send-email-puck.chen@hisilicon.com>
 <1482744972-56622-2-git-send-email-puck.chen@hisilicon.com>
 <20170105141456.GA5710@hector.attlocal.net>
Message-ID: <586EEBE7.4050709@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/1/5 22:14, Andy Gross wrote:
> On Mon, Dec 26, 2016 at 05:36:12PM +0800, Chen Feng wrote:
>> Add initial dtsi file to support Hisilicon Hi3660 SoC with
>> support of Octal core CPUs in two clusters(4 * A53 & 4 * A73).
>>
>> Also add dts file to support HiKey960 development board which
>> based on Hi3660 SoC.
>> The output console is earlycon "earlycon=pl011,0xfdf05000".
>> And the con_init uart5 with a fixed clock, which already
>> configured at bootloader.
>>
>> When clock is available, the uart5 will be modified.
>>
>> Tested on HiKey960 Board.
>>
>> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
>> ---
>>  arch/arm64/boot/dts/hisilicon/Makefile            |   1 +
>>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts |  34 +++++
>>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 156 ++++++++++++++++++++++
>>  3 files changed, 191 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
>>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
>> index d5f43a0..b633b5d 100644
>> --- a/arch/arm64/boot/dts/hisilicon/Makefile
>> +++ b/arch/arm64/boot/dts/hisilicon/Makefile
>> @@ -1,4 +1,5 @@
>>  dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb
>> +dtb-$(CONFIG_ARCH_HISI) += hi3660-hikey960.dtb
>>  dtb-$(CONFIG_ARCH_HISI) += hip05-d02.dtb
>>  dtb-$(CONFIG_ARCH_HISI) += hip06-d03.dtb
>>  
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
>> new file mode 100644
>> index 0000000..3d7aead
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
>> @@ -0,0 +1,34 @@
>> +/*
>> + * dts file for Hisilicon HiKey960 Development Board
>> + *
>> + * Copyright (C) 2016, Hisilicon Ltd.
>> + *
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "hi3660.dtsi"
>> +
>> +/ {
>> +	model = "HiKey960";
>> +	compatible = "hisilicon,hi3660";
>> +
>> +	aliases {
>> +		serial5 = &uart5;       /* console UART */
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial5:115200n8";
>> +	};
>> +
>> +	memory at 0 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x00400000 0x0 0xBFE00000>;
> 
> Use lower case letters for hex numbers.  0xbfe00000.
> 


ok, thanks!
>> +	};
>> +
>> +	soc {
>> +		uart5: uart at fdf05000 {
>> +			status = "ok";
>> +		};
>> +	};
>> +};
> 
> <snip>
> 
> Regards,
> 
> Andy
> 
> .
> 
