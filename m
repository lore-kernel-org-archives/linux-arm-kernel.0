From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 17 Sep 2010 12:15:17 +0200
Subject: [PATCH] ARM: fix a kfree address in clkdev code
In-Reply-To: <Pine.LNX.4.64.1009171120130.4988@axis700.grange>
References: <Pine.LNX.4.64.1009171120130.4988@axis700.grange>
Message-ID: <20100917101517.GC13002@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:24 Fri 17 Sep     , Guennadi Liakhovetski wrote:
> kfree() in clkdev_drop() function should actually be called with an address of
> a struct clk_lookup_alloc object, and not struct clk_lookup, as presently done.
> This just happens to work, because "struct clk_lookup cl" is the first
> member in struct clk_lookup_alloc.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Jean-Christophe, as I said, this is a purely academic patch, I'll send a 
> similar one to sh, but if your consolidation patch is accepted for 2.6.37, 
I follow the sh too :)
> maybe you can just adjust yours to get to the desired result. If, however, 
> these two patches are merged into 2.6.36, you'll need slightly larger 
> adjustments to your patch, in both cases trivial though.
ok I'll update if need it

Best Regards,
J.
