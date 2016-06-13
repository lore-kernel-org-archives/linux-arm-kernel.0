From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 13 Jun 2016 17:21:16 +0100
Subject: [PATCH v2 2/2] ARM: dts: sd_600eval: Fix eMMC lockup issue
In-Reply-To: <20160612044736.GS1256@tuxbot>
References: <1465582795-30266-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1465582795-30266-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20160612044736.GS1256@tuxbot>
Message-ID: <575EDD7C.8010504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/06/16 05:47, Bjorn Andersson wrote:
> On Fri 10 Jun 11:19 PDT 2016, Srinivas Kandagatla wrote:
>
>> From: Parth Pancholi <parth.pancholi@einfochips.com>
>>
>> This board locks up if we stress test the eMMC, as the regulator s4 is
>> unable to supply enough current for all the peripherials attached to it.
>> As this supply is wired up to most of the peripherials including DDR,
>> it resulted in such lockup.
>>
>> This patch fixes this issue by setting s4 regulator correctly with
>> Auto power mode.
>>
>> Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> [Srinivas Kandagatla: rewrote the change log]
>> Tested-by: Girish Sharma <girish.sharma@einfochips.com>
>> Signed-off-by: Parth Pancholi <parth.pancholi@einfochips.com>
>
> If I read the msm-3.4 tree correctly most (perhaps all) 8064 devices
> should have this setup.
>
I agree, we should patch other boards as well with the same value.


> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

thanks,
srini
>
> Regards,
> Bjorn
>
>> ---
>>   arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
>> index 7df0108..39ae2bc 100644
>> --- a/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
>> +++ b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
>> @@ -1,6 +1,7 @@
>>   #include "qcom-apq8064-v2.0.dtsi"
>>   #include "qcom-apq8064-arrow-sd-600eval-pins.dtsi"
>>   #include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/mfd/qcom-rpm.h>
>>
>>   / {
>>   	model = "Arrow Electronics, APQ8064 SD_600eval";
>> @@ -82,7 +83,8 @@
>>   				s4 {
>>   					regulator-min-microvolt	= <1800000>;
>>   					regulator-max-microvolt	= <1800000>;
>> -					qcom,switch-mode-frequency = <3200000>;
>> +					qcom,switch-mode-frequency = <1600000>;
>> +					qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
>>   					bias-pull-down;
>>   					regulator-always-on;
>>   				};
>> --
>> 2.8.3
>>
