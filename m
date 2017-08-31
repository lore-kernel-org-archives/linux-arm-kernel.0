From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 31 Aug 2017 07:12:06 +0000
Subject: [PATCH] clk: bulk: call of_clk_get() when id is NULL
In-Reply-To: <20170831070118.GA3328@dragon>
References: <1502243442-28055-1-git-send-email-shawnguo@kernel.org>
 <20170809173318.GD2146@codeaurora.org> <20170813141851.GD31819@dragon>
 <AM3PR04MB3064504A935B4AA0CBEE962809C0@AM3PR04MB306.eurprd04.prod.outlook.com>
 <20170831070118.GA3328@dragon>
Message-ID: <AM3PR04MB306B791472D5AB2BF12730F809D0@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Thursday, August 31, 2017 3:01 PM
> To: A.s. Dong
> Cc: Stephen Boyd; Michael Turquette; linux-clk at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Shawn Guo
> Subject: Re: [PATCH] clk: bulk: call of_clk_get() when id is NULL
> 
> On Wed, Aug 30, 2017 at 03:31:38PM +0000, A.s. Dong wrote:
> > IMHO how about implement a of_clk_bulk_get() to handle this issue as
> > we already have a of_clk_get?
> > e.g.
> >
> > int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
> >                               struct clk_bulk_data *clks) {
> >         for (i = 0; i < num_clks; i++) {
> >                 clks[i].clk = of_clk_get(dev, clks[i].id);
> 
> The of_clk_get() takes clock index rather than name/id as the second
> parameter.
> 

You're right.
It's for only an idea demonstration, so sent too quick! :-)

Regards
Dong Aisheng

> Shawn
> 
> > ...
> >
> > }
