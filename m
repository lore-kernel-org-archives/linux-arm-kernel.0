From: phorton@bitbox.co.uk (Peter Horton)
Date: Mon, 21 Jun 2010 16:14:22 +0100
Subject: [PATCH] Fix AT91SAM9G20 reset
In-Reply-To: <loom.20100621T162410-494@post.gmane.org>
References: <20100528153725.GA5102@axolotl.localnet>
	<loom.20100621T162410-494@post.gmane.org>
Message-ID: <4C1F81CE.6000905@bitbox.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/06/2010 15:30, Lucas wrote:
> Peter Horton<phorton<at>  bitbox.co.uk>  writes:
>
>>
>> Fix AT91SAM9G20 as per the errata in the datasheet.
>>
>> If the SDRAM is not cleanly shutdown before reset it can be left driving
>> the bus, which then stops the bootloader booting from NAND.
>>
>> Signed-off-by: Peter Horton<phorton<at>  bitbox.co.uk>
>> --
>>
>
>
> Hi Peter,
>
> Any Idea how to implement this for the WDT and hardware reset(NRST)?
> A hardware reset sometimes still stops the bootloader booting from NAND.
>

Not possible to fix as far as I understand it. We've had to put down a 
small DataFlash which then boots from NAND.

Turns out we needed DataFlash anyway as the Atmel boot ROM is not 
compatible with newer NANDs (newer NANDs no longer guarantee block 0 
without ECC and the Atmel boot ROM doesn't support ECC).

P.
