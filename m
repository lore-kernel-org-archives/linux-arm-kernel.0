From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 04 Apr 2013 14:28:38 +0900
Subject: APE6EVM and Runtime PM
In-Reply-To: <20130404044101.GG28297@verge.net.au>
References: <20130404020019.GA7163@verge.net.au>
 <87wqsjdlhv.wl%kuninori.morimoto.gx@renesas.com>
 <20130404044101.GG28297@verge.net.au>
Message-ID: <uy5cy7tkp.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dear Simon

> > > in the course of looking look at consolidating our defconfigs I
> > > noticed that SMSC ethernet and rcar_thermal seem seem to not work when
> > > runtime PM is enabled.
> > > 
> > > I'm wondering if you have any ideas of what might be the cause of this
> > > or if you could give me some guidance on investigating this problem.
> > > 
> > > I assume that it relates to a clock or clocks not being enabled.
> > 
> > About rcar_thermal, it needs my patch which was sent to PM ML.
> > I got email from Zhang that he accepted my patch (pm_runtime support for thermal).
> > But it seems he didn't push his branch yet...
> > I guess I explained this on my [PATCH 0/x] email.
> 
> Thanks, sorry for missing that.
> 
> I guess we are down to just SMSC then.

I didn't check real board,
but I guess current SMSC IRQ came from IRQC,
and this IRQC needs MSTP 407.
But IRQC driver seems doesn't support PM_RUNTIME at this point.

Does your issue solve by adding MSTP 407 with CLK_ENABLE_ON_INIT ?
I'm not sure this is good solution, but quick-hack

Best regards
--
Kuninori Morimoto
 
