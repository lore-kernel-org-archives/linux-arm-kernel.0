From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 19:26:21 +0200
Subject: [PATCH v4 2/9] clk: sunxi-ng: Remove the use of rational
 computations
In-Reply-To: <CAGb2v65=xM3HpV05zt+q2vshX49MGkB88s7cfpwVYASodK11Nw@mail.gmail.com>
References: <cover.024e1b023e41efe548dc6a004f7a946408d5c9a2.1476196031.git-series.maxime.ripard@free-electrons.com>
 <50a2c9fe665c794dc97f524cacb63dc83d3efaa2.1476196031.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65=xM3HpV05zt+q2vshX49MGkB88s7cfpwVYASodK11Nw@mail.gmail.com>
Message-ID: <20161020172621.yzkhjwlfdxfmj3fy@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 10:30:36PM +0800, Chen-Yu Tsai wrote:
> On Tue, Oct 11, 2016 at 10:28 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > While the rational library works great, it doesn't really allow us to add
> > more constraints, like the minimum.
> >
> > Remove that in order to be able to deal with the constraints we'll need.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/sunxi-ng/Kconfig    |  3 +--
> >  drivers/clk/sunxi-ng/ccu_nkm.c  | 31 +++++++++-----------
> >  drivers/clk/sunxi-ng/ccu_nkmp.c | 45 +++++++++++++---------------
> >  drivers/clk/sunxi-ng/ccu_nm.c   | 54 +++++++++++++++++++++++++---------
> >  4 files changed, 78 insertions(+), 55 deletions(-)
> >
> 
> [...]
> 
> > diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
> > index 9769dee99511..4b457d8cce11 100644
> > --- a/drivers/clk/sunxi-ng/ccu_nkmp.c
> > +++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
> > @@ -9,16 +9,15 @@
> >   */
> >
> >  #include <linux/clk-provider.h>
> > -#include <linux/rational.h>
> >
> >  #include "ccu_gate.h"
> >  #include "ccu_nkmp.h"
> >
> >  struct _ccu_nkmp {
> > -       unsigned long   n, max_n;
> > -       unsigned long   k, max_k;
> > -       unsigned long   m, max_m;
> > -       unsigned long   p, max_p;
> > +       unsigned long   n, min_n, max_n;
> > +       unsigned long   k, min_k, max_k;
> > +       unsigned long   m, min_m, max_m;
> > +       unsigned long   p, min_p, max_p;
> 
> Wrong patch? Otherwise,
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Indeed, fixed and applied.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161020/738a756b/attachment-0001.sig>
