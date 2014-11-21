From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 17:08:08 +0100
Subject: [PATCH resend 2/4] ARM: dts: sunxi: unify APB1 clock
In-Reply-To: <4114168.zuylrCsruj@wuerfel>
References: <1415245232-20585-1-git-send-email-wens@csie.org>
 <20141121142903.GD4752@lukather> <4114168.zuylrCsruj@wuerfel>
Message-ID: <2400552.aBVIZmJhTh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014 15:35:57 Arnd Bergmann wrote:
> On Friday 21 November 2014 15:29:03 Maxime Ripard wrote:
> > On Fri, Nov 21, 2014 at 12:57:02PM +0100, Arnd Bergmann wrote:
> > > On Thursday 20 November 2014 14:04:01 Kevin Hilman wrote:
> > > > Chen-Yu Tsai <wens@csie.org> writes:
> > > > 
> > > > > From: Emilio L?pez <emilio@elopez.com.ar>
> > > > >
> > > > > With the new factors infrastructure in place, we can unify apb1 and
> > > > > apb1_mux as a single clock now.
> > > > >
> > > > > Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> > > > > [wens at csie.org: Change apb1 node label to "apb1"; reword commit title]
> > > > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > > 
> > > > Boot breakage in arm-soc/for-next on sun4i-a10-cubieboard and
> > > > sun7i-a20-cubieboard2[1] was bisected down to this patch[1].
> > > > 
> > > > Reverting $SUBJECT on top of arm-soc gets things booting again.
> > > > 
> > > 
> > > As this looks like it was intended as a cleanup without functional
> > > changes, I would go ahead and revert it in next/dt.
> > > 
> > > Any objections?
> > 
> > Yeah, you'd break linux-next as well doing so, as the clock driver now
> > requires this from the DT.
> > 
> > I can merge it through the clock tree though if you prefer it that
> > way.
> 
> Do you know why this commit breaks booting then?
> 

I have now reverted the entire branch, to get things working again.

Please send a new pull request once you have a version that you 
have actually tested.

	Arnd
