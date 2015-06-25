From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 25 Jun 2015 16:52:14 +0530
Subject: [PATCH-v4 3/3] mfd: devicetree: bindings: Add new 88pm800 mfd
 binding
In-Reply-To: <20150625102823.GD15013@x1>
References: <1435217189-19578-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1435217189-19578-4-git-send-email-vaibhav.hiremath@linaro.org>
 <20150625102823.GD15013@x1>
Message-ID: <558BE466.3090408@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 25 June 2015 03:58 PM, Lee Jones wrote:
> On Thu, 25 Jun 2015, Vaibhav Hiremath wrote:
>
>> With addition of DT support to 88pm800 mfd driver, this patch
>> adds new DT binding documentation along with respective properties.
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/mfd/88pm800.txt | 54 +++++++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/88pm800.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt b/Documentation/devicetree/bindings/mfd/88pm800.txt
>> new file mode 100644
>> index 0000000..f56b751
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
>> @@ -0,0 +1,54 @@
>> +* Marvell 88PM8xx Power Management IC
>> +
>> +Required parent device properties:
>> +- compatible : "marvell,88pm800", "marvell,88pm805", "marvell,88pm860"
>> +- reg : the I2C slave address for the 88pm8xx chip
>> +- interrupts : IRQ line for the 88pm8xx chip
>> +- interrupt-controller: describes the 88pm8xx as an interrupt controller
>> +- #interrupt-cells : should be 1.
>> +		- The cell is the 88pm8xx local IRQ number
>
> Might just be a personal thing, but I would line up the ':', it's much
> easier on the eyes that way.

Ok,

>
>> +88pm8xx family of devices consists of varied group of sub-devices:
>> +
>> +Device		 	Supply Names	 Description
>> +------		 	------------	 -----------
>> +88pm80x-onkey		:		: On key
>> +88pm80x-rtc		:		: RTC
>> +88pm80x-regulator	:		: Regulators
>> +
>> +Note: More device list will follow
>
> No real need for this.
>

I deliberately added it, as I was sure i would get comment if I only
put e devices in the list. And guess what, as expected I got comment.

Anyway, I agree and Will remove it.

Thanks,
Vaibhav
