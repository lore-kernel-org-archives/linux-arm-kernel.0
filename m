From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 12 Jul 2010 10:19:13 +0800
Subject: [PATCH 1/2] Add a common struct clk
In-Reply-To: <AANLkTilitnz8eiBclky74FTOeKua3LjM3cbRdfwzkpnW@mail.gmail.com>
References: <1277098513.947165.104554431018.0.gpush@pororo>
	<1277098513.947633.945838133095.1.gpush@pororo>
	<AANLkTilitnz8eiBclky74FTOeKua3LjM3cbRdfwzkpnW@mail.gmail.com>
Message-ID: <1278901153.9235.6.camel@pororo.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi MyungJoo,

> > +int clk_enable(struct clk *clk)
> > +{
> > +       int ret = 0;
> > +
> > +       if (!clk->ops->enable)
> > +               return 0;
> 
> Wouldn't it be better (safer?) to check "clk" and "clk->ops" before
> accessing clk->ops->enable?
> For example,
> 
>         if (IS_ERR_OR_NULL(clk))
>                 return -EINVAL;
> 
>         if (!clk->ops || !clk->ops->enable)
>                 return 0;
> 
> Or, do you think it'd be better not to check and save some time?
> 
> Anyway, if we intend to check the input, the patch for the patch
> including kernel/clk.c would be...

I think that we should leave it as-is; although it may be 'safer', it
may mean more subtle bugs can arise because we've been handed an invalid
clock pointer.

I'd rather the code oops on first usage so that the developer realises
that something is broken, rather than fail with an error code.

BTW - nice work on the samsung implementation, I will check it out soon.

Cheers,


Jeremy
