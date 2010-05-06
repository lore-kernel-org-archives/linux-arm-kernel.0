From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 6 May 2010 23:12:09 +0800
Subject: [PATCH] dove: support v7 mode
In-Reply-To: <1273151526-20190-1-git-send-email-saeed@marvell.com>
References: <1273151526-20190-1-git-send-email-saeed@marvell.com>
Message-ID: <o2vf17812d71005060812g9390d75ob95d8b40b23ae865@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 6, 2010 at 9:12 PM, Saeed Bishara <saeed@marvell.com> wrote:
> The CPU of dove can be configured to boot in v7 mode, this patch will enable building the kernel for that mode.
>
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
> ?arch/arm/mm/Kconfig | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 5bd7c89..e40a35a 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -409,7 +409,7 @@ config CPU_32v6K
>
> ?# ARMv7
> ?config CPU_V7
> - ? ? ? bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
> + ? ? ? bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_DOVE

Saeed,

I'd recommend ARCH_DOVE to select CPU_V7 instead.

> ? ? ? ?select CPU_32v6K if !ARCH_OMAP2
> ? ? ? ?select CPU_32v7
> ? ? ? ?select CPU_ABRT_EV7
> --
> 1.6.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
