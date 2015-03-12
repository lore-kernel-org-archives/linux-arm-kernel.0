From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Mar 2015 09:54:05 +0100
Subject: [PATCH 1/2 v2] dmaengine: remove Renesas Audio DMAC peri peri
In-Reply-To: <87oanzf3r1.wl%kuninori.morimoto.gx@renesas.com>
References: <87pp8ff3sb.wl%kuninori.morimoto.gx@renesas.com>
 <87oanzf3r1.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <2564817.a7ILq7Cdmi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 March 2015 00:39:49 Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Renesas R-Car sound (= rsnd) needs 2 DMAC which are called as
> Audio DMAC (= 1st DMAC) and Audio DMAC peri peri (2nd DMAC).
> And rsnd had assumed that 1st / 2nd DMACs are implemented as DMAEngine.
> But, in result of DMA ML discussion, 2nd DMAC was concluded that it is
> not a general purpose DMAC (2nd DMAC is for Device to Device inside
> sound system). Additionally, current DMAEngine can't support Device to
> Device, and we don't have correct DT bindings for it at this point.
> So the easiest solution for it is that move it from DMAEngine to rsnd
> driver.
> Audio DMAC peri peri on DMAEngine is no longer needed. remove it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Arnd Bergmann <arnd@arndb.de>
