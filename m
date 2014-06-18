From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Jun 2014 14:26:46 +0200
Subject: [PATCH v2 17/20] ARM: sunxi: Introduce Allwinner A23 support
In-Reply-To: <1403016777-15121-18-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-18-git-send-email-wens@csie.org>
Message-ID: <20140618122646.GS19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 10:52:54PM +0800, Chen-Yu Tsai wrote:
> The Allwinner A23 is a dual-core Cortex-A7-based SoC. It re-uses most of
> the IPs found in previous SoCs, notably the A31.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/mach-sunxi/Kconfig |  8 ++++++++
>  arch/arm/mach-sunxi/sunxi.c | 10 ++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 0fbd4f1..6434e3b 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -35,4 +35,12 @@ config MACH_SUN7I
>  	select HAVE_ARM_ARCH_TIMER
>  	select SUN5I_HSTIMER
>  
> +config MACH_SUN8I
> +	bool "Allwinner A23 (sun8i) SoCs support"
> +	default ARCH_SUNXI
> +	select ARCH_HAS_RESET_CONTROLLER
> +	select ARM_GIC
> +	select MFD_SUN6I_PRCM
> +	select RESET_CONTROLLER
> +
>  endif
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 3f9587b..962ff30 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -53,3 +53,13 @@ static const char * const sun7i_board_dt_compat[] = {
>  DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family")
>  	.dt_compat	= sun7i_board_dt_compat,
>  MACHINE_END
> +
> +static const char * const sun8i_board_dt_compat[] = {
> +	"allwinner,sun8i-a23",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i (A23) Family")
> +	.init_time	= sun6i_timer_init,

I haven't seen anything in your code that needed to use this
function. Am I missing something?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/9b3480ee/attachment.sig>
