From: robherring2@gmail.com (Rob Herring)
Date: Wed, 13 Jun 2012 14:23:05 -0500
Subject: [PATCH 2/2] ARM: vexpress: Enable selection of SPARSE_IRQ
In-Reply-To: <1339607602-3846-3-git-send-email-tixy@linaro.org>
References: <1339607602-3846-1-git-send-email-tixy@linaro.org>
 <1339607602-3846-3-git-send-email-tixy@linaro.org>
Message-ID: <4FD8E899.8080207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2012 12:13 PM, Jon Medhurst (Tixy) wrote:
> From: Jon Medhurst <tixy@linaro.org>
> 
> This is required to add vexpress to multiplatform kernels containing
> other boards which require SPARSE_IRQ.
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> ---
>  arch/arm/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 84449dd..bdede09 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -311,6 +311,7 @@ config ARCH_VEXPRESS
>  	select HAVE_CLK
>  	select HAVE_PATA_PLATFORM
>  	select ICST
> +	select MAY_HAVE_SPARSE_IRQ

Why not always select SPARSE_IRQ and remove mach/irqs.h?

Rob

>  	select NO_IOPORT
>  	select PLAT_VERSATILE
>  	select PLAT_VERSATILE_CLCD
