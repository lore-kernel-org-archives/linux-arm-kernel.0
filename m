From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 10 Sep 2010 11:51:38 +0200
Subject: [PATCH] AT91: dm9000 initialization update
In-Reply-To: <20100910092344.GN9112@game.jcrosoft.org>
References: <1284113629-13768-1-git-send-email-nicolas.ferre@atmel.com>
	<20100910092344.GN9112@game.jcrosoft.org>
Message-ID: <4C89FFAA.3010503@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/09/2010 11:23, Jean-Christophe PLAGNIOL-VILLARD :
> On 12:13 Fri 10 Sep     , Nicolas Ferre wrote:
>> Add information in dm9000 mac/phy chip initialization:
>> - irq resource details
>> - platform data details
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  arch/arm/mach-at91/board-sam9261ek.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
>> index c4c8865..b4307ab 100644
>> --- a/arch/arm/mach-at91/board-sam9261ek.c
>> +++ b/arch/arm/mach-at91/board-sam9261ek.c
>> @@ -93,11 +93,12 @@ static struct resource dm9000_resource[] = {
>>  		.start	= AT91_PIN_PC11,
>>  		.end	= AT91_PIN_PC11,
>>  		.flags	= IORESOURCE_IRQ
>> +			| IORESOURCE_IRQ_LOWEDGE | IORESOURCE_IRQ_HIGHEDGE,
> both?

Yes, only configuration supported by GPIO irqs...

Regards,
-- 
Nicolas Ferre
