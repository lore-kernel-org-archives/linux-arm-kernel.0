From: jonathan.austin@arm.com (Jonathan Austin)
Date: Thu, 15 Aug 2013 18:02:52 +0100
Subject: [PATCH resend] ARM: nommu: remove ARCH_MULTIPLATFORM's dependency
 on CONFIG_MMU
In-Reply-To: <1374597712-18112-1-git-send-email-jonathan.austin@arm.com>
References: <1374597712-18112-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <520D09BC.80700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/07/13 17:41, Jonathan Austin wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> ARCH_MULTIPLATFORM currently requires CONFIG_MMU to be set, however it is
> intended that all future V6/V7 platforms are compatible with
> ARCH_MULTIPLATFORM, and so this requirement precludes that addition of new
> !MMU platforms.
>
> Furthermore, this requirement creates unnecessary differences between the MMU
> and !MMU worlds, which is undesirable.
>
> This patch allows ARCH_MULTIPLATFORM to remain selected in a !MMU
> configuration. There is still a need to hardcode CONFIG_DRAM_BASE and other
> parameters relating to the system, so this patch is less about making an
> actual multiplatform kernel for !MMU and more about consistency across the
> kernel.
>
> Along with the nommu-fixes, R7 support and MPU support already sent to this
> list, this patch is sufficient to allow building and booting of kernel for a
> Cortex-R7 core on a Versatile Express platform.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
> ---
>
> This patch was written by Arnd and after some discussion/testing at my end he
> asked me to send it to the list with a full description.
>
> I'm resending this after testing it still allows R7 to boot on 3.11.
>
> Assuming no comments, I'll drop this in the patch system shortly. Any calls for
> Cc-ing stable?

I've just put this in Russell's patch system (as 7817/1) after testing 
with R7/rc5

Jonny

>
> Jonny
>
>   arch/arm/Kconfig |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 49d993c..5a61686 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -289,8 +289,7 @@ choice
>
>   config ARCH_MULTIPLATFORM
>   	bool "Allow multiple platforms to be selected"
> -	depends on MMU
> -	select ARM_PATCH_PHYS_VIRT
> +	select ARM_PATCH_PHYS_VIRT if MMU
>   	select AUTO_ZRELADDR
>   	select COMMON_CLK
>   	select MULTI_IRQ_HANDLER
>
