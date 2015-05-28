From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 May 2015 10:44:18 +0200
Subject: [PATCH] fixup! dmaengine: pxa_dma: add debug information
In-Reply-To: <1432761820-32072-1-git-send-email-robert.jarzmik@free.fr>
References: <1432761820-32072-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <4458136.GkSIoPB3S5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 May 2015 23:23:40 Robert Jarzmik wrote:
> This fixes the following error:
> drivers/dma/pxa_dma.c: In function ?dbg_show_requester_chan?:
> drivers/dma/pxa_dma.c:192:2: error: void value not ignored as it ought to be
>   pos += seq_printf(s, "DMA channel %d requester :\n", phy->idx);
>   ^
> drivers/dma/pxa_dma.c:197:8: error: void value not ignored as it ought to be
>         !!(drcmr & DRCMR_MAPVLD));
>         ^
> scripts/Makefile.build:258: recipe for target 'drivers/dma/pxa_dma.o' failed
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

I ran into the problem yesterday and came up with the same fix, but you
submitted it first, thanks!

	Arnd
