From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 19 Apr 2011 08:32:40 +0800
Subject: [PATCH 05/10] clk: Add support for simple dividers
In-Reply-To: <4DACBDC6.2000500@codeaurora.org>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>
	<4DACBDC6.2000500@codeaurora.org>
Message-ID: <1303173160.2801.13.camel@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

> > +#define to_clk_divider(clk) (container_of(clk, struct clk_divider, clk))
> 
> Can you make this a static inline function with actual types? We get
> slightly more type safety that way.

Do we? The container_of macro requires that that it's first argument is
the same type as type->member, and returns a (type), so I don't see how
we're going to miss typing errors here.

However, with these macros, we need to use a parameter name that isn't
the same as the member name. Sascha: can you fix this? I'll update the
clk_fixed support.

Cheers,


Jeremy
