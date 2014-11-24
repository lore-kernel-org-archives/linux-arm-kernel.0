From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Nov 2014 22:44:50 +0100
Subject: [PATCH resend 2/4] ARM: dts: sunxi: unify APB1 clock
In-Reply-To: <7ha93gmwab.fsf@deeprootsystems.com>
References: <1415245232-20585-1-git-send-email-wens@csie.org>
 <20141121142903.GD4752@lukather> <4114168.zuylrCsruj@wuerfel>
 <2400552.aBVIZmJhTh@wuerfel> <20141122073515.GJ4752@lukather>
 <7ha93gmwab.fsf@deeprootsystems.com>
Message-ID: <20141124214450.GR4752@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Mon, Nov 24, 2014 at 07:51:40AM -0800, Kevin Hilman wrote:
> Maxime Ripard <maxime.ripard@free-electrons.com> writes:
> 
> > Arnd,
> >
> > On Fri, Nov 21, 2014 at 05:08:08PM +0100, Arnd Bergmann wrote:
> >> On Friday 21 November 2014 15:35:57 Arnd Bergmann wrote:
> >> > On Friday 21 November 2014 15:29:03 Maxime Ripard wrote:
> >> > > On Fri, Nov 21, 2014 at 12:57:02PM +0100, Arnd Bergmann wrote:
> >> > > > On Thursday 20 November 2014 14:04:01 Kevin Hilman wrote:
> >> > > > > Chen-Yu Tsai <wens@csie.org> writes:
> >> > > > > 
> >> > > > > > From: Emilio L?pez <emilio@elopez.com.ar>
> >> > > > > >
> >> > > > > > With the new factors infrastructure in place, we can unify apb1 and
> >> > > > > > apb1_mux as a single clock now.
> >> > > > > >
> >> > > > > > Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> >> > > > > > [wens at csie.org: Change apb1 node label to "apb1"; reword commit title]
> >> > > > > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> > > > > 
> >> > > > > Boot breakage in arm-soc/for-next on sun4i-a10-cubieboard and
> >> > > > > sun7i-a20-cubieboard2[1] was bisected down to this patch[1].
> >> > > > > 
> >> > > > > Reverting $SUBJECT on top of arm-soc gets things booting again.
> >> > > > > 
> >> > > > 
> >> > > > As this looks like it was intended as a cleanup without functional
> >> > > > changes, I would go ahead and revert it in next/dt.
> >> > > > 
> >> > > > Any objections?
> >> > > 
> >> > > Yeah, you'd break linux-next as well doing so, as the clock driver now
> >> > > requires this from the DT.
> >> > > 
> >> > > I can merge it through the clock tree though if you prefer it that
> >> > > way.
> >> > 
> >> > Do you know why this commit breaks booting then?
> >> > 
> >> 
> >> I have now reverted the entire branch, to get things working again.
> >> 
> >> Please send a new pull request once you have a version that you 
> >> have actually tested.
> >
> > This was tested and working. And again, the linux-next proves it.
> >
> > I know very well why it doesn't work, and it's actually expected: some
> > clock was refactored, the DT needed to be changed, only half of it was
> > merged through arm-soc.
> >
> > It really is just because one part got through arm-soc, the other
> > through the clock tree, nothing more.
> 
> Which branch (already in linux-next) would be needed in arm-soc/for-next
> to resolve the dependency?

It used to be part of the sunxi/for-next branch I maintain, but the
part that would solve it has not been picked up by Mike.

You can drop this pull request anyway, I just sent a new one dropping
this patch, which will go through the clock tree.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/a7687bdb/attachment-0001.sig>
