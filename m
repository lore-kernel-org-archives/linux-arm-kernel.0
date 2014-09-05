From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Sep 2014 18:25:35 +0200
Subject: [PATCH v2 1/4] arm64,
 thunder: Add Kconfig option for Cavium Thunder SoC Family
In-Reply-To: <20140905142245.GG20164@leverpostej>
References: <1409903205-2762-1-git-send-email-rric@kernel.org>
 <7863371.EMkUuntQWU@wuerfel> <20140905142245.GG20164@leverpostej>
Message-ID: <2952834.1P42roDKD9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 September 2014 15:22:46 Mark Rutland wrote:
> 
> > A common pattern these days is to do dependencies like
> > 
> > arch/*/Kconfig:
> >       config ARCH_FOO
> >       bool "Enable support for Foo platform"
> >       help
> >         ...
> > 
> > 
> > drivers/*/Kconfig
> >       config SUBSYS_FOO
> >       bool "SUBSYS driver for Foo"
> >       depends on ARCH_FOO || COMPILE_TEST
> >       depends on OF && REGULATOR && GENERIC_PHY # or whatever
> 
> Russell's comments w.r.t. Kconfig warnings when config names change
> still holds regardless of select vs depends on.

Yes, that's what I wrote in my reply as well.

> > That way we can enable everything in the defconfig, but someone
> > who likes to build a more specialized kernel can disable the
> > other platforms and won't get the drivers that are specific to
> > those.
> > 
> > I personally think this is a bit more verbose than what we need, but
> > I don't strongly object doing it that way.
> 
> You'd still be able to do this without ARCH_FOO, though you would need
> to know which drivers are necessary for a particular SoC. That seems to
> be the way things are handled on x86; I don't recall having to select
> support for specific machines there, just the individual drivers.

The main difference is that there are very few drivers on x86 that are
specific to one of the two chip makers. Almost everything is a PCI
device that can actually be plugged in anywhere.

On ARM64 there is going to be a lot of stuff that really makes sense
only for one of the 50 licensees.

	Arnd
