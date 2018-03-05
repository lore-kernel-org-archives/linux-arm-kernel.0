From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 5 Mar 2018 09:41:28 +0100
Subject: [PATCH] ARM: mach-stm32: restore reboot capabilities
In-Reply-To: <20180227143607.5583-1-benjamin.gaignard@st.com>
References: <20180227143607.5583-1-benjamin.gaignard@st.com>
Message-ID: <e98c78a4-e5d3-1b90-7ca5-7ab191dc8b43@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin

On 02/27/2018 03:36 PM, Benjamin Gaignard wrote:
> To be able to reboot the platform we need to use armv7m_restart for STM32
> SoCs using ARMv7 cores.
> 
> Fixes: e0644101bd2f ("ARM: mach-stm32: prepare stm32 family to welcome armv7 architecture)
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> NOTE: This patch should be applied only on
> git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
> until this patch: https://lkml.org/lkml/2018/2/26/386
> find it way to mainline KBuild will complain about it.
> 
>   arch/arm/mach-stm32/board-dt.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
> index 06911ad60cea..011d57b488c2 100644
> --- a/arch/arm/mach-stm32/board-dt.c
> +++ b/arch/arm/mach-stm32/board-dt.c
> @@ -7,6 +7,9 @@
>   
>   #include <linux/kernel.h>
>   #include <asm/mach/arch.h>
> +#ifdef CONFIG_ARM_SINGLE_ARMV7M
> +#include <asm/v7m.h>
> +#endif
>   
>   static const char *const stm32_compat[] __initconst = {
>   	"st,stm32f429",
> @@ -20,4 +23,7 @@ static const char *const stm32_compat[] __initconst = {
>   
>   DT_MACHINE_START(STM32DT, "STM32 (Device Tree Support)")
>   	.dt_compat = stm32_compat,
> +#ifdef CONFIG_ARM_SINGLE_ARMV7M
> +	.restart = armv7m_restart,
> +#endif
>   MACHINE_END

Applied on stm32-next.

Thanks.
Alex
