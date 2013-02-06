From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 6 Feb 2013 11:00:14 +0100
Subject: [PATCH V2] clk: Add composite clock type
In-Reply-To: <511227F6.3050601@nvidia.com>
References: <5111C604.8070104@nvidia.com><20130206.081048.71241785637713947.hdoyu@nvidia.com><511227F6.3050601@nvidia.com>
Message-ID: <20130206.120014.87075843729177552.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prashant Gaikwad <pgaikwad@nvidia.com> wrote @ Wed, 6 Feb 2013 10:52:54 +0100:

> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index f0ac818..bb5d36a 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -346,6 +346,8 @@ struct clk_composite {
> >          const struct clk_ops    *mux_ops;
> >          const struct clk_ops    *div_ops;
> >          const struct clk_ops    *gate_ops;
> > +
> > +       const struct clk_ops    ops;
> >   };
> >   
> >   struct clk *clk_register_composite(struct device *dev, const char *name,
> 
> This will work, but there is no harm in allocating dynamically. What is 
> preferred?

If we've already know that this "ops" is necessary per "struct
clk_composite" in advance, there's no point to allocate
"clk_composite" and "ops" separately.
