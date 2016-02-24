From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 24 Feb 2016 13:25:33 -0800
Subject: [PATCH v6 4/7] clk: mediatek: Add MT2701 clock support
In-Reply-To: <1455527982.29688.8.camel@mtksdaap41>
References: <1454665050-37776-1-git-send-email-jamesjj.liao@mediatek.com>
 <1454665050-37776-5-git-send-email-jamesjj.liao@mediatek.com>
 <20160210200853.26445.15165@quark.deferred.io>
 <1455527982.29688.8.camel@mtksdaap41>
Message-ID: <20160224212533.2278.7597@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

Quoting James Liao (2016-02-15 01:19:42)
> Hi Mike,
> 
> On Wed, 2016-02-10 at 12:08 -0800, Michael Turquette wrote:
> > Quoting James Liao (2016-02-05 01:37:27)
> > > +CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt2701-topckgen", mtk_topckgen_init);
> > > +CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt2701-infracfg", mtk_infrasys_init);
> > > +CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt2701-pericfg", mtk_pericfg_init);
> > > +CLK_OF_DECLARE(mtk_mmsys, "mediatek,mt2701-mmsys", mtk_mmsys_init);
> > > +CLK_OF_DECLARE(mtk_imgsys, "mediatek,mt2701-imgsys", mtk_imgsys_init);
> > > +CLK_OF_DECLARE(mtk_vdecsys, "mediatek,mt2701-vdecsys", mtk_vdecsys_init);
> > > +CLK_OF_DECLARE(mtk_hifsys, "mediatek,mt2701-hifsys", mtk_hifsys_init);
> > > +CLK_OF_DECLARE(mtk_ethsys, "mediatek,mt2701-ethsys", mtk_ethsys_init);
> > > +CLK_OF_DECLARE(mtk_bdpsys, "mediatek,mt2701-bdpsys", mtk_bdpsys_init);
> > > +CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt2701-apmixedsys",
> > 
> > :-/
> > 
> > This is way too much CLK_OF_DECLARE and not enough Linux Driver Model.
> > 
> > I understand that some platforms really must initialize some clocks very
> > early, but can we please separate those into one table and call
> > CLK_OF_DECLARE on only that set, and then register the rest through a
> > platform_driver later on?
> 
> I know CLK_OF_DECLARE is much earlier than platform_driver, so it can
> ensure all drivers lookup their clocks successfully during
> platform_driver probe. Is there anything different to init these clock
> providers in CLK_OF_DECLARE and platform_driver?

This a common pattern we're seeing right now. Joachim did a nice job of
supporting early clocks with CLK_OF_DECLARE, and also using a proper
driver in his lpc18xx implementation:

http://marc.info/?l=devicetree&m=145618160610001

Regards,
Mike

> 
> 
> Best regards,
> 
> James
> 
> 
> 
