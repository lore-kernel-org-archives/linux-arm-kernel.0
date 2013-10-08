From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 Oct 2013 09:47:35 -0700
Subject: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
In-Reply-To: <5253BFB3.9040807@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <20131008054034.7445.48080@quantum> <5253BFB3.9040807@ti.com>
Message-ID: <20131008164735.GC7773@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [131008 01:26]:
> On 10/08/2013 08:40 AM, Mike Turquette wrote:
> 
> >3) Same concern as above but for the DT clkdev alias stuff. I guess
> >you'll need to make all of the dependent drivers play nice with DT. Do
> >you plan to remove it within a reasonable timeframe? It would be a nice
> >reduction in LoC and more importantly it would mean that drivers were
> >using clkdev in a more-correct fashion.
> 
> This is probably harder, I think Tony is better to comment here, but
> my idea is that in the worst case we can just break non-conforming
> drivers by dropping the clkdev tables if nothing else helps. :) Most
> of the tables are currently needed by hwmod, and there are already
> patches around for adding DT clock support for hwmods, so once these
> go in, we can at least reduce the table sizes considerably already.

It should be possible to remove these as we go as things become DT only.
Probably the biggest blocker right now is making omap3 DT only.

But let's not start breaking things intentionally!

Tony
