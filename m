From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 11 Aug 2015 08:32:36 -0500
Subject: [PATCH] arm64: dts: Add base stratix 10 dtsi
In-Reply-To: <20150811103902.38cbcb6d@xhacker>
References: <1439240958-4713-1-git-send-email-dinguyen@opensource.altera.com>
 <20150811103902.38cbcb6d@xhacker>
Message-ID: <55C9F974.90102@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

On 8/10/15 9:39 PM, Jisheng Zhang wrote:
> On Mon, 10 Aug 2015 16:09:18 -0500
> <dinguyen@opensource.altera.com> wrote:
> 
>> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>>
>> Add the base DTS for Altera's SoCFPGA Stratix 10 platform.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
>> ---
>>  arch/arm64/Kconfig                                 |   5 +
>>  arch/arm64/boot/dts/Makefile                       |   1 +
>>  arch/arm64/boot/dts/altera/Makefile                |   5 +
>>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 354 +++++++++++++++++++++
>>  .../boot/dts/altera/socfpga_stratix10_socdk.dts    |  38 +++
>>  arch/arm64/configs/defconfig                       |   1 +
>>  6 files changed, 404 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/altera/Makefile
>>  create mode 100644 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>>  create mode 100644 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 318175f..0f8ab2b 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -207,6 +207,11 @@ config ARCH_SEATTLE
>>  	help
>>  	  This enables support for AMD Seattle SOC Family
>>  
>> +config ARCH_STRATIX10
>> +	bool "Altera's Stratix 10 SoCFPGA Family"
>> +	help
>> +	  This enables support for Altera's Stratix 10 SoCFPGA Family
>> +
>>  config ARCH_TEGRA
>>  	bool "NVIDIA Tegra SoC Family"
>>  	select ARCH_HAS_RESET_CONTROLLER
>> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
>> index 38913be..7fb421a 100644
>> --- a/arch/arm64/boot/dts/Makefile
>> +++ b/arch/arm64/boot/dts/Makefile
>> @@ -1,3 +1,4 @@
>> +dts-dirs += altera
>>  dts-dirs += amd
>>  dts-dirs += apm
>>  dts-dirs += arm
>> diff --git a/arch/arm64/boot/dts/altera/Makefile b/arch/arm64/boot/dts/altera/Makefile
>> new file mode 100644
>> index 0000000..d7a6416
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/altera/Makefile
>> @@ -0,0 +1,5 @@
>> +dtb-$(CONFIG_ARCH_STRATIX10) += socfpga_stratix10_socdk.dtb
>> +
>> +always		:= $(dtb-y)
>> +subdir-y	:= $(dts-dirs)
>> +clean-files	:= *.dtb
>> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>> new file mode 100644
>> index 0000000..34f6dc3
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>> @@ -0,0 +1,354 @@
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
>> +/dts-v1/;
>> +
>> +/ {
>> +	compatible = "altr,socfpga-stratix10";
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +
> [...]
>> +
>> +	pmu {
>> +		compatible = "arm,armv8-pmuv3";
>> +		interrupts = <0 120 8>,
>> +			     <0 121 8>,
>> +			     <0 122 8>,
>> +			     <0 123 8>;
> 
> it's better to add interrupt-affinity according to Sudeep's suggestions.
> 

Ok, will update in V2. Thanks for reviewing.

Dinh
