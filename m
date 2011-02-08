From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 8 Feb 2011 09:40:32 +0800
Subject: [RFC,PATCH 1/3] Add a common struct clk
In-Reply-To: <AANLkTi=5FNvWKQf6cRt4wNejC7u4XKsqLp9Pwc2Z45_3@mail.gmail.com>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<1297058877.800158.458894385837.1.gpush@pororo>
	<AANLkTi=5FNvWKQf6cRt4wNejC7u4XKsqLp9Pwc2Z45_3@mail.gmail.com>
Message-ID: <201102080940.33251.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

> > +int clk_enable(struct clk *clk)
> > +{
> > +       int ret = 0;
> > +
> > +       if (!clk->ops->enable)
> > +               return 0;
> > +
> > +       spin_lock(&clk->enable_lock);
> 
> spin_lock_irqsave/spin_unlock_irqrestore.  This could get called with
> irqs on or off.

Ah, I had planned to change this but (obviously) didn't get to it. Thanks for 
the reminder, I'll include this in the next revision.

Cheers,


Jeremy
