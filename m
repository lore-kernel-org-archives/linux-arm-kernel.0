From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 24 Nov 2010 17:28:27 +0100
Subject: [patch 1/1] iMX51: introduce MX51_GPIO_NR
In-Reply-To: <20101124052128.GA15971@sahyadri-mini10> (Amit Kucheria's message
	of "Wed, 24 Nov 2010 10:51:28 +0530")
References: <20101122224526.987309475@rtp-net.org>
	<20101124052128.GA15971@sahyadri-mini10>
Message-ID: <874ob6y9ck.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amit Kucheria <amit.kucheria@linaro.org> writes:

[...]

>> Index: gpionr/arch/arm/plat-mxc/include/mach/iomux-mx51.h
>> ===================================================================
>> --- gpionr.orig/arch/arm/plat-mxc/include/mach/iomux-mx51.h	2010-11-22 23:04:23.000000000 +0100
>> +++ gpionr/arch/arm/plat-mxc/include/mach/iomux-mx51.h	2010-11-22 23:04:25.000000000 +0100
>> @@ -15,6 +15,8 @@
>>  
>>  #include <mach/iomux-v3.h>
>>  
>
> Please add a comment here that bank numbers start from 1 to make it explicit
>

ok.

>> +#define MX51_GPIO_NR(bank, nr)		((bank-1)*32+nr)
>> +
>                                                  ^^^^^^^^^ whitespace fixes
>
> Also, why is this in iomux-mx51.h?

Because I thought it was a good place to put it. fwiw, I've no strong opinion
on where to put it.

> It might be better to introduce a gpio.h

Introduce a gpio.h ? There's already one: arch/arm/plat-mxc/include/mach/gpio.h 
So, you prefer to see this macro in it ?

Arnaud
