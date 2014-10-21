From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 21 Oct 2014 11:22:40 +0200 (CEST)
Subject: [PATCH] genirq: Introduce irq_read_line()
In-Reply-To: <CAJAp7OgGPZZuCgC8iUiW2jrEVubK=KCATxd6eazdT1x1sSrffg@mail.gmail.com>
References: <1408479811-26088-1-git-send-email-bjorn.andersson@sonymobile.com>
 <CAJAp7OgGPZZuCgC8iUiW2jrEVubK=KCATxd6eazdT1x1sSrffg@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1410211120430.5308@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Sep 2014, Bjorn Andersson wrote:

> On Tue, Aug 19, 2014 at 1:23 PM, Bjorn Andersson
> <bjorn.andersson@sonymobile.com> wrote:
> > Introduce the irq_read_line() function to allow device drivers to read
> > the current logical state of an input when the hardware only exposes
> > this through status bits in the interrupt controller.
> >
> > The new function is backed by a new callback function in the irq_chip -
> > irq_read_line() - that can be implemented by irq_chips that owns such
> > status bits.
> >
> > Based on rfc patch from April 2011 by Abhijeet.
> >
> > Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> 
> ping?

Sorry, slipped through the cracks. I was talking about this to Marc
last week and he needs it for yet another reason. He had some thoughts
about the state representation, so I wait for him to comment.

Thanks,

	tglx
