From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Apr 2012 10:27:30 +0000
Subject: [PATCH] ARM: fix __io macro for PCMCIA
In-Reply-To: <20120404090335.GQ24211@n2100.arm.linux.org.uk>
References: <1333509112-1555-1-git-send-email-robherring2@gmail.com>
 <20120404090335.GQ24211@n2100.arm.linux.org.uk>
Message-ID: <201204041027.30353.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 April 2012, Russell King - ARM Linux wrote:
> On Tue, Apr 03, 2012 at 10:11:52PM -0500, Rob Herring wrote:
> > With commit c334bc1 (ARM: make mach/io.h include optional), PCMCIA was
> > broken as PCMCIA depends on __io() being just a cast. This needs a better
> > fix with a fixed i/o address mapping, but for now we just restore things
> > to the previous behavior.
> 
> And what about systems with PCI IO at non-zero offsets with cardbus/pcmcia?
> This is broken and your assumption above is wrong.

I would think they all still use their own mach/io.h. Which ones are you
thinking of?

	Arnd
