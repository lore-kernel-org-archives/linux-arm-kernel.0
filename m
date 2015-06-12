From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Fri, 12 Jun 2015 18:23:03 +0200 (CEST)
Subject: [PATCH 01/15] ARM: kill off set_irq_flags usage
In-Reply-To: <CAL_JsqKvLW-0p=A3BHoAYH_+ODCTt4C07OAHc__rUzC0jZ5p5g@mail.gmail.com>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-2-git-send-email-robh@kernel.org>
 <alpine.LNX.2.00.1506121604200.30841@localhost>
 <CAL_JsqKvLW-0p=A3BHoAYH_+ODCTt4C07OAHc__rUzC0jZ5p5g@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1506121821530.16656@T520.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Fri, 12 Jun 2015, Rob Herring wrote:

> On Fri, Jun 12, 2015 at 9:05 AM, Hans Ulli Kroll
> <ulli.kroll@googlemail.com> wrote:
> >
> >
> > On Tue, 9 Jun 2015, Rob Herring wrote:
> >
> >> set_irq_flags is ARM specific with custom flags which have genirq
> >> equivalents. Convert drivers to use the genirq interfaces directly, so we
> >> can kill off set_irq_flags. The translation of flags is as follows:
> >>
> >> IRQF_VALID -> !IRQ_NOREQUEST
> >> IRQF_PROBE -> !IRQ_NOPROBE
> >> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
> >>
> >> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
> >> and setting IRQ_NOREQUEST already, so there is no need to do this in
> >> .map() functions and we can simply remove the set_irq_flags calls. Some
> >> users also set IRQ_NOPROBE and this has been maintained although it is not
> >> clear that is really needed. There appears to be a great deal of blind
> >> copy and paste of this code.
> >>
> >
> > for mach-gemini
> > Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> 
> You mean acked-by, right?
> 
> Rob
> 

Yeah

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>

Ulli
