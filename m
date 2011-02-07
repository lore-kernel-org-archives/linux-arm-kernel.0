From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 7 Feb 2011 16:22:55 +0800
Subject: [RFC,PATCH 1/3] Add a common struct clk
In-Reply-To: <AANLkTim1S9zpebn3yj1fBZTtOkqj2FLwhYWBZ2HXJajR@mail.gmail.com>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<1297058877.800158.458894385837.1.gpush@pororo>
	<AANLkTim1S9zpebn3yj1fBZTtOkqj2FLwhYWBZ2HXJajR@mail.gmail.com>
Message-ID: <201102071622.56163.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dima,

> > +int clk_prepare(struct clk *clk)
> > +{
> > +       int ret = 0;
> > +
> > +       if (!clk->ops->prepare)
> > +               return 0;
> > +
> > +       mutex_lock(&clk->prepare_lock);
> > +       if (clk->prepare_count == 0)
> > +               ret = clk->ops->prepare(clk);
> > +
> > +       if (!ret)
> > +               clk->prepare_count++;
> > +       mutex_unlock(&clk->prepare_lock);
> > +
> > +       return 0;
> 
> return ret;

Good catch, thanks.


Jeremy
