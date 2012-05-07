From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 May 2012 10:14:03 +0000
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <20120507094718.GD4415@opensource.wolfsonmicro.com>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <20120507090858.GN26481@n2100.arm.linux.org.uk>
 <20120507094718.GD4415@opensource.wolfsonmicro.com>
Message-ID: <201205071014.03632.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 May 2012, Mark Brown wrote:
> > What if you have two devices both claiming IO regions at 0?  Hint: it
> > fails.
> 
> Don't think I've got any examples with regions beginning at 0 but other
> regions seem to not run into any problems with overlap.  Note that all
> these drivers do with the regions is use them to look up the base
> register.

ISA devices start at 0. Using a definition for IORESOURCE_IO of "PCI
port number for relatively large values, but either ISA or PCMCIA or
an arbitrary MFD for relatively small values" is absolutely crazy.

FWIW, there are resources you define in include/linux/mfd/wm831x/core.h
that have values between 0x4000 and 0x8000, which is exactly the
range occupied by PCI devices on my thinkpad. It's only a matter of
time until someone puts conflicting devices into one machine.

	Arnd
