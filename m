From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 02 Jun 2015 14:21:40 +0530
Subject: [PATCH 2/4] mfd: 88pm800: use irq_mode to configure interrupt
 status reg clear method
In-Reply-To: <20150601083159.GD3329@x1>
References: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432937962-4537-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150601083159.GD3329@x1>
Message-ID: <556D6E9C.4050402@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 01 June 2015 02:01 PM, Lee Jones wrote:
> On Sat, 30 May 2015, Vaibhav Hiremath wrote:
>
>>  From the spec, bit 1 of reg 0xe (page 0): IN_CLEAR_MODE controls the
>> method of clearing interrupt status register of 88pm800;
>>
>>    0: clear on read
>>    1: clear on write
>>
>> Signed-off-by: zhaoy <zhaoy@marvell.com>
>
> This signed-off is not acceptable.
>
> No nicknames.  Full names only.
>

I just carry forwarded the signoff from original commit.
Let me find his complete signoff and add it to this patch.


>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   drivers/mfd/88pm800.c       | 4 +++-
>>   include/linux/mfd/88pm80x.h | 2 ++
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
>> index 06ee058..8ea4467 100644
>> --- a/drivers/mfd/88pm800.c
>> +++ b/drivers/mfd/88pm800.c
>> @@ -391,7 +391,8 @@ static int device_irq_init_800(struct pm80x_chip *chip)
>>   	    PM800_WAKEUP2_INV_INT | PM800_WAKEUP2_INT_CLEAR |
>>   	    PM800_WAKEUP2_INT_MASK;
>>
>> -	data = PM800_WAKEUP2_INT_CLEAR;
>> +	data = (chip->irq_mode) ?
>> +		PM800_WAKEUP2_INT_WRITE_CLEAR : PM800_WAKEUP2_INT_READ_CLEAR;
>
> These variable names are terrible.  'irq_mode' as a bool tells me
> nothing.
>
> What does; irq_mode = 'yes' and irq_mode = 'no' mean?  If I didn't
> read the remainder of the code, I would assume if it was 'yes' then
> the device was in IRQ Mode and if not, it would be in PIO or Polling
> mode, but that's not what it means at all is it?
>
> As for 'data', well, isn't everything data?
>


I will rename it.


Thanks,
Vaibhav
