From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 16 Aug 2017 17:33:13 +0200
Subject: [PATCH 3/5] reset: Add Realtek RTD1295 driver
In-Reply-To: <47359100-edf7-5aa4-a3ee-1250c8a84c5e@suse.de>
References: <20170816003847.6208-1-afaerber@suse.de>
 <20170816003847.6208-4-afaerber@suse.de>
 <1502876699.7596.3.camel@pengutronix.de>
 <47359100-edf7-5aa4-a3ee-1250c8a84c5e@suse.de>
Message-ID: <1502897593.7596.9.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-08-16 at 14:09 +0200, Andreas F?rber wrote:
> Hi Philipp,
> 
> Am 16.08.2017 um 11:44 schrieb Philipp Zabel:
> > On Wed, 2017-08-16 at 02:38 +0200, Andreas F?rber wrote:
> > > Add a per-register reset controller driver. This deals with the
> > > fact
> > > that not all registers are adjoined.
> > 
> > the way you handle the non-contiguous reset registers, this looks
> > like
> > a candidate to join the recently discussed reset-simple driver [1].
> > Could you check if that would fit?
> 
> Thanks, I appreciate the idea, and it looks like you already have the
> active-low logic in place.
> 
> Are you okay with keeping the first three as separate nodes, or would
> you rather want one node to cover the first three registers, plus two
> separate ones for the non-contiguous cases?

I am fine with keeping them separate, if you think this best describes
the hardware.

> Or is the simple driver supposed to cover gaps, too? Then we could go
> with just two nodes. (I found it weird to have reset and then reset4,
> so I went with separate ones as seen downstream.)

I had declared gaps as out of scope of the simple reset controller
driver, but if the implementation could be kept reasonably simple, we
could think about supporting something like this, too:

		reset: reset-controller at 98000000 {
			compatible = "realtek,rtd1295-reset";
			reg = <0x98000000 0xc>, <0x98000050 0x4>;
			#reset-cells = <1>;
		};

regards
Philipp
