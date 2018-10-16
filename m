From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 16 Oct 2018 14:49:55 -0700
Subject: [PATCH resend] clk: at91: Fix division by zero in PLL
 recalc_rate()
In-Reply-To: <trinity-9c3a7e1f-73af-4a1a-b82c-cafd5aefa5e4-1539179694006@3c-app-gmx-bs12>
References: <trinity-9c3a7e1f-73af-4a1a-b82c-cafd5aefa5e4-1539179694006@3c-app-gmx-bs12>
Message-ID: <153972659502.5275.13561032120086827267@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ronald Wahl (2018-10-10 06:54:54)
> Commit a982e45dc150 ("clk: at91: PLL recalc_rate() now using cached MUL
> and DIV values") removed a check that prevents a division by zero. This
> now causes a stacktrace when booting the kernel on a at91 platform if
> the PLL DIV register contains zero. This commit reintroduces this check.
> 
> Fixes: a982e45dc150 ("clk: at91: PLL recalc_rate() now using cached...")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ronald Wahl <rwahl@gmx.de>
> ---

Applied to clk-next
