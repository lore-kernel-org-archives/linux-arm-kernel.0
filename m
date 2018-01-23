From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 23 Jan 2018 14:10:40 +0100
Subject: [PATCH V3 01/10] clk: clk-divider: add CLK_DIVIDER_ZERO_GATE
 clk support
In-Reply-To: <20180123122102.GA16865@b29396-OptiPlex-7040>
References: <1516367470-24340-1-git-send-email-aisheng.dong@nxp.com>
 <1516367470-24340-2-git-send-email-aisheng.dong@nxp.com>
 <1516705426.7870.45.camel@baylibre.com>
 <20180123122102.GA16865@b29396-OptiPlex-7040>
Message-ID: <1516713040.7870.47.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-01-23 at 20:21 +0800, Dong Aisheng wrote:
> > In a more general way, I'd love to see a feature such as CLK_DIVIDER_ZERO_GATE
> > added to the divider but I'm bit concerned of all the quirks we are slowly
> > adding to the generic divider. It seems we are all trying re-use the algorithm
> > of clk_divider_bestdiv() with different 'val-to-div' transfer function. Not too
> > sure what the best solution could be though.
> > 
> 
> IMHO CLK_DIVIDER_ZERO_GATE only indicates the 0 val means clk gate.
> It does not assume divider types. That looks like a generic way and is exactly
> what this patch intends to do. Does it make sense?

It makes sense. That last comment was not about your patch specifically but
about the growing entropy in clk-divider.c in general.
