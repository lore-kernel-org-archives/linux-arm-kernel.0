From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 29 Jun 2017 10:03:07 +0100
Subject: [PATCH] clk: scpi: error when clock fails to register
In-Reply-To: <20170628135345.9337-1-jbrunet@baylibre.com>
References: <20170628135345.9337-1-jbrunet@baylibre.com>
Message-ID: <7eb946bf-6958-daf9-fd75-f1e23c1f2154@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome,

Thanks for the fix.

On 28/06/17 14:53, Jerome Brunet wrote:
> Current implementation of scpi_clk_add just print a warning when clock
> fails to register but then keep going as if nothing happened. The
> provider is then registered with bogus data.
> 
> This may latter lead to an Oops in __clk_create_clk when
> hlist_add_head(&clk->clks_node, &hw->core->clks) is called.
> 
> This patch fixes the issue and errors if a clock fails to register.
> 
> Fixes: cd52c2a4b5c4 ("clk: add support for clocks provided by SCP(System Control Processor)")

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
