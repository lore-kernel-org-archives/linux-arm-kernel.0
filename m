From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed, 05 Aug 2015 14:17:53 +0530
Subject: [PATCH-v2 2/2] regulator: 88pm800: Add support for configuration
 of dual phase on BUCK1
In-Reply-To: <20150723155432.GV3436@x1>
References: <1437495782-15767-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437495782-15767-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150723155432.GV3436@x1>
Message-ID: <55C1CDB9.5010106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 23 July 2015 09:24 PM, Lee Jones wrote:
> On Tue, 21 Jul 2015, Vaibhav Hiremath wrote:
>
>> 88PM860 device supports dual phase mode on BUCK1 output.
>> In normal usecase, BUCK1A and BUCK1B operates independently with 3A
>> capacity. And they both can work as a dual phase providing 6A capacity.
>>
>> This patch updates the regulator driver to read the respective
>> DT property and enable dual-phase mode on BUCK1.
>>
>> Note that, this is init time (one time) initialization.
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   drivers/regulator/88pm800.c | 31 +++++++++++++++++++++++++++++++
>>   include/linux/mfd/88pm80x.h |  3 +++
>>   2 files changed, 34 insertions(+)
>
> [...]
>
>> diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
>> index a92d173..05d9bad 100644
>> --- a/include/linux/mfd/88pm80x.h
>> +++ b/include/linux/mfd/88pm80x.h
>> @@ -295,6 +295,9 @@ enum {
>>   #define PM860_BUCK4_MISC2		(0x82)
>>   #define PM860_BUCK4_FULL_DRV		BIT(2)
>>
>> +#define PM860_BUCK1_MISC		(0x8E)
>
> Why the over-bracketing?
>

No specific reason, just wanted to be consistent with other definitions
in the file.

Anyway, will remove it in V3.

Thanks,
Vaibhav
