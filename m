From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 13 Oct 2014 20:18:05 +0200
Subject: [PATCH v2 1/4] arm: pxa: add device-tree irq init for pxa27x
In-Reply-To: <20141013103422.GF14739@leverpostej> (Mark Rutland's message of
 "Mon, 13 Oct 2014 11:34:22 +0100")
References: <1413127731-1187-1-git-send-email-robert.jarzmik@free.fr>
 <1413127731-1187-2-git-send-email-robert.jarzmik@free.fr>
 <20141013103422.GF14739@leverpostej>
Message-ID: <878ukj96le.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland <mark.rutland@arm.com> writes:

> On Sun, Oct 12, 2014 at 04:28:48PM +0100, Robert Jarzmik wrote:
>> Add the initializer for irqs in a device-tree machine on a pxa27x.
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> ---
>>  arch/arm/mach-pxa/pxa27x.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
>> index b040d7d..8ca62e2 100644
>> --- a/arch/arm/mach-pxa/pxa27x.c
>> +++ b/arch/arm/mach-pxa/pxa27x.c
>> @@ -398,6 +398,11 @@ void __init pxa27x_init_irq(void)
>>  	pxa_init_irq(34, pxa27x_set_wake);
>>  }
>>  
>> +void __init pxa27x_dt_init_irq(void)
>> +{
>> +	pxa_dt_irq_init(pxa27x_set_wake);
>> +}
>
> Should this also add a user of this function?
Well, patches 1, 2, 3 are preparing patch 4.
And patch 4 is adding the user of this function.

I could meld this in patch 4, but it looks cleaner for me to split the function
creation, and pxa27x dt support in 2 distinct patches.

Cheers

--
Robert
