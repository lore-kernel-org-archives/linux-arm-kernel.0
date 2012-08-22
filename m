From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Aug 2012 15:37:53 +0000
Subject: [PATCH 2/4] [RFC] ARM: mass move of mach-*/plat-* header files
In-Reply-To: <alpine.LFD.2.02.1208221126180.1754@xanadu.home>
References: <201208221253.07278.arnd@arndb.de>
 <201208221256.35657.arnd@arndb.de>
 <alpine.LFD.2.02.1208221126180.1754@xanadu.home>
Message-ID: <201208221537.53904.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 August 2012, Nicolas Pitre wrote:
> Ideally, files such as ...
> 
> > rename from arch/arm/mach-at91/include/mach/at91_pio.h
> > rename to arch/arm/mach-at91/include/mach-at91/at91_pio.h
> 
> should move next to the A91 GPIO driver file.  but that require manual 
> operations which can be done later.

Right. There are cases where we have to do this eventually because the
files are duplicated, e.g. at91/avr32, pxa/mmp, s3c/s5p/exynos, or
sa1100/pxa.

For the majority of cases where it's desirable to move the header file
closer to the driver, it's not actually a prerequisite to do this
in order to get a complete multiplatform setup.

	Arnd
