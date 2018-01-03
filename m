From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 2 Jan 2018 17:47:03 -0800
Subject: [PATCH v7 4/5] clk: aspeed: Register gated clocks
In-Reply-To: <20171222024522.10362-5-joel@jms.id.au>
References: <20171222024522.10362-1-joel@jms.id.au>
 <20171222024522.10362-5-joel@jms.id.au>
Message-ID: <20180103014703.GS7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22, Joel Stanley wrote:
> The majority of the clocks in the system are gates paired with a reset
> controller that holds the IP in reset.
> 
> This borrows from clk_hw_register_gate, but registers two 'gates', one
> to control the clock enable register and the other to control the reset
> IP. This allows us to enforce the ordering:
> 
>  1. Place IP in reset
>  2. Enable clock
>  3. Delay
>  4. Release reset
> 
> There are some gates that do not have an associated reset; these are
> handled by using -1 as the index for the reset.
> 
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
