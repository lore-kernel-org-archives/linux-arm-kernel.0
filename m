From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Dec 2010 11:45:32 +0000
Subject: [PATCH 08/54] ARM: aaec2000: irq_data conversion.
In-Reply-To: <4CFCC8B2.6000208@ru.mvista.com>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130132552.GI15575@mail.wantstofly.org>
	<4CFCC8B2.6000208@ru.mvista.com>
Message-ID: <20101206114532.GA31777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 02:27:46PM +0300, Sergei Shtylyov wrote:
> Hello.
>
> On 30-11-2010 16:25, Lennert Buytenhek wrote:
>
>> Signed-off-by: Lennert Buytenhek<buytenh@secretlab.ca>
> [...]
>
>> diff --git a/arch/arm/mach-aaec2000/core.c b/arch/arm/mach-aaec2000/core.c
>> index 3ef6833..f8465bd 100644
>> --- a/arch/arm/mach-aaec2000/core.c
>> +++ b/arch/arm/mach-aaec2000/core.c
>> @@ -68,25 +68,25 @@ void __init aaec2000_map_io(void)
>>   /*
>>    * Interrupt handling routines
>>    */
>> -static void aaec2000_int_ack(unsigned int irq)
>> +static void aaec2000_int_ack(struct irq_data *d)
>>   {
>> -	IRQ_INTSR = 1<<  irq;
>> +	IRQ_INTSR = 1<<  d->irq;
>>   }
>>
>> -static void aaec2000_int_mask(unsigned int irq)
>> +static void aaec2000_int_mask(struct irq_data *d)
>>   {
>> -	IRQ_INTENC |= (1<<  irq);
>> +	IRQ_INTENC |= (1<<  d->irq);
>>   }
>>
>> -static void aaec2000_int_unmask(unsigned int irq)
>> +static void aaec2000_int_unmask(struct irq_data *d)
>>   {
>> -	IRQ_INTENS |= (1<<  irq);
>> +	IRQ_INTENS |= (1<<  d->irq);
>>   }
>
>    Probably could have dropped useless parens, while at it...

That depends how you look at it.  Lennert's change is just the minimalist
change required for this patch, which is good.

The parens and whitespace issues should be a separate patch.
