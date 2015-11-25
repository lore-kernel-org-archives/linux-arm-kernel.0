From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Nov 2015 14:07:28 -0800
Subject: [PATCH] clk: mmp: add linux/clk.h includes
In-Reply-To: <5338608.iS8N3pHg9B@wuerfel>
References: <5338608.iS8N3pHg9B@wuerfel>
Message-ID: <20151125220728.GG11298@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25, Arnd Bergmann wrote:
> The common clk implementation for MMP broke without anyone noticing
> when we stopped including linux/clk.h from the clk-provider header.
> 
> This did not show up in the defconfig builds because those use the
> legacy MMP clk drivers, and it did not show up in my randconfig tests
> either because I was testing with my mmp multiplatform series
> applied, which at some point gained the fixup.
> 
> This fixes the three broken files.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 61ae76563ec3 ("clk: Remove clk.h from clk-provider.h")
> 
> diff --git a/drivers/clk/mmp/clk-mmp2.c b/drivers/clk/mmp/clk-mmp2.c
> index 09d2832fbd78..71fd29348f28 100644
> --- a/drivers/clk/mmp/clk-mmp2.c

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
