From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 4 Jun 2013 15:17:45 +0200
Subject: [PATCH 1/3] ARM: at91: dt: add header to define at_hdmac
 configuration
In-Reply-To: <20130603073226.GG11384@ludovic.desroches@atmel.com>
References: <1369930103-11963-1-git-send-email-ludovic.desroches@atmel.com>
 <1369930103-11963-2-git-send-email-ludovic.desroches@atmel.com>
 <201305312330.29364.arnd@arndb.de>
 <20130603073226.GG11384@ludovic.desroches@atmel.com>
Message-ID: <51ADE8F9.7090200@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2013 09:32, Ludovic Desroches :
> On Fri, May 31, 2013 at 11:30:29PM +0200, Arnd Bergmann wrote:
>> On Thursday 30 May 2013, ludovic.desroches at atmel.com wrote:
>>> +/*
>>> + * Source and/or destination peripheral ID
>>> + */
>>> +#define AT91_DMA_CFG_PER_ID_MASK       (0xff)
>>> +#define AT91_DMA_CFG_PER_ID(id)                (id & AT91_DMA_CFG_PER_ID_MASK)
>>> +
>>
>> I'm a little worried about macros like this one spreading in the name
>> of readability, and I don't see this as actual value-add here:
>>
>> The output of the macro is always the same as the input, and passing
>> an invalid number still results in an invalid output and no error message,
>> it actually prevents us from warning about the mistake at run-time.
>>
>
> You are right, this macro is here only for readability in order to not have
> something like this:
>
> dmas = <&dma0 AT91_DMA_CFG_FIFOCFG_ASAP | 13>
>
> In this case, I prefer having a macro instead of using a numeric value which
> can stand for other things than the peripheral id and which could conflict
> with other parameters such as the FIFO configuration.
>
> If adding this macro is really an issue, it could be removed of course but
> in this case I am in favor of readability.

Arnd,

I think that the case highlighted by Ludovic is indeed a case where 
someone can be confused by the presentation of data in the cell... even 
if I like the use of macro as implemented by Ludovic, I do not have a 
strong opinion about this.

Best regards,
-- 
Nicolas Ferre
