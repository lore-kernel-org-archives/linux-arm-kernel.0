From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 26 Feb 2015 18:26:40 +0000
Subject: [PATCH 01/12] ARM: dts: apq8064: add RPM regulators support
In-Reply-To: <A5AB3F5F-7942-4DA0-925E-9033EC929174@codeaurora.org>
References: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424678093-12966-1-git-send-email-srinivas.kandagatla@linaro.org>
 <A5AB3F5F-7942-4DA0-925E-9033EC929174@codeaurora.org>
Message-ID: <54EF6560.6080703@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/02/15 18:25, Kumar Gala wrote:
>
> On Feb 23, 2015, at 1:54 AM, Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
>
>> This patch adds rpm node to apq8064 dt as rpm would be used by other
>> devices for regulator support. Also adds all the regulators in the rpm.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>> arch/arm/boot/dts/qcom-apq8064.dtsi | 241 ++++++++++++++++++++++++++++++++++++
>> 1 file changed, 241 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
>> index b3154c0..db5fc59 100644
>> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
>> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
>> @@ -3,6 +3,7 @@
>> #include "skeleton.dtsi"
>> #include <dt-bindings/clock/qcom,gcc-msm8960.h>
>> #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
>> +#include <dt-bindings/mfd/qcom-rpm.h>
>> #include <dt-bindings/soc/qcom,gsbi.h>
>> #include <dt-bindings/interrupt-controller/arm-gic.h>
>>
>> @@ -246,6 +247,246 @@
>> 			#reset-cells = <1>;
>> 		};
>>
>> +		l2cc: clock-controller at 2011000 {
>> +			compatible	= "syscon";
>> +			reg		= <0x2011000 0x1000>;
>> +		};
>> +
>> +		rpm at 108000 {
>> +			compatible	= "qcom,rpm-apq8064";
>> +			reg		= <0x108000 0x1000>;
>> +			qcom,ipc	= <&l2cc 0x8 2>;
>> +
>> +			interrupts	= <0 19 0>, <0 21 0>, <0 22 0>;
>> +			interrupt-names	= "ack", "err", "wakeup";
>> +
>
> Can you use the defines for GIC for the interrupts.  Also, I think the last property should probably be level high instead of 0.
Yep, I will fix it.

--srini


>
> - k
>
