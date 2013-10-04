From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 03 Oct 2013 21:46:42 -0400 (EDT)
Subject: [PATCH 0/3] v7-M support using MULTIPLATFORM
In-Reply-To: <20131003230535.GI12758@n2100.arm.linux.org.uk>
References: <1380534577-15076-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131003220037.GH12758@n2100.arm.linux.org.uk>
 <20131003222801.GE10079@pengutronix.de>
 <20131003230535.GI12758@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1310032143190.3023@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Oct 2013, Russell King - ARM Linux wrote:

> On Fri, Oct 04, 2013 at 12:28:01AM +0200, Uwe Kleine-K?nig wrote:
> > Right, but do we agree that it should be possible to create an XIP image
> > for i.MX6? If so: You currently cannot, because i.MX6 isn't configurable
> > without MULTIPLATFORM. Also in the times before MULTIPLATFORM XIP was
> > special.
> 
> That's one of the consequences of pushing to multiplatform support - XIP
> has fallen by the way side as a result of this effort (it was discussed
> previously) and we had decided that almost no one uses it anymore and it
> would not be part of the multiplatform stuff.  It was only really used
> by very few SA11x0 and PXA platforms anyway.

Semantically, MULTIPLATFORM is incompatible with XIP as well as NOMMU.

So if a platform exists only when MULTIPLATFORM is selected, preventing 
it from being configured as NOMMU or XIP then something is broken with 
MULTIPLATFORM.


Nicolas
