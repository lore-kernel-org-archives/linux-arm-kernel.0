From: sean.wang@mediatek.com (Sean Wang)
Date: Mon, 2 Apr 2018 11:04:15 +0800
Subject: [PATCH v2] staging: mt7621-eth: Fix sparse warning in ethtool.c
In-Reply-To: <87vada1owt.fsf@notabene.neil.brown.name>
References: <20180329095637.GA16778@kroah.com>
 <20180329124745.24694-1-cmc@babblebit.net>
 <87vada1owt.fsf@notabene.neil.brown.name>
Message-ID: <1522638255.18424.44.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-04-02 at 09:34 +1000, NeilBrown wrote:
> On Thu, Mar 29 2018, Chris Coffey wrote:
> 
> > This fixes the following sparse warning:
> >
> > drivers/staging/mt7621-eth/ethtool.c:213:6: warning: symbol
> > 'mtk_set_ethtool_ops' was not declared. Should it be static?
> >
> > Signed-off-by: Chris Coffey <cmc@babblebit.net>
> 
> Reviewed-by: NeilBrown <neil@brown.name>
> 
> Thanks,
> NeilBrown
> 
Hi, Neil

Forgive me I cannot find the cover letter in the original series in my
mailbox to make a reply, so I rudely made here just letting you know
something good to the growth of mt7621 support in upstream.

do you have maintained an out-of-tree branch to boot the mt7621 machine
with those staging patches?

If so, it would become a bit easier for me that maybe I could give a
hand for migrating these staging driver for mt7621 to mainline. I
thought mmc, pci, ethernet, gsw and hsdma all could probably reuse the
current mainline code.

	Sean
> 
> > ---
> > Changes in v2:
> >  - Per GregKH's feedback (thanks!), don't add unnecessary new .h file
> >  dependencies. This patch version reverts those changes and fixes the
> >  problem directly in ethtool.c (which is that it didn't include
> >  ethtool.h anywhere -- mtk_set_ethtool_ops is not static).
> >
> >  drivers/staging/mt7621-eth/ethtool.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/staging/mt7621-eth/ethtool.c b/drivers/staging/mt7621-eth/ethtool.c
> > index 38ba0c040a..5268c5ca09 100644
> > --- a/drivers/staging/mt7621-eth/ethtool.c
> > +++ b/drivers/staging/mt7621-eth/ethtool.c
> > @@ -13,6 +13,7 @@
> >   */
> >  
> >  #include "mtk_eth_soc.h"
> > +#include "ethtool.h"
> >  
> >  static const char mtk_gdma_str[][ETH_GSTRING_LEN] = {
> >  #define _FE(x...)	# x,
> > -- 
> > 2.11.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
