From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 20 Apr 2016 20:24:04 +0200
Subject: [PATCH] ARM: pxa: remove platform dma code
In-Reply-To: <1459675439-25941-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Sun, 3 Apr 2016 11:23:59 +0200")
References: <1459675439-25941-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87oa94rvej.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> As the last pxa related driver was converted to dmaengine, it's time to
> kill the legacy dma code, which is not used anymore.
>
> This finishes the pxa dmaengine transition.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  arch/arm/mach-pxa/devices.h          |   1 +
>  arch/arm/mach-pxa/include/mach/dma.h |   1 -
>  arch/arm/mach-pxa/pxa25x.c           |   3 -
>  arch/arm/mach-pxa/pxa27x.c           |   3 -
>  arch/arm/mach-pxa/pxa3xx.c           |   3 -
>  arch/arm/plat-pxa/Makefile           |   2 -
>  arch/arm/plat-pxa/dma.c              | 386 -----------------------------------
>  arch/arm/plat-pxa/include/plat/dma.h | 100 ---------
>  8 files changed, 1 insertion(+), 498 deletions(-)
>  delete mode 100644 arch/arm/plat-pxa/dma.c
>  delete mode 100644 arch/arm/plat-pxa/include/plat/dma.h

I'll leave that one exposed until the next weekend so that the MMP maintainers
can raise a red flag if I break their architecture.

If no feedback, I'll queued it in my pxa/for-next tree.

Cheers.

--
Robert
