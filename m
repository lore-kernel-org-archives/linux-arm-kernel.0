From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 29 Jul 2015 15:02:00 +0100
Subject: [PATCH v1 3/7] ARM: dts: apq8064-ifc6410: add heart-beat led
 support.
In-Reply-To: <55B7BDB8.7090103@suse.de>
References: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1438088040-17437-1-git-send-email-srinivas.kandagatla@linaro.org>
 <55B7BDB8.7090103@suse.de>
Message-ID: <55B8DCD8.9050404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/07/15 18:36, Andreas F?rber wrote:
> Am 28.07.2015 um 14:54 schrieb Srinivas Kandagatla:
>> This patch adds heart-beat led support on IFC6410.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
>> index df560cf..1fc2ea5 100644
>> --- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
>> +++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
>> @@ -207,6 +207,19 @@
>>   			status = "okay";
>>   		};
>>
>> +		leds {
>> +			compatible = "gpio-leds";
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&notify_led>;
>> +
>> +			led at 1 {
>> +				label = "apq8064:green:user1";
>> +				gpios = <&pm8921_gpio 18 GPIO_ACTIVE_HIGH>;
>> +				linux,default-trigger = "heartbeat";
>
> Can we please drop the heartbeat default? While that's nice as proof of
> concept, it's annoying to deliver it that way in Linux distros. Users
> can enable that trigger with a simple boot script writing to /sys.
>
Thanks for the input, I will change to be none, Let the users decide the 
trigger.

thanks,
srini
> Thanks,
> Andreas
>
>> +				default-state = "on";
>> +			};
>> +		};
>> +
>>   		qcom,ssbi at 500000 {
>>   			pmicintc: pmic at 0 {
>>   				pm8921_gpio: gpio at 150 {
> [snip]
>
