From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 27 Jul 2013 16:38:16 +0200
Subject: [PATCH v2 1/5] ARM: Broadcom: Unconditionally build
 arch/arm/mach-bcm
In-Reply-To: <20130726234237.GB24642@n2100.arm.linux.org.uk>
References: <20130726145639.116237136@gmail.com>
 <20130726231108.GA10812@obsidianresearch.com>
 <20130726234237.GB24642@n2100.arm.linux.org.uk>
Message-ID: <201307271638.16289.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 27 July 2013, Russell King - ARM Linux wrote:
> On Fri, Jul 26, 2013 at 05:11:08PM -0600, Jason Gunthorpe wrote:
> > On Fri, Jul 26, 2013 at 11:59:00PM +0200, Domenico Andreoli wrote:
>
> Anyway, there's a simpler solutions to this:
> 
> machdirs := $(patsubst %,arch/arm/mach-%/,$(sort $(machine-y)))
> platdirs := $(patsubst %,arch/arm/plat-%/,$(Sort $(plat-y)))
> 
> which will remove all duplicates.

This does sound like the easiest solution, although I still think
Olof's suggestion of making ARCH_BCM a silent Kconfig symbol would be
just as good if we just have this one instance.

	Arnd
