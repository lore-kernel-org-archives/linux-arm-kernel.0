From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 13:36:16 +0100
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201104281412.40991.arnd@arndb.de>
References: <201104212129.17013.arnd@arndb.de> <11431.1303949729@localhost>
	<1303979259.26744.3.camel@e102109-lin.cambridge.arm.com>
	<201104281412.40991.arnd@arndb.de>
Message-ID: <20110428123616.GI17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 02:12:40PM +0200, Arnd Bergmann wrote:
> On Thursday 28 April 2011, Catalin Marinas wrote:
> > On Thu, 2011-04-28 at 01:15 +0100, Valdis.Kletnieks at vt.edu wrote:
> > > On Wed, 27 Apr 2011 12:08:28 BST, Catalin Marinas said:
> > > 
> > > > The current version of the ARM ARM says "unpredictable". But this
> > > > general definition of "unpredictable" does not allow it to deadlock
> > > > (hardware) or have security implications. It is however allowed to
> > > > corrupt data.
> > > 
> > > Not allowed to have security implications, but is allowed to corrupt data.
> > 
> > By security I was referring to TrustZone extensions. IOW, unpredictable
> > in normal (non-secure) world should not cause data corruption in the
> > secure world.
> 
> That definition is rather useless for operating systems that don't use
> Trustzone then, right?

I'm not sure what you're implying.  By running on a device with Trustzone
extensions, Linux is using them whether it knows it or not.

Linux on ARMs evaluation boards runs on the secure size of the Trustzone
dividing line.  Linux on OMAP SoCs runs on the insecure size of that,
and has to make secure monitor calls to manipulate certain registers
(eg, to enable workarounds for errata etc).  As SMC calls are highly
implementation specific, there is and can be no "trustzone" driver.
