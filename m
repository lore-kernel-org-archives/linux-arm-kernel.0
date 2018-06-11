From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 11 Jun 2018 05:43:14 +0000
Subject: [PATCH v2 2/3] ASoC: simple-card: move hp and mic detection to
 soc_card probe
In-Reply-To: <007401d40146$9ddaaec0$d9900c40$@socionext.com>
References: <20180611051559.18082-1-suzuki.katsuhiro@socionext.com>
 <20180611051559.18082-2-suzuki.katsuhiro@socionext.com>
 <87tvq96gnm.wl-kuninori.morimoto.gx@renesas.com>
 <007401d40146$9ddaaec0$d9900c40$@socionext.com>
Message-ID: <87sh5t6fwv.wl-kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Katsuhiro

> > > This patch moves headphone and microphone detection to probe() of
> > > snd_soc_card from init() of snd_soc_dai_link. This is because init()
> > > is called (and an input device /dev/input/eventX is created too)
> > > twice or above if simple card has two or more DAI links.
(snip)
> It seems if simple card has multiple DAI links, it creates multiple input 
> devices.
> 
> For example simple card has 3-links, 3 input devices /dev/input/event0,
> event1, event2 are created. Is it correct?

Oh, I see, fair enough.
I'm sorry, it was my English skill error.

Best regards
---
Kuninori Morimoto
