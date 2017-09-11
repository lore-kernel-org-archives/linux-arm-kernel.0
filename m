From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 11 Sep 2017 04:51:28 +0000
Subject: [PATCH] clk: bulk: call of_clk_get() when id is NULL
In-Reply-To: <20170831052630.GU21656@codeaurora.org>
References: <1502243442-28055-1-git-send-email-shawnguo@kernel.org>
 <20170809173318.GD2146@codeaurora.org> <20170813141851.GD31819@dragon>
 <AM3PR04MB3064504A935B4AA0CBEE962809C0@AM3PR04MB306.eurprd04.prod.outlook.com>
 <20170831052630.GU21656@codeaurora.org>
Message-ID: <AM3PR04MB3065706564AA81D56E03E4580680@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at codeaurora.org]
> Sent: Thursday, August 31, 2017 1:27 PM
> To: A.s. Dong
> Cc: Shawn Guo; Michael Turquette; linux-clk at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Shawn Guo
> Subject: Re: [PATCH] clk: bulk: call of_clk_get() when id is NULL
> 
> On 08/30, A.s. Dong wrote:

[...]

> > Flags may be better used for extending per clk feature support in the
> future.
> >
> > IMHO how about implement a of_clk_bulk_get() to handle this issue as
> > we already have a of_clk_get?
> > e.g.
> >
> > int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
> >                               struct clk_bulk_data *clks) {
> >         for (i = 0; i < num_clks; i++) {
> >                 clks[i].clk = of_clk_get(dev, clks[i].id); ...
> >
> > }
> >
> > Then it's less intrusive.
> >
> 
> This looks ok too. Go ahead and send this version instead.
> 

I did not see you send a update version.
If you will not do it, would you mind me to help send it with a Reported-by: tag from you?

Regards
Dong Aisheng

> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
