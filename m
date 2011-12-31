From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 31 Dec 2011 15:24:42 +0800
Subject: [PATCH] MTD/GPMI : select more modules for GPMI by default
In-Reply-To: <4EFEA210.30606@freescale.com>
References: <1325220337-23165-1-git-send-email-b32955@freescale.com>
 <20111231054432.GE12182@S2100-06.ap.freescale.net>
 <4EFEA210.30606@freescale.com>
Message-ID: <20111231072441.GF12182@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 31, 2011 at 01:48:00PM +0800, Huang Shijie wrote:
> ? 2011?12?31? 13:44, Shawn Guo ??:
> >>+	select MXS_DMA
> >We should probably have it depend on MXS_DMA rather than select it.
> IMHO, I think `select` is better. :)
> The MXS_DMA not only service for NAND, but SD card, etc.
> In logic, the GPMI does not depends on MXS_DMA, the GPMI may use
> SDMA too(just in logically).
> 
Here is what Documentation/kbuild/kconfig-language.txt tells:

        select should be used with care. select will force
        a symbol to a value without visiting the dependencies.
        By abusing select you are able to select a symbol FOO even
        if FOO depends on BAR that is not set.
        In general use select only for non-visible symbols
        (no prompts anywhere) and for symbols with no dependencies.
        That will limit the usefulness but on the other hand avoid
        the illegal configurations all over.

-- 
Regards,
Shawn
