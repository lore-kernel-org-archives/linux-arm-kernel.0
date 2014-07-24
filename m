From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 24 Jul 2014 16:44:20 -0700
Subject: [PATCH v11 0/2] Add support for the Allwinner A31 DMA Controller
In-Reply-To: <20140724121315.GV20328@lukather>
References: <1405626376-471-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140724121315.GV20328@lukather>
Message-ID: <20140724164420.d7c58c9b5f6bf3e06137494f@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Jul 2014 14:13:15 +0200 Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Thu, Jul 17, 2014 at 09:46:14PM +0200, Maxime Ripard wrote:
> > Hi,
> > 
> > This patchset adds support for the DMA controller found in the
> > Allwinner A31 and A23 SoCs.
> > 
> > This has been tested using the newly introduced SPI driver on an A31
> > EVK. Support for DMA-driven SPI transfers will be the subject of
> > another patch serie.
> > 
> > This has been around for around 5 monthes now, and didn't get any
> > review but nitpicks for three versions, so I feel like it could be
> > merged quite quickly.
> 
> Ok, so, who should I bribe to get this merged?

Turns out I'm easily bribed.  The code looks pretty clean and simple
and is refreshingly free of comments, which only confuse people anyway.

I think we could do this as a single patch - is there any benefit to
splitting it apart like this?

The combinations of spin_lock()/spin_lock_irq() and spin_lock_irqsave()
are a bit scary - it's easy to get these optimisations wrong.  Has it
been thoroughly tested with lockdep enabled?
