From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Jun 2017 15:08:58 -0700
Subject: [PATCH] clk: bcm: don't mark iproc_pll_clk_setup as __init
In-Reply-To: <20170621215851.4052618-1-arnd@arndb.de>
References: <20170621215851.4052618-1-arnd@arndb.de>
Message-ID: <20170621220858.GJ4493@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21, Arnd Bergmann wrote:
> This function is now called from the probe() function of a
> platform driver, which may be called later than __init,
> which triggers a lot of warnings like:
> 
> WARNING: drivers/clk/built-in.o(.text+0x1a41c): Section mismatch in reference from the function sr_lcpll1_clk_init() to the function .init.text:iproc_pll_clk_setup()
> 
> This removes the annotation on iproc_pll_clk_setup to address
> all those warnings.
> 
> Fixes: 654cdd3229cd ("clk: bcm: Add clocks for Stingray SOC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks. I already have the fix in my queue though.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
