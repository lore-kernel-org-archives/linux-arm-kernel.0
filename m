From: guodong.xu@linaro.org (Guodong Xu)
Date: Tue, 12 Apr 2016 21:14:07 +0800
Subject: [PATCH v2 14/16] arm64: dts: hikey: Add hi655x pmic dts node
In-Reply-To: <20160404051653.GU17806@rob-hp-laptop>
References: <1459589383-16914-1-git-send-email-guodong.xu@linaro.org>
 <1459589383-16914-15-git-send-email-guodong.xu@linaro.org>
 <20160404051653.GU17806@rob-hp-laptop>
Message-ID: <CAFGCpxyhcQEO_t+K+XSeLLL+qky8YDQbb3ewdfYY5Y=FxRy_sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2016 at 13:16, Rob Herring <robh@kernel.org> wrote:
> On Sat, Apr 02, 2016 at 05:29:41PM +0800, Guodong Xu wrote:
>> From: Chen Feng <puck.chen@hisilicon.com>
>>
>> Add the mfd hi655x dts node and regulator support on
>> hi6220 platform.
>>
>> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
>> Signed-off-by: Fei Wang <w.f@huawei.com>
>> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
>> Reviewed-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> Reviewed-by: Guodong Xu <guodong.xu@linaro.org>
>> ---
>>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 87 ++++++++++++++++++++++++++
>>  1 file changed, 87 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>> index 28bc646..a6dffa8 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>> @@ -6,6 +6,7 @@
>>   */
>>
>>  /dts-v1/;
>> +#include <dt-bindings/gpio/gpio.h>
>>
>>  #include "hi6220.dtsi"
>>  #include "hikey-gpio.dtsi"
>> @@ -104,6 +105,92 @@
>>                       default-state = "off";
>>               };
>>       };
>> +
>> +     pmic: pmic at f8000000 {
>> +             compatible = "hisilicon,hi655x-pmic";
>> +             reg = <0x0 0xf8000000 0x0 0x1000>;
>> +             interrupt-controller;
>> +             #interrupt-cells = <2>;
>> +             pmic-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
>> +             status = "okay";
>> +
>> +             regulators {
>> +                     ldo2: LDO2 at a21 {
>
> @a21 is not a unit address. Please drop these.

Will change these to
 +                     ldo2: LDO2 {
...
 +                     ldo7: LDO7 {
...

Thanks for review, Rob.

-Guodong

>
>> +                             regulator-name = "LDO2_2V8";
>> +                             regulator-min-microvolt = <2500000>;
>> +                             regulator-max-microvolt = <3200000>;
>> +                             regulator-enable-ramp-delay = <120>;
>> +                     };
>> +
>> +                     ldo7: LDO7 at a26 {
