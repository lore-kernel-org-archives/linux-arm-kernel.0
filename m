From: dingtianhong@huawei.com (Ding Tianhong)
Date: Tue, 1 Sep 2015 09:14:12 +0800
Subject: [PATCH 2/2] arm64: dts: add dts files for Hisilicon Hip05-D02
 Development Board
In-Reply-To: <20150831144019.GA22491@leoy-linaro>
References: <1440838361-1468-1-git-send-email-dingtianhong@huawei.com>
 <1440838361-1468-3-git-send-email-dingtianhong@huawei.com>
 <20150831131244.GB6194@leoy-linaro> <55E45A46.7040805@huawei.com>
 <20150831144019.GA22491@leoy-linaro>
Message-ID: <55E4FBE4.3010808@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/8/31 22:40, Leo Yan wrote:
> On Mon, Aug 31, 2015 at 09:44:38PM +0800, Ding Tianhong wrote:
>> On 2015/8/31 21:12, Leo Yan wrote:
>>> On Sat, Aug 29, 2015 at 04:52:41PM +0800, Ding Tianhong wrote:
>>>> Add initial dtsi file to support Hisilicon Hip05-D02 Board with
>>>> support of CPUs in four clusters and each cluster has quard Cortex-A57.
>>>>
>>>> Also add dts file to support Hip05-D02 development board.
>>>>
>>>> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> ---
>>>>  arch/arm64/boot/dts/hisilicon/Makefile      |   2 +-
>>>>  arch/arm64/boot/dts/hisilicon/hip05-d02.dts |  36 ++++
>>>>  arch/arm64/boot/dts/hisilicon/hip05.dtsi    | 271 ++++++++++++++++++++++++++++
>>>>  3 files changed, 308 insertions(+), 1 deletion(-)
>>>>  create mode 100644 arch/arm64/boot/dts/hisilicon/hip05-d02.dts
>>>>  create mode 100644 arch/arm64/boot/dts/hisilicon/hip05.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
>>>> index fa81a6e..cd158b8 100644
>>>> --- a/arch/arm64/boot/dts/hisilicon/Makefile
>>>> +++ b/arch/arm64/boot/dts/hisilicon/Makefile
>>>> @@ -1,4 +1,4 @@
>>>> -dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb
>>>> +dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb hip05-d02.dtb
>>>>  
>>>>  always		:= $(dtb-y)
>>>>  subdir-y	:= $(dts-dirs)
>>>> diff --git a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
>>>> new file mode 100644
>>>> index 0000000..ae34e25
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
>>>> @@ -0,0 +1,36 @@
>>>> +/**
>>>> + * dts file for Hisilicon D02 Development Board
>>>> + *
>>>> + * Copyright (C) 2014,2015 Hisilicon Ltd.
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * publishhed by the Free Software Foundation.
>>>> + *
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "hip05.dtsi"
>>>> +
>>>> +/ {
>>>> +	model = "Hisilicon Hip05 D02 Development Board";
>>>> +	compatible = "hisilicon,hip05-d02";
>>>> +
>>>> +	memory at 00000000 {
>>>> +		device_type = "memory";
>>>> +		reg = <0x0 0x00000000 0x0 0x80000000>;
>>>> +	};
>>>> +
>>>> +	aliases {
>>>> +		serial0 = &uart0;
>>>> +	};
>>>> +
>>>> +	chosen {
>>>> +		stdout-path = "serial0:115200n8";
>>>> +	};
>>>> +};
>>>> +
>>>> +&uart0 {
>>>> +	status = "ok";
>>>> +};
>>>> diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
>>>> new file mode 100644
>>>> index 0000000..da12d94
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
>>>> @@ -0,0 +1,271 @@
>>>> +/**
>>>> + * dts file for Hisilicon D02 Development Board
>>>> + *
>>>> + * Copyright (C) 2014,2015 Hisilicon Ltd.
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * publishhed by the Free Software Foundation.
>>>> + *
>>>> + */
>>>> +
>>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +
>>>> +/ {
>>>> +	compatible = "hisilicon,hip05-d02";
>>>> +	interrupt-parent = <&gic>;
>>>> +	#address-cells = <2>;
>>>> +	#size-cells = <2>;
>>>> +
>>>> +	psci {
>>>> +		compatible = "arm,psci-0.2";
>>>> +		method = "smc";
>>>> +	};
>>>> +
>>>> +	cpus {
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <0>;
>>>> +
>>>> +		cpu-map {
>>>> +			cluster0 {
>>>> +				core0 {
>>>> +					cpu = <&cpu0>;
>>>> +				};
>>>> +				core1 {
>>>> +					cpu = <&cpu1>;
>>>> +				};
>>>> +				core2 {
>>>> +					cpu = <&cpu2>;
>>>> +				};
>>>> +				core3 {
>>>> +					cpu = <&cpu3>;
>>>> +				};
>>>> +			};
>>>> +			cluster1 {
>>>> +				core0 {
>>>> +					cpu = <&cpu4>;
>>>> +				};
>>>> +				core1 {
>>>> +					cpu = <&cpu5>;
>>>> +				};
>>>> +				core2 {
>>>> +					cpu = <&cpu6>;
>>>> +				};
>>>> +				core3 {
>>>> +					cpu = <&cpu7>;
>>>> +				};
>>>> +			};
>>>> +			cluster2 {
>>>> +				core0 {
>>>> +					cpu = <&cpu8>;
>>>> +				};
>>>> +				core1 {
>>>> +					cpu = <&cpu9>;
>>>> +				};
>>>> +				core2 {
>>>> +					cpu = <&cpu10>;
>>>> +				};
>>>> +				core3 {
>>>> +					cpu = <&cpu11>;
>>>> +				};
>>>> +			};
>>>> +			cluster3 {
>>>> +				core0 {
>>>> +					cpu = <&cpu12>;
>>>> +				};
>>>> +				core1 {
>>>> +					cpu = <&cpu13>;
>>>> +				};
>>>> +				core2 {
>>>> +					cpu = <&cpu14>;
>>>> +				};
>>>> +				core3 {
>>>> +					cpu = <&cpu15>;
>>>> +				};
>>>> +			};
>>>> +		};
>>>> +
>>>> +		cpu0: cpu at 20000 {
>>>> +			device_type = "cpu";
>>>> +			compatible = "arm,armv8";
>>>
>>> Change to "arm,cortex-a57","arm,armv8"?
>>>
>>
>> Ok?but I think should be "hisilicon,hip05","arm,armv8".
> 
> If the CPU is a starndard ARM core (such like CA53, CA57, etc), you
> need directly use the CPU type which has been defined in:
> Documentation/devicetree/bindings/arm/cpus.txt. So here hip05 is the
> naming code for SoC? or for the CPU customized by Hisilicon?
> 
> [...]

Hip05 is the name for SoC.

> 
> Thanks,
> Leo Yan
> 
> .
> 
