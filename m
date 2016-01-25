From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 25 Jan 2016 16:43:50 +0100
Subject: [PATCH] ARM: mv78xx0: use "depends on" instead of "if" after
 prompt
In-Reply-To: <1453722250-23297-1-git-send-email-yamada.masahiro@socionext.com>
 (Masahiro Yamada's message of "Mon, 25 Jan 2016 20:44:10 +0900")
References: <1453722250-23297-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <874me1ekax.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,
 
 On lun., janv. 25 2016, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> This platform recently moved to multi-platform, so missed the global
> fixup by commit e32465429490 ("ARM: use "depends on" for SoC configs
> instead of "if" after prompt").  Fix it now.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied on mvebu/cleanup

Thanks,

Gregory
> ---
>
>  arch/arm/mach-mv78xx0/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-mv78xx0/Kconfig b/arch/arm/mach-mv78xx0/Kconfig
> index a32575f..c32f855 100644
> --- a/arch/arm/mach-mv78xx0/Kconfig
> +++ b/arch/arm/mach-mv78xx0/Kconfig
> @@ -1,5 +1,6 @@
>  menuconfig ARCH_MV78XX0
> -	bool "Marvell MV78xx0" if ARCH_MULTI_V5
> +	bool "Marvell MV78xx0"
> +	depends on ARCH_MULTI_V5
>  	select ARCH_REQUIRE_GPIOLIB
>  	select CPU_FEROCEON
>  	select MVEBU_MBUS
> -- 
> 1.9.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
