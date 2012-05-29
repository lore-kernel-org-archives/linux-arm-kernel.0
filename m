From: hs@denx.de (Heiko Schocher)
Date: Tue, 29 May 2012 15:11:09 +0200
Subject: [PATCH v4 1/7] ARM: davinci, intc: Add irq domain support
In-Reply-To: <20120526060312.815A13E2578@localhost>
References: <1337694920-8925-1-git-send-email-hs@denx.de>
 <1337694920-8925-2-git-send-email-hs@denx.de>
 <20120526060312.815A13E2578@localhost>
Message-ID: <4FC4CAED.70105@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Grant,

Am 26.05.2012 08:03, Grant Likely wrote:
> On Tue, 22 May 2012 15:55:14 +0200, Heiko Schocher<hs@denx.de>  wrote:
>> Signed-off-by: Heiko Schocher<hs@denx.de>
>> Cc: davinci-linux-open-source at linux.davincidsp.com
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: Sekhar Nori<nsekhar@ti.com>
>> Cc: Wolfgang Denk<wd@denx.de>
>> Cc: Sergei Shtylyov<sshtylyov@mvista.com>
>
> Hi Heiko,
>
> Earlier today I commented (again) on the previous version of this
> patch.  Sorry about that.  I'm happy with the direction this series is

No problem!

> going.  Here's one more comments.

Thanks!

>> diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
>> index f83152d..bb52807 100644
>> --- a/arch/arm/mach-davinci/cp_intc.c
>> +++ b/arch/arm/mach-davinci/cp_intc.c
>> @@ -9,8 +9,10 @@
>>    * kind, whether express or implied.
>>    */
>>
>> +#include<linux/export.h>
>>   #include<linux/init.h>
>>   #include<linux/irq.h>
>> +#include<linux/irqdomain.h>
>>   #include<linux/io.h>
>>
>>   #include<mach/common.h>
>> @@ -99,18 +101,37 @@ static struct irq_chip cp_intc_irq_chip = {
>>   	.irq_set_wake	= cp_intc_set_wake,
>>   };
>
> All of the irq_chip hooks need to be switched from using d->irq to
> d->hwirq for the hardware irq number.  That sets up to driver to
> switch to using dynamic allocation of irq_descs.

Ok, try to work this in...

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
