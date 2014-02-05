From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 5 Feb 2014 07:41:28 -0800
Subject: [PATCH] ARM: zynq: Move of_clk_init from clock driver
In-Reply-To: <572af6e4eaaaa1c74ea62364f8fa7ac5834cc754.1391612175.git.michal.simek@xilinx.com>
References: <572af6e4eaaaa1c74ea62364f8fa7ac5834cc754.1391612175.git.michal.simek@xilinx.com>
Message-ID: <4e03e3ec-2fc7-40fc-a2cc-4a6c64379559@CO1EHSMHS025.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 03:56:37PM +0100, Michal Simek wrote:
> Move of_clk_init() from clock driver to enable
> options not to use zynq clock driver.
> Use for example fixed clock setting.
What is the use-case? Zynq w/o this driver makes no sense, IMHO. And
even if you wanna fake clocks, why would this driver prevent it? Just
replace all the input clocks with different ones and don't care about
what this driver does?

> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Based on http://www.spinics.net/lists/arm-kernel/msg298287.html
> series
> 
> ---
>  arch/arm/mach-zynq/common.c | 1 +
>  drivers/clk/zynq/clkc.c     | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 93ea19b..8df35f3 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -68,6 +68,7 @@ static void __init zynq_timer_init(void)
>  	zynq_early_slcr_init();
> 
>  	zynq_clock_init();
> +	of_clk_init(NULL);
Now you have two clock init functions...

	S?ren
