From: nm@ti.com (Nishanth Menon)
Date: Wed, 02 Mar 2011 22:38:39 +0530
Subject: [PATCH v2 10/18] omap3+: sr: call handler with interrupt disabled
In-Reply-To: <4D6E4866.6070107@ru.mvista.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
	<1299063331-27968-11-git-send-email-nm@ti.com>
	<4D6E4866.6070107@ru.mvista.com>
Message-ID: <4D6E7997.2040303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov wrote, on 03/02/2011 07:08 PM:
> Hello.
>
> On 02-03-2011 13:55, Nishanth Menon wrote:
>
>> Request the handler irq such that there is no nesting for calls.
>> the notifiers are not expected to be nested, further the interrupt
>> events for status change should be handled prior to the next event
>> else there is a risk of loosing events.
>
>> Signed-off-by: Nishanth Menon<nm@ti.com>
>> ---
>> arch/arm/mach-omap2/smartreflex.c | 2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>> diff --git a/arch/arm/mach-omap2/smartreflex.c
>> b/arch/arm/mach-omap2/smartreflex.c
>> index 99e4c4f..a4e9f2d 100644
>> --- a/arch/arm/mach-omap2/smartreflex.c
>> +++ b/arch/arm/mach-omap2/smartreflex.c
>> @@ -278,7 +278,7 @@ static int sr_late_init(struct omap_sr *sr_info)
>> goto error;
>> }
>> ret = request_irq(sr_info->irq, sr_interrupt,
>> - 0, name, (void *)sr_info);
>> + IRQF_DISABLED, name, (void *)sr_info);
>
> Isn't this flag a nop now?
thanks. hmm...
Documentation/feature-removal-schedule.txt says so as well.. I guess I 
was just being paranoid (again?).

-- 
Regards,
Nishanth Menon
