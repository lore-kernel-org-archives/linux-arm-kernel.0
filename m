From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 31 Aug 2017 10:56:59 -0700
Subject: [PATCH] clk: sunxi: fix uninitialized access
In-Reply-To: <20170823143937.2176025-1-arnd@arndb.de>
References: <20170823143937.2176025-1-arnd@arndb.de>
Message-ID: <20170831175659.GE21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23, Arnd Bergmann wrote:
> gcc-8 reports an uninitialized variable access in a code path
> that we would see with incorrect DTB input:
> 
> drivers/clk/sunxi/clk-sun8i-bus-gates.c: In function 'sun8i_h3_bus_gates_init':
> drivers/clk/sunxi/clk-sun8i-bus-gates.c:85:27: error: 'clk_parent' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This works around by skipping invalid input and printing a warning
> instead if it ever happens. The problem was apparently part of the
> initiali driver submission, but older compilers don't notice it.
> 
> Fixes: ab6e23a4e388 ("clk: sunxi: Add H3 clocks support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
