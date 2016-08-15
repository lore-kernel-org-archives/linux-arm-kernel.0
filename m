From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 15 Aug 2016 11:16:04 -0700
Subject: [PATCH v9 06/10] clk: mediatek: Add MT2701 clock support
In-Reply-To: <1471230034.8551.22.camel@mtksdaap41>
References: <1466581229-2342-1-git-send-email-erin.lo@mediatek.com>
 <1466581229-2342-7-git-send-email-erin.lo@mediatek.com>
 <20160813004438.GC361@codeaurora.org>
 <1471230034.8551.22.camel@mtksdaap41>
Message-ID: <20160815181604.GU361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15, James Liao wrote:
> On Fri, 2016-08-12 at 17:44 -0700, Stephen Boyd wrote:
> > On 06/22, Erin Lo wrote:
> > > +
> > > +static void mtk_bdpsys_init(struct device_node *node)
> > > +{
> > > +	struct clk_onecell_data *clk_data;
> > > +	int r;
> > > +
> > > +	clk_data = mtk_alloc_clk_data(CLK_BDP_NR);
> > > +
> > > +	mtk_clk_register_gates(node, bdp_clks, ARRAY_SIZE(bdp_clks),
> > > +						clk_data);
> > > +
> > > +	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> > 
> > Is it possible to move to of_clk_add_hw_provider()? It can be
> > done later if that would mean changing all
> > mtk_clk_register_gates() users.
> 
> I would like to keep current implementation due to test/integration
> effort. I prefer to apply clk_hw related APIs on new clk drivers instead
> of modify existing drivers.
> 

Sure, no problem.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
