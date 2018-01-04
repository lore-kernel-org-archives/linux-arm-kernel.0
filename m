From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 4 Jan 2018 16:40:56 +0530
Subject: [PATCH v4 2/7] ARM: davinci: don't use static clk_lookup
In-Reply-To: <1514763588-31560-3-git-send-email-david@lechnology.com>
References: <1514763588-31560-1-git-send-email-david@lechnology.com>
 <1514763588-31560-3-git-send-email-david@lechnology.com>
Message-ID: <17d6af61-a6db-9dc6-6fde-e9ff44e57389@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Monday 01 January 2018 05:09 AM, David Lechner wrote:
> In preparation of moving to the common clock framework, usage of static
> struct clk_lookup is removed. The common clock framework uses an opaque
> struct clk, so we won't be able to use static tables as was previously
> done.
> 
> davinci_clk_init() is changed to init a single clock instead of a table
> and an individual clk_register_clkdev() is added for each clock.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Is there a need for this considering in 6/7 you end up modifying quite a
bit of this patch again?

Thanks,
Sekhar
