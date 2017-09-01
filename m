From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Sep 2017 15:55:09 -0700
Subject: [PATCH v5 1/7] clk: at91: clk-generated: remove useless divisor
 loop
In-Reply-To: <fe26a470c87e39b5e07fbada6ce7020a6b65429b.1502346448.git-series.quentin.schulz@free-electrons.com>
References: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
 <fe26a470c87e39b5e07fbada6ce7020a6b65429b.1502346448.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20170901225509.GC21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10, Quentin Schulz wrote:
> The driver requests the current clk rate of each of its parent clocks to
> decide whether a clock rate is suitable or not. It does not request
> determine_rate from a parent clock which could request a rate change in
> parent clock (i.e. there is no parent rate propagation).
> 
> We know the rate we want (passed along req argument of the function) and
> the parent clock rate, thus we know the closest rounded divisor, we
> don't need to iterate over the available divisors to find the best one
> for a given clock.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
