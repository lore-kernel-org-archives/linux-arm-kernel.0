From: david.wu@rock-chips.com (David.Wu)
Date: Thu, 12 May 2016 09:11:29 +0800
Subject: [PATCH v8 3/8] i2c: rk3x: Remove redundant rk3x_i2c_clean_ipd()
In-Reply-To: <2477327.hJjg0APDhg@phil>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
 <1462908252-27016-4-git-send-email-david.wu@rock-chips.com>
 <2477327.hJjg0APDhg@phil>
Message-ID: <5733D841.1020905@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko

? 2016/5/12 2:26, Heiko Stuebner ??:
> Am Mittwoch, 11. Mai 2016, 03:24:07 schrieb David Wu:
>> Call rk3x_i2c_setup() before rk3x_i2c_start()
>
> That beginning of the sentence could use a tiny improvement, like
>
> ----
> rk3x_i2c_setup() gets called directly before rk3x_i2c_start()
> ----
>

Okay, i will add it in next version, Thanks.

> to make it obvious what happens in the code.
>
> But a nice small improvement
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
>> and the last thing in setup was to clean the IPD,
>> so no reason to do it at the beginning of start.
>>
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> ---
>> Change in v8:
>> - none
>>
>>   drivers/i2c/busses/i2c-rk3x.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
>> index 1e2677a..9eeb4e5 100644
>> --- a/drivers/i2c/busses/i2c-rk3x.c
>> +++ b/drivers/i2c/busses/i2c-rk3x.c
>> @@ -174,7 +174,6 @@ static void rk3x_i2c_start(struct rk3x_i2c *i2c)
>>   {
>>   	u32 val;
>>
>> -	rk3x_i2c_clean_ipd(i2c);
>>   	i2c_writel(i2c, REG_INT_START, REG_IEN);
>>
>>   	/* enable adapter with correct mode, send START condition */
>
>
>
>
