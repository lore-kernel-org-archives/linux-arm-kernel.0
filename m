From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 13 Jul 2015 12:40:57 +0530
Subject: [PATCH 2/6] mfd: 88pm800: Add init time initial configuration
 support
In-Reply-To: <55A0BD78.8050005@samsung.com>
References: <1436442431-3471-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436442431-3471-3-git-send-email-vaibhav.hiremath@linaro.org>
 <55A0BD78.8050005@samsung.com>
Message-ID: <55A36481.80206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 11 July 2015 12:23 PM, Krzysztof Kozlowski wrote:
> W dniu 09.07.2015 o 20:47, Vaibhav Hiremath pisze:
>> This patch adds init time configuration of 88PM800/805 and
>> 88PM860. It includes,
>>
>>    - Enable BUCK clock gating in low power mode
>>    - Full mode support for BUCK2 and 4
>>    - Enable voltage change (LPF, DVC) in PMIC
>>
>> Note that both 88PM800 and 88PM860 do share common configurations,
>> but since I can not validate the configuration on 88PM800,
>> restricting myself only to 88PM860.
>> If anyone can validate on 88PM800, we can move common code accordingly.
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>
> Although I am not familiar with the device and driver, patch looks good
> to me, except one idea below. Anyway feel free to add:
>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>

Thanks for your review.

>
>> ---
>>   drivers/mfd/88pm800.c       | 64 +++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/mfd/88pm80x.h | 13 +++++++++
>>   2 files changed, 77 insertions(+)
>>
>> diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
>> index 95c8ad4..80a1bc1 100644
>> --- a/drivers/mfd/88pm800.c
>> +++ b/drivers/mfd/88pm800.c
>> @@ -521,6 +521,63 @@ out:
>>   	return ret;
>>   }
>>
>> +static int pm800_init_config(struct pm80x_chip *chip, struct device_node *np)
>> +{
>> +	int ret;
>> +	unsigned int val;
>> +
>> +	switch (chip->type) {
>> +	case CHIP_PM800:
>> +	case CHIP_PM805:
>> +		break;
>
> It may be useful for future generations to put short notice here why
> there is no init for these devices? I saw the explanation in commit
> message but still someone in the future may look at the code and wonder
> why only 88PM860 is initialized and the others are not?
>

Yeup, Agreed.

I will incorporate it in V2.

Thanks,
Vaibhav
