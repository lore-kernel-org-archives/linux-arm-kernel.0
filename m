From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 18 Oct 2012 10:43:53 +0200
Subject: [PATCH 4/9] ARM: export default read_current_timer
In-Reply-To: <20121009160647.GG4625@n2100.arm.linux.org.uk>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
 <1349796183-30648-5-git-send-email-arnd@arndb.de> <50744586.6010806@arm.com>
 <20121009160647.GG4625@n2100.arm.linux.org.uk>
Message-ID: <507FC149.9030505@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 09.10.2012 18:06, schrieb Russell King - ARM Linux:
> On Tue, Oct 09, 2012 at 04:40:54PM +0100, Jonathan Austin wrote:
>> Hi Arnd,
>>
>> On 09/10/12 16:22, Arnd Bergmann wrote:
>>> diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
>>> index 9d0a300..0dc5385 100644
>>> --- a/arch/arm/lib/delay.c
>>> +++ b/arch/arm/lib/delay.c
>>> @@ -45,6 +45,7 @@ int read_current_timer(unsigned long *timer_val)
>>>   	*timer_val = delay_timer->read_current_timer();
>>>   	return 0;
>>>   }
>>> +EXPORT_SYMBOL_GPL(read_current_timer);
>>
>>
>> Perhaps this fits better in armksyms.c? That way it lives with
>> arm_delay_ops and friends.
>
> It's always much better to put things next to where they're defined
> rather than spreading them around.
>
> armksyms.c is a reminant of the 1.x days of doing things... but still
> remains to allow what are mostly assembly symbols to be exported.

I needed that to build udlfb as a module.

For the 3.6 stable kernels this has to be done in
arch/arm/kernel/arch_timer.c (along with an #include <linux/export.h>)

So I'm not sure if an Cc: <stable@vger.kernel.org> can be used here, but 
a patch should be submitted for inclusion into the 3.6 stable series too.

Regards,

Alexander
