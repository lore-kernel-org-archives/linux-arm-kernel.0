From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 29 Sep 2010 13:54:11 +0200
Subject: [PATCH 1/7] SPI: add PrimeCell generic DMA to PL022 v12
In-Reply-To: <20100929082055.GC4703@angua.secretlab.ca>
References: <1285684441-21700-1-git-send-email-linus.walleij@stericsson.com>
	<1285684441-21700-2-git-send-email-linus.walleij@stericsson.com>
	<20100929082055.GC4703@angua.secretlab.ca>
Message-ID: <4CA328E3.3040502@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote:

> On Tue, Sep 28, 2010 at 04:33:55PM +0200, Linus Walleij wrote:

>> This extends the PL022 SSP/SPI driver with generic DMA engine
>> support using the PrimeCell DMA engine interface. Also fix up the
>> test code for the U300 platform.
>> (...)
>> --- a/arch/arm/mach-u300/dummyspichip.c
>> +++ b/arch/arm/mach-u300/dummyspichip.c
>> @@ -267,6 +267,7 @@ static struct spi_driver pl022_dummy_driver = {
>>  	.driver = {
>>  		.name	= "spi-dummy",
>>  		.owner	= THIS_MODULE,
>> +		.bus = &spi_bus_type,
> 
> This shouldn't be necessary.  spi_register_driver already sets the bus
> type field.
> 
> Otherwise, this patch looks good.  If you're okay with me dropping
> this hunk, then I'll pick up this patch into my next-spi branch.

OK just drop it, thanks Grant.

I need to come up with the right way to refactor that dummychip anyway
to I'll churn it out completely sooner or later.

Yours,
Linus Walleij
