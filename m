From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 7 Jul 2016 09:54:03 +0000
Subject: [PATCH v2] clkdev: add devm_of_clk_get()
In-Reply-To: <146785219147.73491.2827268663638530377@resonance>
References: <87wpl2yyuw.wl%kuninori.morimoto.gx@renesas.com>
 <146785219147.73491.2827268663638530377@resonance>
Message-ID: <87ziptixv7.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Michael

> > +struct clk *devm_of_clk_get(struct device *dev,
> > +                           struct device_node *np, int index)
> 
> Any reason not to use devm_clk_get? Why do we need this helper?

Because of_clk_get() can parse "clocks", "#clock-cells" on DT.
And it can manage of_clk_provider.
But devm_clk_get() can't ?
