From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 2 Jan 2018 17:47:01 -0800
Subject: [PATCH v7 3/5] clk: aspeed: Add platform driver and register PLLs
In-Reply-To: <20171222024522.10362-4-joel@jms.id.au>
References: <20171222024522.10362-1-joel@jms.id.au>
 <20171222024522.10362-4-joel@jms.id.au>
Message-ID: <20180103014701.GR7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22, Joel Stanley wrote:
> This registers a platform driver to set up all of the non-core clocks.
> 
> The clocks that have configurable rates are now registered.
> 
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> --
> v6:
>  - Add Andrew's reviewed-by
> v5:
>  - Remove eclk configuration. We do not have enough information to
>  correctly implement the mux and divisor, so it will have to be
>  implemented in the future
> v4:
>  - Add eclk div table to fix ast2500 calculation
>  - Add defines to document the BIT() macros
>  - Pass dev where we can when registering clocks
>  - Check for errors when registering clk_hws
> v3:
>  - Fix bclk and eclk calculation
>  - Separate out ast2400 and ast25000 for pll calculation
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
