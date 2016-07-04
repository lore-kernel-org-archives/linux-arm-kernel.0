From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 4 Jul 2016 08:04:22 +0000
Subject: [PATCH] clkdev: add devm_of_clk_get()
In-Reply-To: <7596144.XSxKMDxLKp@wuerfel>
References: <87y45iz0cs.wl%kuninori.morimoto.gx@renesas.com>
 <7596144.XSxKMDxLKp@wuerfel>
Message-ID: <87oa6dzvhf.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

> > @@ -501,6 +503,11 @@ static inline struct clk *of_clk_get(struct device_node *np, int index)
> >  {
> >         return ERR_PTR(-ENOENT);
> >  }
> > +struct clk *devm_of_clk_get(struct device *dev,
> > +                           struct device_node *np, int index)
> > +{
> > +       return ERR_PTR(-ENOENT);
> > +}
> >  static inline struct clk *of_clk_get_by_name(struct device_node *np,
> >                                              const char *name)
> >  {
> > -- 
> > 
> 
> This is missing "static inline" as found by the bot.

Thanks.
I have already posted v2 patch.
