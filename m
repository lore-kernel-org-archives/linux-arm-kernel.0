From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jun 2013 18:13:38 +0100
Subject: [PATCH] ARM: optimize memset_io()/memcpy_fromio()/memcpy_toio()
In-Reply-To: <2184363.o70cB30E6f@wuerfel>
References: <E1THMAC-0004nL-8B@rmk-PC.arm.linux.org.uk>
 <51B76972.3040002@gmail.com> <20130613110501.GZ18614@n2100.arm.linux.org.uk>
 <2184363.o70cB30E6f@wuerfel>
Message-ID: <20130613171338.GI18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 02:47:35PM +0200, Arnd Bergmann wrote:
> On Thursday 13 June 2013 12:05:02 Russell King - ARM Linux wrote:
> > Yes, unfortunately it should be selectable by platform, though it needs
> > to be done carefully.  Some ARM platforms can't cope with full 32-bit
> > accesses to MMIO.
> > 
> > I don't think any of those intersect with the single zImage project, so
> > those should be fine to have it always enabled - it's only the older
> > platforms that might have issues.
> 
> Are those all StrongARM and XScale based platforms? If so, I definitely
> don't expect them to go multiplatform.

I'm not 100% positive on that, but...

> Can we combine this with the existing CONFIG_NEED_MACH_IO_H?

I think we probably can - because that implies that the generic set of
IO accessors are already being used, which means 8, 16 and 32 bit
accesses must be supportable without any kind of trickery.
