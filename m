From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Fri, 24 Apr 2015 08:19:25 +0530
Subject: [RFC 5/7] arm: dts: msm8974: Add thermal zones, tsens and eeprom
 nodes
In-Reply-To: <20150423165146.GB555@linaro.org>
References: <1429796773-7151-1-git-send-email-rnayak@codeaurora.org>
 <1429796773-7151-6-git-send-email-rnayak@codeaurora.org>
 <20150423165146.GB555@linaro.org>
Message-ID: <5539AF35.1000600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2015 10:21 PM, Lina Iyer wrote:
> On Thu, Apr 23 2015 at 07:52 -0600, Rajendra Nayak wrote:
>> Add thermal zones, tsens and eeprom nodes
>
> I dont see corresponding patches for 8084 and 8916.

I did not add 8916 as the dts for it isn't upstream (yet), and
I hadn't tested on 8084 but I can certainly do so and update the
dts files when I do a respin.

>
> -- Lina
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>> arch/arm/boot/dts/qcom-msm8974.dtsi | 105
>> ++++++++++++++++++++++++++++++++++++
>> 1 file changed, 105 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> index e265ec1..5716e89 100644
>> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> @@ -57,6 +57,88 @@
>>         };
>>     };
>>
>> +    thermal-zones {
>> +        cpu-thermal0 {
>> +            polling-delay-passive = <250>;
>> +            polling-delay = <1000>;
>> +
>> +            thermal-sensors = <&tsens 5>;
>> +
>> +            trips {
>> +                cpu_alert0: trip at 0 {
>> +                    temperature = <100000>;
>> +                    hysteresis = <2000>;
>> +                    type = "passive";
>> +                };
>> +                cpu_crit0: trip at 1 {
>> +                    temperature = <125000>;
>> +                    hysteresis = <2000>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +
>> +        cpu-thermal1 {
>> +            polling-delay-passive = <250>;
>> +            polling-delay = <1000>;
>> +
>> +            thermal-sensors = <&tsens 6>;
>> +
>> +            trips {
>> +                cpu_alert1: trip at 0 {
>> +                    temperature = <100000>;
>> +                    hysteresis = <2000>;
>> +                    type = "passive";
>> +                };
>> +                cpu_crit1: trip at 1 {
>> +                    temperature = <125000>;
>> +                    hysteresis = <2000>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +
>> +        cpu-thermal2 {
>> +            polling-delay-passive = <250>;
>> +            polling-delay = <1000>;
>> +
>> +            thermal-sensors = <&tsens 7>;
>> +
>> +            trips {
>> +                cpu_alert2: trip at 0 {
>> +                    temperature = <100000>;
>> +                    hysteresis = <2000>;
>> +                    type = "passive";
>> +                };
>> +                cpu_crit2: trip at 1 {
>> +                    temperature = <125000>;
>> +                    hysteresis = <2000>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +
>> +        cpu-thermal3 {
>> +            polling-delay-passive = <250>;
>> +            polling-delay = <1000>;
>> +
>> +            thermal-sensors = <&tsens 8>;
>> +
>> +            trips {
>> +                cpu_alert3: trip at 0 {
>> +                    temperature = <100000>;
>> +                    hysteresis = <2000>;
>> +                    type = "passive";
>> +                };
>> +                cpu_crit3: trip at 1 {
>> +                    temperature = <125000>;
>> +                    hysteresis = <2000>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +    };
>> +
>>     cpu-pmu {
>>         compatible = "qcom,krait-pmu";
>>         interrupts = <1 7 0xf04>;
>> @@ -85,6 +167,29 @@
>>                   <0xf9002000 0x1000>;
>>         };
>>
>> +        qfprom: qfprom at fc4bc000 {
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            compatible = "qcom,qfprom";
>> +            reg = <0xfc4bc000 0x1000>;
>> +            tsens_calib: calib at d0 {
>> +                reg = <0xd0 0x18>;
>> +            };
>> +            tsens_backup: backup at 440 {
>> +                reg = <0x440 0x10>;
>> +            };
>> +        };
>> +
>> +        tsens: thermal-sensor at fc4a8000 {
>> +            compatible = "qcom,msm8974-tsens";
>> +            reg = <0xfc4a8000 0x2000>;
>> +            calib = <&tsens_calib>;
>> +            calib_backup = <&tsens_backup>;
>> +            qcom,tsens-slopes = <3200 3200 3200 3200 3200 3200
>> +                3200 3200 3200 3200 3200>;
>> +            #thermal-sensor-cells = <1>;
>> +        };
>> +
>>         timer at f9020000 {
>>             #address-cells = <1>;
>>             #size-cells = <1>;
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation
>>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
