From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 13 Feb 2015 13:06:13 +0100
Subject: [PATCH 02/13] clk: mediatek: Add initial common clock support
 for Mediatek SoCs.
In-Reply-To: <CAAFQd5APGYRSQzriBBB=-vDyMhQZe7k9zDPgxLwzcV2C6f9DJQ@mail.gmail.com>
References: <1423478845-2835-1-git-send-email-s.hauer@pengutronix.de>
 <1423478845-2835-3-git-send-email-s.hauer@pengutronix.de>
 <CAAFQd5APGYRSQzriBBB=-vDyMhQZe7k9zDPgxLwzcV2C6f9DJQ@mail.gmail.com>
Message-ID: <20150213120613.GZ12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Tomasz,

> > +static void mtk_cg_disable(struct clk_hw *hw)
> > +{
> > +       mtk_cg_set_bit(hw);
> > +}
> > +
> > +static int mtk_cg_enable_inv(struct clk_hw *hw)
> > +{
> > +       mtk_cg_set_bit(hw);
> > +
> > +       return 0;
> > +}
> > +
> > +static void mtk_cg_disable_inv(struct clk_hw *hw)
> > +{
> > +       mtk_cg_clr_bit(hw);
> > +}
> 
> Instead of duplicating the ops, couldn't you add a flag or something
> to mtk_clk_gate struct and then act appropriately in the ops? Also,
> see below.

I prefer duplicating the ops. It makes the functions simpler without
ifs.

> > diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
> > new file mode 100644
> > index 0000000..a44dcbf
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-gate.h
> > @@ -0,0 +1,49 @@
> > +/*
> > + * Copyright (c) 2014 MediaTek Inc.
> > + * Author: James Liao <jamesjj.liao@mediatek.com>
> 
> Might not be necessary, but maybe the other people (all or some of
> them) from signed-off-by should be added to this and other copyright
> statements?

I rather do not want to update these copyrights frequently. Otherwise we
would see a lot of patches with an extra hunk changing the copyrights.
I'm glad we left that behind and look at the git history instead.
The above is the original author. I don't want to remove him, but I also
do not want to add every other person who touched that file.

The other stuff will be fixed in the next round. Thanks for reviewing.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
