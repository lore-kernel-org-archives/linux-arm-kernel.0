From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 11:05:51 +0900
Subject: [PATCH/RFC] ARM: shmobile: Enable PM_RUNTIME in defconfig
In-Reply-To: <1400198682-7666-1-git-send-email-horms+renesas@verge.net.au>
References: <1400198682-7666-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20140516020549.GB18137@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

I realise this change was your idea but I'd like to confirm some details.

My assumption is that it requires

[PATCH v4] drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI

Is that indeed required?
Are there other dependencies that are not in the next branch
of my renesas tree?

On Fri, May 16, 2014 at 09:04:42AM +0900, Simon Horman wrote:
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/configs/shmobile_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index 114e88e..4cbaf52 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -35,6 +35,7 @@ CONFIG_KEXEC=y
>  CONFIG_VFP=y
>  CONFIG_NEON=y
>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> +CONFIG_PM_RUNTIME=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
> -- 
> 1.8.5.2
> 
