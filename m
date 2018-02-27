From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 27 Feb 2018 08:44:55 +0100
Subject: [PATCH] i2c-stm32f4: remove redundant initialization of pointer
 reg
In-Reply-To: <20180226200639.tfll2y4efepm2sos@ninjato>
References: <20180116174404.19464-1-colin.king@canonical.com>
 <20180226200639.tfll2y4efepm2sos@ninjato>
Message-ID: <25b0397b-5df3-2f5c-a18f-238db83205da@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/26/2018 09:06 PM, Wolfram Sang wrote:
> On Tue, Jan 16, 2018 at 05:44:04PM +0000, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The pointer reg is assigned a value that is never read, it is later
>> overwritten with a new value, hence the redundant initialization can
>> be removed.
>>
>> Cleans up clang warning:
>> drivers/i2c/busses/i2c-stm32f4.c:352:16: warning: Value stored to 'reg'
>> during its initialization is never read
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Maxime? Alexandre? Are you OK with this patch?

Sorry for delay.

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

regards
alex

> 
>> ---
>>   drivers/i2c/busses/i2c-stm32f4.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
>> index 47c8d00de53f..ba600d77a3f8 100644
>> --- a/drivers/i2c/busses/i2c-stm32f4.c
>> +++ b/drivers/i2c/busses/i2c-stm32f4.c
>> @@ -349,7 +349,7 @@ static void stm32f4_i2c_read_msg(struct stm32f4_i2c_dev *i2c_dev)
>>   static void stm32f4_i2c_terminate_xfer(struct stm32f4_i2c_dev *i2c_dev)
>>   {
>>   	struct stm32f4_i2c_msg *msg = &i2c_dev->msg;
>> -	void __iomem *reg = i2c_dev->base + STM32F4_I2C_CR2;
>> +	void __iomem *reg;
>>   
>>   	stm32f4_i2c_disable_irq(i2c_dev);
>>   
>> -- 
>> 2.15.1
>>
