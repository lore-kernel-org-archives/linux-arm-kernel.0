From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 28 Apr 2010 08:08:26 +0200
Subject: [PATCH] arm/mach-msm: Add CONFIG conditional for board-trout
In-Reply-To: <201004290241.23068.PeterHuewe@gmx.de>
References: <201004290241.23068.PeterHuewe@gmx.de>
Message-ID: <20100428060825.GE3721@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2010-04-29 02:41:22, Peter Huewe wrote:
> From: Peter Huewe <peterhuewe@gmx.de>
> 
> This patch adds a conditional for CONFIG_MSM_DEBUG_UART to prevent a
> build failure[1], this is done the same way as for every board in mach-msm.
> 
> References:
> [1] http://kisskb.ellerman.id.au/kisskb/buildresult/2448102/
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>

Ack.


> ---
> KernelVersion: linux-next-20100429
> 
>  arch/arm/mach-msm/board-trout.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
> index 9793ff4..b88aec2 100644
> --- a/arch/arm/mach-msm/board-trout.c
> +++ b/arch/arm/mach-msm/board-trout.c
> @@ -82,8 +82,10 @@ static void __init trout_map_io(void)
>  }
>  
>  MACHINE_START(TROUT, "HTC Dream")
> +#ifdef CONFIG_MSM_DEBUG_UART
>  	.phys_io	= MSM_DEBUG_UART_PHYS,
>  	.io_pg_offst	= ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
> +#endif
>  	.boot_params	= 0x10000100,
>  	.fixup		= trout_fixup,
>  	.map_io		= trout_map_io,

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
