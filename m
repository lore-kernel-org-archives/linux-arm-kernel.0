From: tony@atomide.com (Tony Lindgren)
Date: Fri, 8 Oct 2010 10:36:15 -0700
Subject: [PATCH v4] ARM: Fix sparse warnings due to variables conflicts.
In-Reply-To: <4CAF014D.7000909@ti.com>
References: <1286517186-29934-1-git-send-email-sourav.poddar@ti.com>
	<4CAF014D.7000909@ti.com>
Message-ID: <20101008173615.GJ7558@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [101008 04:24]:
> Poddar, Sourav had written, on 10/08/2010 12:53 AM, the following:
> >Fix the sparse warnings generated due to conflicts in variables used in readl/writel.
> >
> >
> >drivers/net/smc91x.c:312:8: warning: symbol '__v' shadows an earlier one
> >drivers/net/smc91x.c:312:8: originally declared here
> >
> >With this change, about 200 sparse warnings are fixed.
> The commit message could be a little more detailed.
> see http://marc.info/?l=linux-omap&m=128648102511076&w=2
> 
> also should $subject say ARM: io: fix namespace conflict
> to better reflect the fix? sparse warnings are just an indication IMHO

BTW, also dropping the "OMAP: Convert write/read functions to raw read/write".

That patch does not compute, and also ends up leaving files with
__raw_readw followed by writew..

Regards,

Tony
