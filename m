From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 14 Mar 2016 16:21:08 +0900
Subject: [PATCH 08/10] ARM: dts: Add rtc and adc dt node for
 exynos3250-artik5 module
In-Reply-To: <56E66462.9000402@samsung.com>
References: <1457921056-21257-1-git-send-email-cw00.choi@samsung.com>
 <1457921056-21257-10-git-send-email-cw00.choi@samsung.com>
 <56E66462.9000402@samsung.com>
Message-ID: <56E66664.3020405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 03? 14? 16:12, Krzysztof Kozlowski wrote:
> On 14.03.2016 11:04, Chanwoo Choi wrote:
>> This patch adds the RTC (Real Time Clock) and ADC (Analog Digital Converter)
>> Device Tree node for exynos3250-artik5 module. The RTC is used for wakeup
>> source and the ADC is used to read the analog data such as battery temperature.
>>
>> ADC need to connect the some H/W device such as battery. So, this patch just
>> adds the default setting (clock, regulator).
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos3250-artik5.dtsi | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
>> index 877e4827df83..673883fda480 100644
>> --- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
>> +++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
>> @@ -48,6 +48,12 @@
>>  	};
>>  };
>>  
>> +&adc {
>> +	vdd-supply = <&ldo7_reg>;
>> +	assigned-clocks = <&cmu CLK_SCLK_TSADC>;
>> +	assigned-clock-rates = <6000000>;
>> +};
> 
> No thermistors, status non-okay. What is provided here?

The some device are not connected for ADC line on artik5-eval board.
This dt node just initialize the basic setting (clock,regulator) ADC of exynos3250 SoC.
(I'll change the board name from artik5-devel to artik5-eval on v2 patchset)

The vdd-supply for ADC is already fixed on artik5 module.

> 
>> +
>>  &cpu0 {
>>  	cpu0-supply = <&buck2_reg>;
>>  };
>> @@ -319,6 +325,12 @@
>>  	status = "okay";
>>  };
>>  
>> +&rtc {
>> +	clocks = <&cmu CLK_RTC>, <&s2mps14_osc S2MPS11_CLK_AP>;
>> +	clock-names = "rtc", "rtc_src";
>> +	status = "okay";
>> +};
> 
> Same comment as for previous patch - just squash it. Splitting brings no
> benefits and makes it more difficult to see bigger picture.

Okay. I'll merge it with 5/10 patch.

Best Regards,
Chanwoo Choi
