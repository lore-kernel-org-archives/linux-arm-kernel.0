From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Thu, 28 Apr 2011 22:20:34 +0200
Subject: AT91: Convert to fasteoi IRQ handler, and remove ARM irq_finish
In-Reply-To: <alpine.LFD.2.02.1104282148070.3005@ionos>
References: <1303909742.18407.12.camel@redbox> <20110428151819.GE13755@siel.b>
	<BANLkTimUPfo0kMn3HPa5iZUO5g_b6rVKcA@mail.gmail.com>
	<20110428192403.GA21061@linutronix.de>
	<alpine.LFD.2.02.1104282148070.3005@ionos>
Message-ID: <20110428202034.GA23298@Chamillionaire.breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Gleixner | 2011-04-28 21:48:52 [+0200]:

>On Thu, 28 Apr 2011, Sebastian Andrzej Siewior wrote:
>
>> * Andrew Victor | 2011-04-28 19:12:23 [+0200]:
>> 
>> >hi,
>> >
>> >>> - ? ? desc->irq_data.chip->irq_unmask(&desc->irq_data);
>> >>> - ? ? /* now it may re-trigger */
>> >>> + ? ? /* acknowledge interrupt - now it may re-trigger */
>> >>> + ? ? desc->irq_data.chip->irq_eoi(&desc->irq_data);

>> btw: tglx removed direct desc access so this patch won't apply.
>
>It does, you still can access irq_data, but you should use the
>wrappers.

commit ac93cdbd6e5e2547a031e2739e0dd445824bf1c8
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Thu Mar 24 12:48:18 2011 +0100

    arm: at91: Cleanup irq chip

This commit removed "desc->irq_data.chip->irq_unmask(&desc->irq_data);"
among others so it does not apply anymore.

>Thanks,
>
>	tglx

Sebastian
