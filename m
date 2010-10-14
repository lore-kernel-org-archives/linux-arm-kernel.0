From: phorton@bitbox.co.uk (Peter Horton)
Date: Thu, 14 Oct 2010 16:31:19 +0100
Subject: [PATCH] Fix AT91SAM9G20 reset
In-Reply-To: <4CB706FC.3000308@atmel.com>
References: <20100528153725.GA5102@axolotl.localnet>
	<4CB706FC.3000308@atmel.com>
Message-ID: <4CB72247.40206@bitbox.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/2010 14:34, Nicolas Ferre wrote:
> Le 28/05/2010 17:37, Peter Horton :
>> Fix AT91SAM9G20 as per the errata in the datasheet.
>>
>> If the SDRAM is not cleanly shutdown before reset it can be left driving
>> the bus, which then stops the bootloader booting from NAND.
>>
>> Signed-off-by: Peter Horton<phorton@bitbox.co.uk>
>
> Thanks a lot for writing this patch. I am in the process of reviewing it
> and extending it to other processors.
>
> [..]
>
>> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
>> +++ linux-2.6.32/arch/arm/mach-at91/at91sam9g20_reset.S	2009-12-09 13:33:28.000000000 +0000
>> @@ -0,0 +1,52 @@
>> +/*
>> + * (C) BitBox Ltd 2010
>> + *
>> + * reset AT91SAM9G20 as per errata
>> + *
>> + * unless the SDRAM is cleanly shutdown before we hit the
>> + * reset register it can be left driving the data bus and
>> + * killing the chance of a subsequent boot from NAND
>
> Can I add License sentence to this file? Like this one:
>
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; either version 2 of the License, or
>   * (at your option) any later version.
>

No problem.

P.
