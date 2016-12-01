From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 1 Dec 2016 01:56:22 +0000
Subject: [PATCH v4] clkdev: add devm_of_clk_get()
In-Reply-To: <20161129212600.GH6095@codeaurora.org>
References: <87zikjw08i.wl%kuninori.morimoto.gx@renesas.com>
 <20161129212600.GH6095@codeaurora.org>
Message-ID: <87mvgg76rq.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Stephen

> > Current Linux has of_clk_get(), but doesn't have devm_of_clk_get().
> > This patch adds it. It is implemeted in clk-devres.c to share
> > devm_clk_release().
> 
> Please add an explanation of why we want this sort of API. The
> example you gave for audio sound card is useful. We're not going
> to remember 5 months from now why we did something, so we should
> put that here instead of digging through mailing list archives.

OK, will do

> > +struct clk *devm_of_clk_get(struct device *dev,
> > +			    struct device_node *np, int index)
> 
> Please call this devm_get_clk_from_child() instead. Also, replace
> the index argument with a string called con_id. Then call
> of_clk_get_by_name() instead of of_clk_get().

I guess we want to have _of_ on function name ?

  devm_get_clk_from_child() ?
  devm_of_get_clk_from_child ?

Best regards
---
Kuninori Morimoto
