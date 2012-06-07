From: david.jander@protonic.nl (David Jander)
Date: Thu, 7 Jun 2012 08:13:00 +0200
Subject: [PATCH 1/2] ARM i.MX51: setup mipi
In-Reply-To: <20120607025949.GM2667@S2101-09.ap.freescale.net>
References: <1338888630-25930-1-git-send-email-s.hauer@pengutronix.de>
 <1338888630-25930-2-git-send-email-s.hauer@pengutronix.de>
 <20120607025949.GM2667@S2101-09.ap.freescale.net>
Message-ID: <20120607081300.7a554215@archvile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jun 2012 10:59:51 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> Hi Sascha,
> 
> On Tue, Jun 05, 2012 at 11:30:29AM +0200, Sascha Hauer wrote:
> > The mipi unit has to be brought to a sane default state. This
> > unit is not present on i.MX53, so we add the setup here instead
> > of the ipu driver.
> > 
> Can't we do some detection in IPU driver to have the setup done in
> IPU driver?  To me, this (as well as the reset in patch #2) is not
> really the material for soc specific initialization.  If I'm running
> a system without IPU driver enabled, why do I have to go through these
> setup at all?

I would consider it part of SoC setup for the simple reason, that this
peripheral officially does not even exist (although it is physically there in
the chip and unfortunately _needs_ to be initialized). There is no
documentation of it anywhere (besides old, obsolete and unreleased manuals).
If one wanted to implement an IPU driver later on, there would be no way of
knowing that this part must be done first. We should take the chance that
someone happens to have this "knowledge" and do this (further harmless)
initialization in SoC setup, so that it is dealt with and won't get in the way
later. There is no worse driver developer nightmare than incomplete
documentation causing your otherwise correct driver to just not work.
OTOH, if this was an officially supported peripheral, it should have it's own
driver and not be part of the IPU driver either.

Best regards,

-- 
David Jander
Protonic Holland.
