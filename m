From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Nov 2014 15:29:03 +0100
Subject: [PATCH resend 2/4] ARM: dts: sunxi: unify APB1 clock
In-Reply-To: <7205141.lqhF7e2PeF@wuerfel>
References: <1415245232-20585-1-git-send-email-wens@csie.org>
 <1415245232-20585-3-git-send-email-wens@csie.org>
 <7h1toxr0ku.fsf@deeprootsystems.com> <7205141.lqhF7e2PeF@wuerfel>
Message-ID: <20141121142903.GD4752@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 12:57:02PM +0100, Arnd Bergmann wrote:
> On Thursday 20 November 2014 14:04:01 Kevin Hilman wrote:
> > Chen-Yu Tsai <wens@csie.org> writes:
> > 
> > > From: Emilio L?pez <emilio@elopez.com.ar>
> > >
> > > With the new factors infrastructure in place, we can unify apb1 and
> > > apb1_mux as a single clock now.
> > >
> > > Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> > > [wens at csie.org: Change apb1 node label to "apb1"; reword commit title]
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > 
> > Boot breakage in arm-soc/for-next on sun4i-a10-cubieboard and
> > sun7i-a20-cubieboard2[1] was bisected down to this patch[1].
> > 
> > Reverting $SUBJECT on top of arm-soc gets things booting again.
> > 
> 
> As this looks like it was intended as a cleanup without functional
> changes, I would go ahead and revert it in next/dt.
> 
> Any objections?

Yeah, you'd break linux-next as well doing so, as the clock driver now
requires this from the DT.

I can merge it through the clock tree though if you prefer it that
way.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/47207e47/attachment.sig>
