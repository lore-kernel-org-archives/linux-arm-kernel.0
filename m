From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 20 May 2014 15:08:41 +0200
Subject: [PATCH v6 3/4] ARM: dts: Add STiH407 SoC support
In-Reply-To: <20140520121717.GL24991@lee--X1>
References: <1400579192-17620-1-git-send-email-maxime.coquelin@st.com>
 <1400579192-17620-4-git-send-email-maxime.coquelin@st.com>
 <20140520121717.GL24991@lee--X1>
Message-ID: <537B53D9.9080206@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/20/2014 02:17 PM, Lee Jones wrote:
>> The STiH407 is advanced multi-HD AVC processor with 3D graphics acceleration
>> and 1.5-GHz ARM Cortex-A9 SMP CPU.
>>
>> Acked-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>> Acked-by: Patrice Chotard <patrice.chotard@st.com>
>> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
>> ---
>>   arch/arm/boot/dts/stih407-clock.dtsi   |  40 +++
>>   arch/arm/boot/dts/stih407-pinctrl.dtsi | 615 +++++++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/stih407.dtsi         | 263 ++++++++++++++
>>   3 files changed, 918 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/stih407-clock.dtsi
>>   create mode 100644 arch/arm/boot/dts/stih407-pinctrl.dtsi
>>   create mode 100644 arch/arm/boot/dts/stih407.dtsi
>>
>> diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
>> new file mode 100644
>> index 0000000..ae8068c
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/stih407-clock.dtsi
>> @@ -0,0 +1,40 @@
>> +/*
>> + * Copyright (C) 2014 STMicroelectronics R&D Limited
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +/ {
>> +	clocks {
>> +		/*
>> +		 * Fixed 30MHz oscillator inputs to SoC
>> +		 */
>> +		CLK_SYSIN: CLK_SYSIN {
>
> I thought we weren't using upper case clk names anymore?
>
>> +			#clock-cells = <0>;
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <30000000>;
>> +			clock-output-names = "CLK_SYSIN";
>> +		};
>> +
>> +		/*
>> +		 * ARM Peripheral clock for timers
>> +		 */
>> +		arm_periph_clk: arm_periph_clk {
>> +			#clock-cells = <0>;
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <600000000>;
>> +		};
>> +
>> +		/*
>> +		 * Bootloader initialized system infrastructure clock for
>> +		 * serial devices.
>> +		 */
>> +		CLK_EXT2F_A9: clockgenC0 at 13 {
>
> Or camel?

Good catch, v7 is in the pipe.

Thanks,
Maxime

>
> [...]
>
