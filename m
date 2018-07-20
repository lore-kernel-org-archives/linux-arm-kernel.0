From: ckeepax@opensource.cirrus.com (Charles Keepax)
Date: Fri, 20 Jul 2018 14:22:58 +0100
Subject: [PATCH] ASoC: wm9712: fix replace codec to component
In-Reply-To: <87effy48lz.wl-kuninori.morimoto.gx@renesas.com>
References: <20180720075148.14648-1-marcel@ziswiler.com>
 <87effy48lz.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <20180720132258.GD18740@imbe.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 08:30:41AM +0000, Kuninori Morimoto wrote:
> 
> Hi Marcel
> 
> > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > Since commit 143b44845d87 ("ASoC: wm9712: replace codec to component")
> > "wm9712-codec" got renamed to "wm9712-component", however, this change
> > never got propagated down to the actual board/platform drivers. E.g. on
> > Colibri T20 this lead to the following spew upon boot with sound/touch
> > being broken:
> 
> Oops, my bad...
> The platform_driver name is not important,
> how about simply rename back it to "wm9712-codec" ?
> 

Yeah I would agree here wm9712-component isn't great as a name
for board files etc. Lets rename back to wm9712-codec for these
specific bits.

Thanks,
Charles
