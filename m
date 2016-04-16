From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Apr 2016 18:50:53 +0200
Subject: [RFC PATCH] arm64: defconfig: add config fragment for Freescale
 SoCs
In-Reply-To: <20160414170433.GF15182@e104818-lin.cambridge.arm.com>
References: <1460643685-13670-1-git-send-email-stuart.yoder@nxp.com>
 <20160414170433.GF15182@e104818-lin.cambridge.arm.com>
Message-ID: <4532019.nAsqsHX23H@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 April 2016 18:04:33 Catalin Marinas wrote:
> 
> > Allowing us to have a freescale.config gives us the flexibility of
> > adding Freescale specific options without having to keep this in
> > some other external repo.  It also keeps vendor specific clutter
> > out of the base defconfig.  With the number of new armv8 chips 
> > coming out the single defconfig is going to produce increasingly
> > large kernels, since all drivers are built-in.
> 
> As I said, for the time being please add all the sane the options to
> defconfig. I want to be able to build a defconfig and run on all
> supported SoCs.

I'd suggest making the non-essential drivers loadable modules though,
in particular the sensor drivers.

There are two block device drivers included here (SoC specific
front-ends for AHCI and SDHCI), I'm not sure about what to do with
them, but we should try to do it consistently, either making
them all built-in to simplify booting from them without a ramdisk,
or try to make them all modules as well.

	Arnd
