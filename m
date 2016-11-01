From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 1 Nov 2016 16:32:32 +0100
Subject: [PATCH 2/3] KVM: arm/arm64: Add ARM arch timer interrupts ABI
In-Reply-To: <CAFEAcA_mdrTUBBDV91X3Zo6pNzVaukQ7foN+cPt_41+ouBdEfQ@mail.gmail.com>
References: <20160927190806.22988-1-christoffer.dall@linaro.org>
 <20160927190806.22988-3-christoffer.dall@linaro.org>
 <CAFEAcA8x9Rt7SwXfqC8QOuXUEysrGBvYZW_=9ZA+pNgYu7HbTA@mail.gmail.com>
 <20161101145019.GB13677@cbox>
 <CAFEAcA_mdrTUBBDV91X3Zo6pNzVaukQ7foN+cPt_41+ouBdEfQ@mail.gmail.com>
Message-ID: <20161101153232.GD13677@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2016 at 02:54:11PM +0000, Peter Maydell wrote:
> On 1 November 2016 at 14:50, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > On Tue, Nov 01, 2016 at 11:26:54AM +0000, Peter Maydell wrote:
> >> Possible current and future outbound interrupt lines (some of these
> >> would only show up in some unlikely or lots-of-implementation-needed
> >> cases, I'm just trying to produce an exhaustive list):
> >>  * virtual timer
> >>  * physical timer
> >>  * hyp timer (nested virtualization case)
> >>  * secure timer (unlikely but maybe if EL3 is ever supported inside a VM)
> >>  * gic maintenance interrupt (nested virt again)
> >>  * PMU interrupt
> >
> > Thanks for the list, that's good to have around for the future.
> >
> > There's also the potential of the EL2 virtual timer for nested VHE
> > support, right?
> 
> That's the one I meant by "hyp timer".
> 

there's the hyp timer, and then there's the ARMv8.1 virtual hyp timer.

> >> The kernel doesn't know which interrupt number these would be wired
> >> up to, so they're all just arbitrary outputs, and you could put them
> >> in one field or split them up into multiple fields, it doesn't make
> >> much difference.
> >>
> >
> > So if we keep this we're kind of suggesting that we'll have a field per
> > device type later on.  Since this is a u8 and we are talking about up 5
> > 5 timers already,
> 
> 4.
> 

virtual
physical
hyp
virtual hyp
secure

Am I missing something?

-Christoffer
