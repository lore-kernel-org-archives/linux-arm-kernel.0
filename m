From: jochen@scram.de (Jochen Friedrich)
Date: Mon, 21 Nov 2011 15:37:41 +0100
Subject: [PATCH] ARM: sa1100: refactor sa1100 serial driver
In-Reply-To: <1321822068.17619.3.camel@Joe-Laptop>
References: <1321821127-32231-1-git-send-email-jochen@scram.de>
 <1321822068.17619.3.camel@Joe-Laptop>
Message-ID: <4ECA6235.4030108@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

> trivia:
>
>> diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
> []
>> @@ -166,7 +166,7 @@ static struct platform_device sa11x0udc_device = {
>>   static struct resource sa11x0uart1_resources[] = {
>>   	[0] = {
>>   		.start	= __PREG(Ser1UTCR0),
>> -		.end	= __PREG(Ser1UTCR0) + 0xffff,
>> +		.end	= __PREG(Ser1UTCR0) + 0x24,
>
> #define for 0x24? or is it really 0x23?
> (start + size - 1)

Thanks, I'll fix this.

Jochen.
