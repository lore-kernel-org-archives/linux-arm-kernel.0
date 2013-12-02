From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 2 Dec 2013 11:56:14 +0100
Subject: [PATCH v2] ARM: at91: sama5d3: reduce TWI internal clock frequency
In-Reply-To: <529C47E3.2010508@atmel.com>
References: <1385136523-11962-1-git-send-email-ludovic.desroches@atmel.com>
 <529C47E3.2010508@atmel.com>
Message-ID: <529C674E.5050403@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2013 09:42, Nicolas Ferre :
> On 22/11/2013 17:08, ludovic.desroches at atmel.com :
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>
>> With some devices, transfer hangs during I2C frame transmission. This issue
>> disappears when reducing the internal frequency of the TWI IP. Even if it is
>> indicated that internal clock max frequency is 66MHz, it seems we have
>> oversampling on I2C signals making TWI believe that a transfer in progress
>> is done.
>>
>> This fix has no impact on the I2C bus frequency.
>>
>> Cc: <stable@vger.kernel.org> #3.10+
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> added to at91-3.14-dt branch.

No, sorry, it will go in at91-3.13-fixes!

Bye,

>> ---
>>
>> v2: update commit message
>>
>>    arch/arm/mach-at91/sama5d3.c |    6 +++---
>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-at91/sama5d3.c b/arch/arm/mach-at91/sama5d3.c
>> index 4012797..4ee0de5 100644
>> --- a/arch/arm/mach-at91/sama5d3.c
>> +++ b/arch/arm/mach-at91/sama5d3.c
>> @@ -95,19 +95,19 @@ static struct clk twi0_clk = {
>>    	.name		= "twi0_clk",
>>    	.pid		= SAMA5D3_ID_TWI0,
>>    	.type		= CLK_TYPE_PERIPHERAL,
>> -	.div		= AT91_PMC_PCR_DIV2,
>> +	.div		= AT91_PMC_PCR_DIV8,
>>    };
>>    static struct clk twi1_clk = {
>>    	.name		= "twi1_clk",
>>    	.pid		= SAMA5D3_ID_TWI1,
>>    	.type		= CLK_TYPE_PERIPHERAL,
>> -	.div		= AT91_PMC_PCR_DIV2,
>> +	.div		= AT91_PMC_PCR_DIV8,
>>    };
>>    static struct clk twi2_clk = {
>>    	.name		= "twi2_clk",
>>    	.pid		= SAMA5D3_ID_TWI2,
>>    	.type		= CLK_TYPE_PERIPHERAL,
>> -	.div		= AT91_PMC_PCR_DIV2,
>> +	.div		= AT91_PMC_PCR_DIV8,
>>    };
>>    static struct clk mmc0_clk = {
>>    	.name		= "mci0_clk",
>>
>
>


-- 
Nicolas Ferre
