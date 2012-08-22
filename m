From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 22 Aug 2012 11:28:53 -0400 (EDT)
Subject: [PATCH 2/4] [RFC] ARM: mass move of mach-*/plat-* header files
In-Reply-To: <201208221256.35657.arnd@arndb.de>
References: <201208221253.07278.arnd@arndb.de>
 <201208221256.35657.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1208221126180.1754@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Aug 2012, Arnd Bergmann wrote:

> This moves all <mach/*.h> headers to <mach-*/*.h>, and all
> <plat/*.h> headers to <plat-*/*.h>, as another step closer
> to building kernels for multiple platforms combined.
> 
> A script to generate headers with the traditional names including
> the headers from the new place is already there, so this move
> should be completely transparent.
> 
> This patch was created fully automated by a script and
> should be redone if the headers change. Note that the
> plat-mxc headers move to mach-imx in the process because
> they don't follow the <plat/foo.h> naming convention:
> 
> for i in arch/arm/mach-* ; do git mv $i/include/mach $i/include/${i##*/} ; done
> for i in arch/arm/plat-* ; do git mv $i/include/plat $i/include/${i##*/} ; done
> git mv arch/arm/plat-mxc/include/mach/*.h arch/arm/mach-imx/include/mach-imx/
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nicolas Pitre <nico@linaro.org>

Ideally, files such as ...

> rename from arch/arm/mach-at91/include/mach/at91_pio.h
> rename to arch/arm/mach-at91/include/mach-at91/at91_pio.h

should move next to the A91 GPIO driver file.  but that require manual 
operations which can be done later.


Nicolas
