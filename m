From: mturquette@ti.com (Mike Turquette)
Date: Tue, 12 Jun 2012 12:07:28 -0700
Subject: [PATCH 2/2] clk: Allow late cache allocation for clk->parents
In-Reply-To: <1338973891-28719-3-git-send-email-rnayak@ti.com>
References: <1338973891-28719-1-git-send-email-rnayak@ti.com>
 <1338973891-28719-3-git-send-email-rnayak@ti.com>
Message-ID: <20120612190728.GI19410@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120606-14:41, Rajendra Nayak wrote:
> Parent clocks for muxes are cached in clk->parents to
> avoid frequent lookups, however the cache allocation happens
> only during clock registeration and later clk_set_parent()
> assumes a cache space available and allocated.
> 
> This is not entirely true for platforms which do early clock
> registerations wherein the cache allocation using kzalloc
> could fail during clock registeration.
> 
> Allow cache allocation to happen later as part of clk_set_parent()
> to help such cases and avoid crashes assuming a cache being
> available.
> 
> While here also replace existing kmalloc() with kzalloc()
> in the file.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

I've taken this patch into clk-next for testing.

Thanks,
Mike
