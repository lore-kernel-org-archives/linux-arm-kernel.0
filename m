From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Apr 2016 13:38:15 +0100
Subject: [RFC PATCH] arm64: defconfig: add config fragment for Freescale
 SoCs
In-Reply-To: <4532019.nAsqsHX23H@wuerfel>
References: <1460643685-13670-1-git-send-email-stuart.yoder@nxp.com>
 <20160414170433.GF15182@e104818-lin.cambridge.arm.com>
 <4532019.nAsqsHX23H@wuerfel>
Message-ID: <20160418123815.GC18257@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 16, 2016 at 06:50:53PM +0200, Arnd Bergmann wrote:
> On Thursday 14 April 2016 18:04:33 Catalin Marinas wrote:
> > > Allowing us to have a freescale.config gives us the flexibility of
> > > adding Freescale specific options without having to keep this in
> > > some other external repo.  It also keeps vendor specific clutter
> > > out of the base defconfig.  With the number of new armv8 chips 
> > > coming out the single defconfig is going to produce increasingly
> > > large kernels, since all drivers are built-in.
> > 
> > As I said, for the time being please add all the sane the options to
> > defconfig. I want to be able to build a defconfig and run on all
> > supported SoCs.
> 
> I'd suggest making the non-essential drivers loadable modules though,
> in particular the sensor drivers.

I'm fine with this.

> There are two block device drivers included here (SoC specific
> front-ends for AHCI and SDHCI), I'm not sure about what to do with
> them, but we should try to do it consistently, either making
> them all built-in to simplify booting from them without a ramdisk,
> or try to make them all modules as well.

For now, I think all drivers required for mounting the root filesystem
(whether it's on some non-volatile memory or NFS) should be built in.

It would be nice to have (mostly) everything as loadable modules but, at
least for kernel developers, there isn't a simple way to get the modules
in a ramdisk and easily test such kernels (that's more of a distro
feature). IIRC there were discussions at an ARM mini-summit in the past
around minimal kbuild support for generating a ramdisk with modules and
necessary tools. But I don't know whether anyone started looking into
this (in the 32-bit ARM context).

-- 
Catalin
