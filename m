From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 28 Jun 2017 16:04:17 +0100
Subject: [PATCH] clk: scpi: error when clock fails to register
In-Reply-To: <20170628135345.9337-1-jbrunet@baylibre.com>
References: <20170628135345.9337-1-jbrunet@baylibre.com>
Message-ID: <c7123c06-b75b-5209-5817-230c63c1bf49@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/06/17 14:53, Jerome Brunet wrote:
> Current implementation of scpi_clk_add just print a warning when clock
> fails to register but then keep going as if nothing happened. The
> provider is then registered with bogus data.
> 
> This may latter lead to an Oops in __clk_create_clk when
> hlist_add_head(&clk->clks_node, &hw->core->clks) is called.
> 

What's the path of this call ? I see one in devm_clk_hw_register
but that's one which failed.

Also one of the reason for keeping it continuing is, if firmware fails
on some non-critical clock, that's fine rather than punishing the entire
set of clocks and may even fail the boot.

-- 
Regards,
Sudeep
