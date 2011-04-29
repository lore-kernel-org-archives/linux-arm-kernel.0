From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Fri, 29 Apr 2011 10:22:03 +0200
Subject: AT91: Convert to fasteoi IRQ handler, and remove ARM irq_finish
In-Reply-To: <BANLkTikdnDtwZj1QgLxibRBiv=Ox8Y5PWg@mail.gmail.com>
References: <1303909742.18407.12.camel@redbox> <20110428151819.GE13755@siel.b>
	<BANLkTimUPfo0kMn3HPa5iZUO5g_b6rVKcA@mail.gmail.com>
	<20110428192403.GA21061@linutronix.de>
	<BANLkTikdnDtwZj1QgLxibRBiv=Ox8Y5PWg@mail.gmail.com>
Message-ID: <20110429082203.GA2223@Chamillionaire.breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andrew Victor | 2011-04-28 22:03:03 [+0200]:

>hi Sebastian,
Hi Andrew,

>>>> why does this handler mess with the parent irq chip ?
>>>> this looks pretty wrong to me.
>>>
>>>This is a chained-handler, and without that line the end-of-interrupt
>>>doesn't seem to be signalled.
>>
>> Most chain handler don't mess with other irq chips. Why is the parent
>> irq hanlder set level and not eoi? Wouldn't this make this superflous?
>
>This patch changes the parent from level to eoi.

Yes. So why does your gpio chip still call ->irq_eoi() of the parent
irq-chip? This is done by done the eoi-handler of the parent.

Sebastian
