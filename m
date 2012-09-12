From: robherring2@gmail.com (Rob Herring)
Date: Wed, 12 Sep 2012 15:14:02 -0500
Subject: [PATCH v2 5/6] ARM: orion: move custom gpio functions to
 orion-gpio.h
In-Reply-To: <201209122011.28080.arnd@arndb.de>
References: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
 <1346960563-18689-6-git-send-email-robherring2@gmail.com>
 <201209122011.28080.arnd@arndb.de>
Message-ID: <5050ED0A.2020100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2012 03:11 PM, Arnd Bergmann wrote:
> On Thursday 06 September 2012, Rob Herring wrote:
>> diff --git a/arch/arm/plat-orion/include/plat/gpio.h b/arch/arm/plat-orion/include/plat/gpio.h
>> deleted file mode 100644
>> index 81c6fc8..0000000
>> --- a/arch/arm/plat-orion/include/plat/gpio.h
>> +++ /dev/null
>> @@ -1,37 +0,0 @@
>> -/*
>> - * arch/arm/plat-orion/include/plat/gpio.h
>> - *
> 
> You remove the file here
> 
>> diff --git a/arch/arm/plat-orion/mpp.c b/arch/arm/plat-orion/mpp.c
>> index 3b1e17b..c140c2f 100644
>> --- a/arch/arm/plat-orion/mpp.c
>> +++ b/arch/arm/plat-orion/mpp.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/io.h>
>>  #include <linux/gpio.h>
>>  #include <mach/hardware.h>
>> +#include <plat/gpio.h>
>>  #include <plat/mpp.h>
>>  
> 
> and add a new #include here, to the old name, resulting in 
> 
> arch/arm/plat-orion/mpp.c:17:23: fatal error: plat/gpio.h: No such file or directory
> 
> A similar problem happens in plat-orion/irq.c, which has grown a new
> #include of plat/gpio.h in a different branch that is now in arm-soc.

It should be orion-gpio.h instead. I have this fixed in my tree.

Rob
