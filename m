From: joe@perches.com (Joe Perches)
Date: Mon, 18 Nov 2013 14:18:48 -0800
Subject: [PATCHv7] dmaengine: Add support for BCM2835
In-Reply-To: <20131118145400.GE16735@n2100.arm.linux.org.uk>
References: <5288E327.8050809@koalo.de> <1384768816.14845.186.camel@smile>
 <528A051A.7000703@koalo.de> <1384785017.14845.214.camel@smile>
 <20131118145400.GE16735@n2100.arm.linux.org.uk>
Message-ID: <1384813128.17783.3.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-11-18 at 14:54 +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 18, 2013 at 04:30:17PM +0200, Andy Shevchenko wrote:
> > On Mon, 2013-11-18 at 13:16 +0100, Florian Meier wrote:
> > > >> +	uint32_t chans_available;
> > > > 
> > > > Why uint32_t?
> > > 
> > > Because it is a bit mask of fixed length that directly comes from the
> > > firmware.
> > 
> > Like one already told you in your i2s patch, please, change that to
> > corresponding u* value, namely u32.
> 
> There's no problem with uint32_t vs u32 - either will do.  u32 is the
> pre-stdint.h Linux definition of a 32-bit unsigned integer.  There's
> no reason why uint32_t isn't perfectly acceptable.  It's a matter of
> author taste which gets used.  (Except where modifications are to an
> existing chunk of code using one or the other - where consistency then
> matters more.)

https://lkml.org/lkml/2006/5/2/258
