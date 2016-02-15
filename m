From: jamesjj.liao@mediatek.com (James Liao)
Date: Mon, 15 Feb 2016 17:19:42 +0800
Subject: [PATCH v6 4/7] clk: mediatek: Add MT2701 clock support
In-Reply-To: <20160210200853.26445.15165@quark.deferred.io>
References: <1454665050-37776-1-git-send-email-jamesjj.liao@mediatek.com>
 <1454665050-37776-5-git-send-email-jamesjj.liao@mediatek.com>
 <20160210200853.26445.15165@quark.deferred.io>
Message-ID: <1455527982.29688.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Wed, 2016-02-10 at 12:08 -0800, Michael Turquette wrote:
> Quoting James Liao (2016-02-05 01:37:27)
> > +CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt2701-topckgen", mtk_topckgen_init);
> > +CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt2701-infracfg", mtk_infrasys_init);
> > +CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt2701-pericfg", mtk_pericfg_init);
> > +CLK_OF_DECLARE(mtk_mmsys, "mediatek,mt2701-mmsys", mtk_mmsys_init);
> > +CLK_OF_DECLARE(mtk_imgsys, "mediatek,mt2701-imgsys", mtk_imgsys_init);
> > +CLK_OF_DECLARE(mtk_vdecsys, "mediatek,mt2701-vdecsys", mtk_vdecsys_init);
> > +CLK_OF_DECLARE(mtk_hifsys, "mediatek,mt2701-hifsys", mtk_hifsys_init);
> > +CLK_OF_DECLARE(mtk_ethsys, "mediatek,mt2701-ethsys", mtk_ethsys_init);
> > +CLK_OF_DECLARE(mtk_bdpsys, "mediatek,mt2701-bdpsys", mtk_bdpsys_init);
> > +CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt2701-apmixedsys",
> 
> :-/
> 
> This is way too much CLK_OF_DECLARE and not enough Linux Driver Model.
> 
> I understand that some platforms really must initialize some clocks very
> early, but can we please separate those into one table and call
> CLK_OF_DECLARE on only that set, and then register the rest through a
> platform_driver later on?

I know CLK_OF_DECLARE is much earlier than platform_driver, so it can
ensure all drivers lookup their clocks successfully during
platform_driver probe. Is there anything different to init these clock
providers in CLK_OF_DECLARE and platform_driver?


Best regards,

James
