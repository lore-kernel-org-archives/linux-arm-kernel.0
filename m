From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed, 24 Jun 2015 10:49:47 +0530
Subject: [PATCH-v2 3/3] mfd: devicetree: bindings: Add new 88pm800 mfd
 binding
In-Reply-To: <CAJKOXPf7OuGfxsZeewoimyyCRKGqjH+j-S81cAH=6DSRQmaS0A@mail.gmail.com>
References: <vaibhav.hiremath@linaro.org>	<1434567488-6477-1-git-send-email-vaibhav.hiremath@linaro.org>	<1434567488-6477-5-git-send-email-vaibhav.hiremath@linaro.org>
 <CAJKOXPf7OuGfxsZeewoimyyCRKGqjH+j-S81cAH=6DSRQmaS0A@mail.gmail.com>
Message-ID: <558A3DF3.5030804@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 24 June 2015 05:59 AM, Krzysztof Kozlowski wrote:
> 2015-06-18 3:58 GMT+09:00 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>:
>> With addition of DT support to 88pm800 mfd driver, this patch
>> adds new DT binding documentation along with respective properties.
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/mfd/88pm800.txt | 60 +++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/88pm800.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt b/Documentation/devicetree/bindings/mfd/88pm800.txt
>> new file mode 100644
>> index 0000000..b8e72df
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
>> @@ -0,0 +1,60 @@
>> +* Marvell 88PM8xx Power Management IC
>> +
>> +Required parent device properties:
>> +- compatible : "marvell,88pm800", "marvell,88pm805", "marvell,88pm860"
>> +- reg : the I2C slave address for the 88pm8xx chip
>> +- interrupts : IRQ line for the 88pm8xx chip
>> +- interrupt-controller: describes the 88pm8xx as an interrupt controller
>> +- #interrupt-cells : should be 1.
>> +               - The cell is the 88pm8xx local IRQ number
>> +
>> +Optional parent device properties:
>> +- marvell,irq-clr-on-write: indicates whether interrupt status is cleared
>> +  by write or read.
>> +  If enabled, interrupt is cleared by write else just read would do.
>> +
>> +88pm8xx family of devices consists of varied group of sub-devices:
>> +
>> +Device                 Supply Names     Description
>> +------                 ------------     -----------
>> +88pm80x-onkey          :               : On key
>> +88pm80x-rtc            :               : RTC
>> +88pm80x-regulator      :               : Regulators
>> +
>> +Note: More device list will follow
>> +
>> +Example:
>> +
>> +       pmic: 88pm800 at 30 {
>> +               compatible = "marvell,88pm800";
>> +               reg = <0x30>;
>> +               interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
>> +               interrupt-parent = <&gic>;
>> +               interrupt-controller;
>> +               #interrupt-cells = <1>;
>> +
>> +               marvell,irq-clr-on-write;
>> +
>> +               regulators {
>> +                       compatible = "marvell,88pm80x-regulator";
>> +
>> +                       buck1a: BUCK1A {
>> +                               regulator-compatible = "88PM800-BUCK1A";
>
> That's a deprecated property.
> Documentation/devicetree/bindings/regulator/regulator.txt
>

Yes,

Will replace with regulator-name and resubmit shortly with Rob's
Acked-by.



Thanks,
Vaibhav
