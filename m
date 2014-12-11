From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 11 Dec 2014 02:37:20 +0000
Subject: [PATCH] ARM: shmobile: r8a7794: Add QSPI clock to device tree
In-Reply-To: <20141211022147.GF513@verge.net.au>
References: <1418259561-27862-1-git-send-email-horms+renesas@verge.net.au>
 <87lhmf9dss.wl%kuninori.morimoto.gx@renesas.com>
 <20141211022147.GF513@verge.net.au>
Message-ID: <87h9x2ap3i.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> > > @@ -535,6 +535,14 @@
> > >  			clock-output-names =
> > >  				"vin1", "vin0", "ether";
> > >  		};
> > > +		mstp9_clks: mstp9_clks at e6150994 {
> > > +			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
> > > +			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
> > > +			clocks = <&cpg_clocks R8A7794_CLK_QSPI>;
> > > +			#clock-cells = <1>;
> > > +			renesas,clock-indices = <R8A7794_CLK_QSPI_MOD>;
> > > +			clock-output-names = "qspi_mod";
> > > +		};
> > 
> > We want ot use this ?
> > 
> > - renesas,clock-indices
> > + clock-indices
> 
> Thanks, and sorry for missing that. I'll fix that up.
> Do you have any objections to the patch if that problem is resolved?

Thank you
I have no objections.
