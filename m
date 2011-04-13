From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 13 Apr 2011 15:46:49 +0400
Subject: [RFC PATCH 1/5] gemini: convert to basic-mmio-gpio
In-Reply-To: <20110412143714.GA8931@oksana.dev.rtsoft.ru>
References: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>	<1302522502-24381-2-git-send-email-jamie@jamieiles.com>
	<20110412143714.GA8931@oksana.dev.rtsoft.ru>
Message-ID: <4DA58D29.3010805@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12-04-2011 18:37, Anton Vorontsov wrote:

>> The basic-mmio-gpio driver is capable of supporting this controller so
>> convert the platform to use it for basic GPIO support.

>> Cc: Hans Ulli Kroll<ulli.kroll@googlemail.com>
>> Signed-off-by: Jamie Iles<jamie@jamieiles.com>
>> ---
> [...]
>> +#define GPIO_RES(__name, __addr) \
>> +	{ \
>> +		.start = (__addr), \
>> +		.end = (__addr) + 0x3, \
>> +		.flags = IORESOURCE_MEM, \
>> +		.name = #__name, \
>> +	}

> Btw, how about moving this (repetitive) macro into basic_mmio_gpio.h?

> Assuming, that there could be IRQ resources later, making
> something like BGPIO_MEM_RES(name, addr, sz)?

> Or, even better, some generic shorthand macro in linux/ioport.h?

> #define IORES(__type, __name, __addr, __size)	\
> 	{					\
> 		.start = (__addr), 		\
> 		.end = (__addr) + (__size),	\

    You forgot to subtract 1.

> Thanks,

WBR, Sergei
