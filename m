From: khiem.nguyen.xt@renesas.com (Khiem Nguyen)
Date: Tue, 03 Jun 2014 13:29:47 +0900
Subject: [PATCH 0/4] ARM: shmobile: koelsch legacy: Enable DMA for QSPI
In-Reply-To: <1401716424-29740-1-git-send-email-geert+renesas@glider.be>
References: <1401716424-29740-1-git-send-email-geert+renesas@glider.be>
Message-ID: <538D4F3B.6080806@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thanks for the patch.

It seems that patch 1 and patch 2 are to support DMA in general,
while patch 3 and patch 4 are to support DMA  for QSPI.

So, I think it should be separated into 2 patch series.
How do you think about it ?

Best regards,
KHIEM Nguyen

On 6/2/2014 10:40 PM, Geert Uytterhoeven wrote:
> This patch series enables DMA support for QSPI on r8a7791/koelsch legacy.
> It's independent from the series "ARM: shmobile: koelsch reference: Enable
> DMA for QSPI".
>
> [2/4] was written by Morimoto-san for LTSI 3.10, and forward ported by me.
>
> This was tested on r8a7791/koelsch.
>
> Performance figures for reading from a QSPI FLASH driven at 24.375 MHz are:
>    - Single:  1.1 Mbps PIO, 23 Mbps DMA
>    - Dual  : 12.7 Mbps PIO, 48 Mbps DMA
>    - Quad  : 13   Mbps PIO, 70 Mbps DMA
>
> Thanks for your comments!
>
>    [1/4] ARM: shmobile: r8a7791: Add SYS-DMAC clocks
>    [2/4] ARM: shmobile: r8a7791: Add SYS-DMAC support
>    [3/4] ARM: shmobile: r8a7791: Add QSPI DMA support
>    [4/4] ARM: shmobile: koelsch legacy: Enable DMA for QSPI
>
>   arch/arm/mach-shmobile/board-koelsch.c        |  2 +
>   arch/arm/mach-shmobile/clock-r8a7791.c        |  6 +-
>   arch/arm/mach-shmobile/include/mach/r8a7791.h |  7 +++
>   arch/arm/mach-shmobile/setup-r8a7791.c        | 82 +++++++++++++++++++++++++++
>   4 files changed, 96 insertions(+), 1 deletion(-)
>
> Gr{oetje,eeting}s,
>
> 						Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
