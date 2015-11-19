From: rklein@nvidia.com (Rhyland Klein)
Date: Thu, 19 Nov 2015 17:40:07 -0500
Subject: [PATCH] clk: tegra: move _calc_dynamic_ram_rate out of #ifdef
In-Reply-To: <4290741.p1jMzEOUEU@wuerfel>
References: <4290741.p1jMzEOUEU@wuerfel>
Message-ID: <564E4FC7.9040302@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2015 5:32 PM, Arnd Bergmann wrote:
> _calc_dynamic_ram_rate is defined inside an #ifdef but called
> later in the same file outside of that #ifdef, which can cause a
> build error:
> 
> drivers/clk/tegra/clk-pll.c: In function '_tegra_clk_register_pll':
> drivers/clk/tegra/clk-pll.c:1541:29: error: '_calc_dynamic_ramp_rate' undeclared (first use in this function)
> 
> This moves both _calc_dynamic_ram_rate and _pll_fixed_mdiv in
> front of the #ifdef to make all configurations compile again.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 44c8b9fa432c ("clk: tegra: pll: Fix _pll_ramp_calc_pll logic and _calc_dynamic_ramp_rate")
> ----
> The patch that caused it appears to be older, but I only ran into
> the randconfig bug today for the first time. Apparently the commit
> is only in linux-next at the moment, not in 4.4-rc1
> 

Acked-by: Rhyland Klein <rklein@nvidia.com>

-rhyland

-- 
nvpublic
