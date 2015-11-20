From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Nov 2015 10:59:32 -0800
Subject: [PATCH] clk: st: avoid uninitialized variable use
In-Reply-To: <3719029.IbREgssWiU@wuerfel>
References: <3719029.IbREgssWiU@wuerfel>
Message-ID: <20151120185932.GW32672@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12, Arnd Bergmann wrote:
> quadfs_pll_fs660c32_round_rate prints a few structure members
> that are never initialized, and also doesn't print the only one
> it cares about. We get a gcc warning about the ones that
> are printed:
> 
> clk/st/clkgen-fsyn.c:560:93: warning: 'params.sdiv' may be used uninitialized in this function
> clk/st/clkgen-fsyn.c:560:93: warning: 'params.mdiv' may be used uninitialized in this function
> clk/st/clkgen-fsyn.c:560:93: warning: 'params.pe' may be used uninitialized in this function
> clk/st/clkgen-fsyn.c:560:93: warning: 'params.nsdiv' may be used uninitialized in this function
> 
> This changes the code to no longer print uninitialized data, and
> for good measure it also prints the ndiv member that is being
> set.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5f7aa9071e93 ("clk: st: Support for QUADFS inside ClockGenB/C/D/E/F")
> 
> diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
> index 576cd0354d48..ccb324d97160 100644
> --- a/drivers/clk/st/clkgen-fsyn.c

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
