From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 12 May 2016 12:18:16 +0100
Subject: [PATCH] ARM: STi: Update machine _namestr to be more generic.
In-Reply-To: <1462984816-705-1-git-send-email-peter.griffin@linaro.org>
References: <1462984816-705-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160512111816.GA1433@dell.open.watershed.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 May 2016, Peter Griffin wrote:

> This string is used by dump_stack and as we now support
> more SoC's than just STiH415/6 it is misleading to have
> the current string in the stack trace.
> 
> This patch updates it to be more generic for the STi
> family of SoCs.
> 
> So instead of looking like this
> 
> [  271.672555] Hardware name: STiH415/416 SoC with Flattened Device Tree
> [  271.678998] [<c0310490>] (unwind_backtrace) from [<c030bb54>] (show_stack+0x10/0x14)
> [  271.686746] [<c030bb54>] (show_stack) from [<c058bc4c>] (dump_stack+0x98/0xac)
> [snip]
> 
> it now looks like this:
> 
> [    2.669879] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.6.0-rc3-00026-g38a1ce6-dirty #76
> [    2.677973] Hardware name: STi SoC with Flattened Device Tree
> [    2.683723] [<c0310490>] (unwind_backtrace) from [<c030bb54>] (show_stack+0x10/0x14)
> [    2.691472] [<c030bb54>] (show_stack) from [<c058bc0c>] (dump_stack+0x98/0xac)
> [snip]
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/mach-sti/board-dt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
> index ae10fb2..cfee0ef 100644
> --- a/arch/arm/mach-sti/board-dt.c
> +++ b/arch/arm/mach-sti/board-dt.c
> @@ -23,7 +23,7 @@ static const char *const stih41x_dt_match[] __initconst = {
>  	NULL
>  };
>  
> -DT_MACHINE_START(STM, "STiH415/416 SoC with Flattened Device Tree")
> +DT_MACHINE_START(STM, "STi SoC with Flattened Device Tree")
>  	.dt_compat	= stih41x_dt_match,
>  	.l2c_aux_val	= L2C_AUX_CTRL_SHARED_OVERRIDE |
>  			  L310_AUX_CTRL_DATA_PREFETCH |

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
