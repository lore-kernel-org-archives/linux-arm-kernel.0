From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 21 Dec 2011 20:09:33 +0000
Subject: [RFC PATCH] ARM: new architecture for Energy Micro's EFM32
 Cortex-M3 SoCs
In-Reply-To: <20111221195602.GK2577@n2100.arm.linux.org.uk>
References: <1324480428-13344-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20111221154838.GA23102@page>
 <20111221195602.GK2577@n2100.arm.linux.org.uk>
Message-ID: <20111221200933.GA3117@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 07:56:02PM +0000, Russell King - ARM Linux wrote:
> On Wed, Dec 21, 2011 at 03:48:50PM +0000, Jamie Iles wrote:
> > > +#define __io(a)			__typesafe_io(a)
> > 
> > Do you support io ports on this platform?  If not then perhaps select 
> > NO_IPORT and define __io(a) to 0?
> 
> Do not do that.  Define NO_IOPORT and *do* *not* define __io() at all to
> make drivers which use PCI IO stuff fail at build time.  Don't try to
> frig it into doing a NULL pointer deref.

Fair point.  I said that because I remember that the 8250 driver uses 
ioport accessors even for !HAVE_IOPORT and that some patches to remove 
that were nacked, but I don't remember the details.  But yes, not 
defining __io would be much better!

Jamie
