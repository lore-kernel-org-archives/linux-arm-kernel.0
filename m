From: horms@verge.net.au (Simon Horman)
Date: Tue, 1 Sep 2015 10:09:58 +0900
Subject: [RESEND PATCH v3 3/5] sh: kill off set_irq_flags usage
In-Reply-To: <CAL_JsqJuPtkvFMFvcSwaFssXoLYrHs9bM3EedXSzj21YAPmwDQ@mail.gmail.com>
References: <1440889285-5637-1-git-send-email-robh@kernel.org>
 <1440889285-5637-4-git-send-email-robh@kernel.org>
 <20150831050104.GA26119@verge.net.au>
 <CAL_JsqJuPtkvFMFvcSwaFssXoLYrHs9bM3EedXSzj21YAPmwDQ@mail.gmail.com>
Message-ID: <20150901010958.GA29746@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 31, 2015 at 07:52:07AM -0500, Rob Herring wrote:
> On Mon, Aug 31, 2015 at 12:01 AM, Simon Horman <horms@verge.net.au> wrote:
> > Hi Rob,
> >
> > On Sat, Aug 29, 2015 at 06:01:23PM -0500, Rob Herring wrote:
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
> >> users also modify IRQ_NOPROBE and this has been maintained although it
> >> is not clear that is really needed. There appears to be a great deal of
> >> blind copy and paste of this code.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> Acked-by: Simon Horman <horms@verge.net.au>
> >> Cc: Magnus Damm <magnus.damm@gmail.com>
> >> Cc: linux-sh at vger.kernel.org
> >
> > I have queued this up. Please let me know if that was not your intent.
> >
> > The patch is queued up in the sh-drivers-for-v4.3 branch of my renesas tree.
> > At this point I plan to send a pull-request once dt changes that other
> > patches in that branch depend on hit Linus's tree via the ARM SoC tree.
> > I anticipate that being during the rc1 or rc2 timeframe.
> 
> This needs to go in before -rc1 so the final 2 patches removing
> set_irq_flags can go in at the end of the merge window. Given your
> timeline, I think you can just leave this one for Thomas to apply with
> those 2.

Sure, will do.
