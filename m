From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 15 Dec 2011 22:15:56 +0800
Subject: [PATCH 3/9] irq: convert generic-chip to use irq_domain
In-Reply-To: <4EE9FC99.6030905@gmail.com>
References: <1323876538-20406-1-git-send-email-robherring2@gmail.com>
 <1323876538-20406-4-git-send-email-robherring2@gmail.com>
 <20111215052512.GB21815@S2101-09.ap.freescale.net>
 <20111215055501.GC21815@S2101-09.ap.freescale.net>
 <4EE9F899.7010402@gmail.com> <4EE9FC99.6030905@gmail.com>
Message-ID: <20111215141555.GC2963@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 07:56:41AM -0600, Rob Herring wrote:
[...]
> >> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> >> index eb763f7..2a2aac1 100644
> >> --- a/kernel/irq/irqdomain.c
> >> +++ b/kernel/irq/irqdomain.c
> >> @@ -39,7 +39,7 @@ void irq_domain_add(struct irq_domain *domain)
> >>                         return;
> >>                 }
> >>                 d->domain = domain;
> >> -               d->hwirq = hwirq;
> >> +               d->hwirq = hwirq - domain->hwirq_base;
> > 
> > This is a problem. It entirely defeats the point of hwirq_base and it
> > would break the GIC. We need to fix this in the generic irq chip.
> > 
> 
> I think I found a fix. Can you try 's/d->hwirq/(d->hwirq % 32)/' in
> generic-chip.c.
> 
Needless to try (will try later), this will work.  But again, what do
we need to change 'd->irq - d->irq_base' at all?

-- 
Regards,
Shawn
