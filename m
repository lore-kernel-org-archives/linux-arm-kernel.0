From: treding@nvidia.com (Thierry Reding)
Date: Fri, 20 Nov 2015 16:10:32 +0100
Subject: [PATCH] clk: tegra: move _calc_dynamic_ram_rate out of #ifdef
In-Reply-To: <4290741.p1jMzEOUEU@wuerfel>
References: <4290741.p1jMzEOUEU@wuerfel>
Message-ID: <20151120151031.GD3300@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 11:32:33PM +0100, Arnd Bergmann wrote:
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

Hmm... this looks familiar, I thought I had included an equivalent patch
in the clock tree. I'll go do some digging, but this looks exactly like
what I had done at the time.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151120/ef3499f5/attachment.sig>
