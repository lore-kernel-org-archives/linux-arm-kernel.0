From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 26 Feb 2016 23:33:58 +0100
Subject: [PATCH] ARM: dts: pxa: fix dma engine node to pxa3xx-nand
In-Reply-To: <1455320960-10121-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Sat, 13 Feb 2016 00:49:20 +0100")
References: <1455320960-10121-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <871t7zumnd.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Since the switch from mmp_pdma to pxa_dma driver for pxa architectures,
> the pxa_dma requires 2 arguments, namely the requestor line and the
> requested priority.
>
> Fix the only left device node which was still passing only one argument,
> making the pxa3xx-nand driver misbehave in a device-tree configuration,
> ie. failing all data transfers.
>
> Fixes: c943646d1f49 ("ARM: dts: pxa: add dma engine node to pxa3xx-nand")
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  arch/arm/boot/dts/pxa3xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
Queued into pxa/dt, thanks.

--
Robert
