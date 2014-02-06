From: carlo.caione@gmail.com (Carlo Caione)
Date: Thu, 6 Feb 2014 22:21:37 +0100
Subject: [linux-sunxi] Re: [PATCH] irq: Add new flag to ack
 level-triggered interrupts before unmasking
In-Reply-To: <alpine.DEB.2.02.1402062213590.21991@ionos.tec.linutronix.de>
References: <1391721117-27446-1-git-send-email-carlo@caione.org>
 <alpine.DEB.2.02.1402062213590.21991@ionos.tec.linutronix.de>
Message-ID: <CAOQ7t2Z0agZdDZ_OQZPtXWXoi5NMTcOOZz04q6wEVNy0rxn4AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 6, 2014 at 10:14 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 6 Feb 2014, Carlo Caione wrote:
>
>> Several irqchip drivers require the level-triggered interrupt to be
>> acked before unmasking to avoid that a second interrupt is immediately
>> triggered. This small patch introduces a new irqchip flags that is used
>> to ack the IRQ line before it is unmasked.
>
> And why are you not doing this in the unmask function of the affected
> chip in the first place?

Because this is a common behavior of several irqchips (sunxi NMI
controller,  exynos, etc...) so I think it should be useful to have it
in the core instead of replicating the same code structure in all the
irqchip drivers.

Thanks,

-- 
Carlo Caione
