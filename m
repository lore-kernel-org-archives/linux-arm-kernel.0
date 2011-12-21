From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Dec 2011 19:56:02 +0000
Subject: [RFC PATCH] ARM: new architecture for Energy Micro's EFM32
 Cortex-M3 SoCs
In-Reply-To: <20111221154838.GA23102@page>
References: <1324480428-13344-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20111221154838.GA23102@page>
Message-ID: <20111221195602.GK2577@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 03:48:50PM +0000, Jamie Iles wrote:
> > +#define __io(a)			__typesafe_io(a)
> 
> Do you support io ports on this platform?  If not then perhaps select 
> NO_IPORT and define __io(a) to 0?

Do not do that.  Define NO_IOPORT and *do* *not* define __io() at all to
make drivers which use PCI IO stuff fail at build time.  Don't try to
frig it into doing a NULL pointer deref.
