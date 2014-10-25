From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 25 Oct 2014 10:34:19 +0200 (CEST)
Subject: [PATCH] genirq: Introduce irq_read_line()
In-Reply-To: <544AABB8.10302@codeaurora.org>
References: <1408479811-26088-1-git-send-email-bjorn.andersson@sonymobile.com>
 <CAJAp7OgGPZZuCgC8iUiW2jrEVubK=KCATxd6eazdT1x1sSrffg@mail.gmail.com>
 <alpine.DEB.2.11.1410211120430.5308@nanos> <544628BF.8010809@arm.com>
 <CAJAp7OjpN-+S=OH1BW6Fcme9mp4qj8AsSNC3_41fhfpYzX-Shg@mail.gmail.com>
 <544A936D.5040409@arm.com> <544AABB8.10302@codeaurora.org>
Message-ID: <alpine.DEB.2.11.1410251033270.5308@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Oct 2014, Stephen Boyd wrote:

> On 10/24/2014 10:59 AM, Marc Zyngier wrote:
> > Hi Bjorn,
> >
> > On 24/10/14 18:31, Bjorn Andersson wrote:
> >>
> >> Stephen Boyd talked about the need to be able to mask/unmask interrupts from
> >> client code in the Qualcomm platform as well - most likely to block wakeup
> >> sources(?)
> > What's wrong with irq_disable?
> 
> The problem is irq_disable() is lazy and doesn't actually disable the
> interrupt.

Nothing prevents you from adding your own irq_disable() callback for
those interrupts. Just the default is lazy.

Thanks,

	tglx
