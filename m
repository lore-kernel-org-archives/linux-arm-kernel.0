From: olof@lixom.net (Olof Johansson)
Date: Wed, 1 Apr 2015 17:56:00 -0700
Subject: [PATCH 1/1] ARM: configs: remove all CONFIG_RCAR_AUDMAC_PP from
 ARM defconfigs
In-Reply-To: <87zj79d06x.wl%kuninori.morimoto.gx@renesas.com>
References: <871tkleesi.wl%kuninori.morimoto.gx@renesas.com>
 <87zj79d06x.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20150402005600.GL8137@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 05:30:09AM +0000, Kuninori Morimoto wrote:
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
> Audio DMAC peri peri DMAEngine is no longer needed.
> Remove all CONFIG_RCAR_AUDMAC_PP from ARM defconfigs
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks.


-Olof
