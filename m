From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 31 Aug 2017 15:01:20 +0800
Subject: [PATCH] clk: bulk: call of_clk_get() when id is NULL
In-Reply-To: <AM3PR04MB3064504A935B4AA0CBEE962809C0@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1502243442-28055-1-git-send-email-shawnguo@kernel.org>
 <20170809173318.GD2146@codeaurora.org>
 <20170813141851.GD31819@dragon>
 <AM3PR04MB3064504A935B4AA0CBEE962809C0@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <20170831070118.GA3328@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 03:31:38PM +0000, A.s. Dong wrote:
> IMHO how about implement a of_clk_bulk_get() to handle this issue as we already
> have a of_clk_get?
> e.g.
> 
> int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
>                               struct clk_bulk_data *clks)
> {
>         for (i = 0; i < num_clks; i++) {
>                 clks[i].clk = of_clk_get(dev, clks[i].id);

The of_clk_get() takes clock index rather than name/id as the second
parameter.

Shawn

> ...
> 
> }
