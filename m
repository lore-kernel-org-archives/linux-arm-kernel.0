From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Thu, 28 Apr 2011 21:24:03 +0200
Subject: AT91: Convert to fasteoi IRQ handler, and remove ARM irq_finish
In-Reply-To: <BANLkTimUPfo0kMn3HPa5iZUO5g_b6rVKcA@mail.gmail.com>
References: <1303909742.18407.12.camel@redbox> <20110428151819.GE13755@siel.b>
	<BANLkTimUPfo0kMn3HPa5iZUO5g_b6rVKcA@mail.gmail.com>
Message-ID: <20110428192403.GA21061@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andrew Victor | 2011-04-28 19:12:23 [+0200]:

>hi,
>
>>> - ? ? desc->irq_data.chip->irq_unmask(&desc->irq_data);
>>> - ? ? /* now it may re-trigger */
>>> + ? ? /* acknowledge interrupt - now it may re-trigger */
>>> + ? ? desc->irq_data.chip->irq_eoi(&desc->irq_data);
>>> ?}
>>
>> why does this handler mess with the parent irq chip ?
>> this looks pretty wrong to me.
>
>This is a chained-handler, and without that line the end-of-interrupt
>doesn't seem to be signalled.

Most chain handler don't mess with other irq chips. Why is the parent
irq hanlder set level and not eoi? Wouldn't this make this superflous?

btw: tglx removed direct desc access so this patch won't apply.

>Regards,
>  Andrew Victor

Sebastian
