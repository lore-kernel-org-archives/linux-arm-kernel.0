From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 8 Feb 2016 14:13:35 -0800
Subject: [PATCH] clk: socfpga: fix __init annotation
In-Reply-To: <1454942356-2783135-1-git-send-email-arnd@arndb.de>
References: <1454942356-2783135-1-git-send-email-arnd@arndb.de>
Message-ID: <20160208221335.GS4848@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08, Arnd Bergmann wrote:
> clang found a bug with the __socfpga_pll_init definition:
> 
> drivers/clk/socfpga/clk-pll-a10.c:77:15: error: '__section__' attribute only applies to functions and
>       global variables
> 
> This moves the __init annotation to the right place so the function
> actually gets discarded.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
