From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 30 Nov 2016 01:08:20 +0000
Subject: [alsa-devel] [PATCH v2] clkdev: add devm_of_clk_get()
In-Reply-To: <20161129210556.GC6095@codeaurora.org>
References: <87ziptixv7.wl%kuninori.morimoto.gx@renesas.com>
 <20160707122636.GP1041@n2100.armlinux.org.uk>
 <8760shgfzu.wl%kuninori.morimoto.gx@renesas.com>
 <146794140875.73491.7115209079607438738@resonance>
 <871t34hlin.wl%kuninori.morimoto.gx@renesas.com>
 <878twndi54.wl%kuninori.morimoto.gx@renesas.com>
 <8737isvwc6.wl%kuninori.morimoto.gx@renesas.com>
 <20161123191037.GE25626@codeaurora.org>
 <87a8cpejn5.wl%kuninori.morimoto.gx@renesas.com>
 <87y409cw71.wl%kuninori.morimoto.gx@renesas.com>
 <20161129210556.GC6095@codeaurora.org>
Message-ID: <874m2pbwsn.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Stephen

Thank you for your feedback.

> > > >  	sound_soc {
> > > > 		clocks = <&xxx>, <&xxx>;
> > > > 		clock-names = "cpu", "codec";
> > > >  		...
> > > >  		cpu {
> > > >  			...
> > > >  		};
> > > >  		codec {
> > > >  			...
> > > >  		};
> > > >  	};
(snip)
> The problem is that it encourages the use of of_clk_get() when
> clk_get() is more desirable. Ideally of_clk_get() is never used
> when a device exists. In this case, it seems like we need to
> support it though, hence the suggestion of having a
> devm_get_clk_from_child() API, that explicitly reads as "get a
> clock from a child node of this device". The distinction is
> important, because of_clk_get() should rarely be used.

I understand your point, but I think devm_get_clk_from_child()
needs new DT setings, and it can't keep compatibility, or
it makes driver complex.
I think it is nice to have. but, I want to keep current style.
Thus, I will try to use current of_clk_get() as-is, and
call clk_free() somehow in this driver.
