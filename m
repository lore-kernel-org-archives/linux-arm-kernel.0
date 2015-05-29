From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Sat, 30 May 2015 00:55:41 +0530
Subject: [PATCH 02/12] i2c: pxa: No need to set slave addr for i2c master
 mode reset
In-Reply-To: <87d21jyyua.fsf@belgarion.home>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>	<1432818224-17070-3-git-send-email-vaibhav.hiremath@linaro.org>
 <87d21jyyua.fsf@belgarion.home>
Message-ID: <5568BD35.5020404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 30 May 2015 12:51 AM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:
>
>> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
>> index f4ac8c5..d4c798a 100644
>> --- a/drivers/i2c/busses/i2c-pxa.c
>> +++ b/drivers/i2c/busses/i2c-pxa.c
>> @@ -459,8 +459,10 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>>   	writel(I2C_ISR_INIT, _ISR(i2c));
>>   	writel(readl(_ICR(i2c)) & ~ICR_UR, _ICR(i2c));
>>
>> +#ifdef CONFIG_I2C_PXA_SLAVE
>>   	if (i2c->reg_isar)
>>   		writel(i2c->slave_addr, _ISAR(i2c));
>> +#endif
> I'd rather have :
>    	if (i2c->reg_isar && IS_ENABLED(CONFIG_I2C_PXA_SLAVE))
>    		writel(i2c->slave_addr, _ISAR(i2c));
>

Ok,
Will fix it in next version.

Thanks,
Vaibhav
