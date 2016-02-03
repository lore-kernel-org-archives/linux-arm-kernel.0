From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 3 Feb 2016 20:29:13 +0100
Subject: [PATCH 5/5] clk: sunxi: Remove clk_register_clkdev calls
In-Reply-To: <20160202112604.447baec98bf89a79542fd240@free.fr>
References: <1454402834-6385-1-git-send-email-maxime.ripard@free-electrons.com>
 <1454402834-6385-6-git-send-email-maxime.ripard@free-electrons.com>
 <20160202112604.447baec98bf89a79542fd240@free.fr>
Message-ID: <20160203192913.GA3327@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 11:26:04AM +0100, Jean-Francois Moine wrote:
> On Tue,  2 Feb 2016 09:47:14 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
> > index 578bff0dd251..b38d71cec74c 100644
> > --- a/drivers/clk/sunxi/clk-mod0.c
> > +++ b/drivers/clk/sunxi/clk-mod0.c
> > @@ -15,6 +15,7 @@
> >   */
> >  
> >  #include <linux/clk.h>
> > +#include <linux/clkdev.h>
> 
> Why?

Because this driver uses __clk_get, that it was previously included in
clk-factors.h and is not anymore, and that otherwise it won't compile,
obviously.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160203/bfdb411e/attachment.sig>
