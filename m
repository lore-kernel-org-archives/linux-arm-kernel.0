From: david.jander@protonic.nl (David Jander)
Date: Thu, 7 Jun 2012 09:55:54 +0200
Subject: [PATCH 1/2] ARM i.MX51: setup mipi
In-Reply-To: <CAAQ0ZWQX60YWvEi-cWtTouMoxg1WxWo_soHf+4gE7oXsPfC_1g@mail.gmail.com>
References: <1338888630-25930-1-git-send-email-s.hauer@pengutronix.de>
 <1338888630-25930-2-git-send-email-s.hauer@pengutronix.de>
 <20120607025949.GM2667@S2101-09.ap.freescale.net>
 <20120607081300.7a554215@archvile>
 <CAAQ0ZWQX60YWvEi-cWtTouMoxg1WxWo_soHf+4gE7oXsPfC_1g@mail.gmail.com>
Message-ID: <20120607095554.7e68ae5a@archvile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jun 2012 15:10:05 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> On 7 June 2012 14:13, David Jander <david.jander@protonic.nl> wrote:
> > I would consider it part of SoC setup for the simple reason, that this
> > peripheral officially does not even exist (although it is physically there in
> > the chip and unfortunately _needs_ to be initialized). There is no
> > documentation of it anywhere (besides old, obsolete and unreleased manuals).
> > If one wanted to implement an IPU driver later on, there would be no way of
> > knowing that this part must be done first. We should take the chance that
> > someone happens to have this "knowledge" and do this (further harmless)
> > initialization in SoC setup, so that it is dealt with and won't get in the way
> > later. There is no worse driver developer nightmare than incomplete
> > documentation causing your otherwise correct driver to just not work.
> > OTOH, if this was an officially supported peripheral, it should have it's own
> > driver and not be part of the IPU driver either.
> >
> That does not necessarily mean imx51_soc_init() is the right place for
> that initialization, simply because not every single boot of imx51
> needs that initialization.

I agree, but I couldn't come up with a better place.

> I can probably accept the mipi initialization changes if you are saying
> imx51_soc_init is not the right place for it either, but at the moment
> there is no better place than imx51_soc_init().

Sounds good. Yes, can we agree on that?

> But why can't we do ipu reset (the second patch) in ipu driver then?

No idea... I don't want to preempt Sascha here.
Just my guess: The system reset controller could potentially be used by other
peripherals, and in that case it would need to be a separate driver with
locking for register access. Doing it here seems a safe way of avoiding
concurrent access to the register of the SRC?
Same reason as above?

Best regards,

-- 
David Jander
Protonic Holland.
