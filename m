From: jun.nie@linaro.org (Jun Nie)
Date: Tue, 19 May 2015 08:49:25 +0800
Subject: [PATCH] ARM: xz: do not try to use a ramdisk in defconfig
In-Reply-To: <96091291.NVWbJdm5EK@wuerfel>
References: <96091291.NVWbJdm5EK@wuerfel>
Message-ID: <CABymUCOAza58gFbaScsr8Bbw5WCFPTKj47Oq+qNYnVxN2u4JuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

B.R.
Jun


2015-05-18 23:24 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> The original zx defconfig file looks for a ./rootfs.cpio file,
> but that breaks with
>
>   scripts/gen_initramfs_list.sh: Cannot open 'initramfs.cpio.gz'
>
> when trying to build this kernel. Anybody who relies on the
> current behavior should change their build scripts to append
> the initramfs manually, as this patch removes that default
> in order to help autmatic testing.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'm applying this directly to the next/defconfig branch to kernel the
> kernelci builds.
>
Thanks for education. I learn it now :)

Jun

> diff --git a/arch/arm/configs/zx_defconfig b/arch/arm/configs/zx_defconfig
> index d411cd6bdb7f..b200bb0fecdd 100644
> --- a/arch/arm/configs/zx_defconfig
> +++ b/arch/arm/configs/zx_defconfig
> @@ -13,7 +13,6 @@ CONFIG_RT_GROUP_SCHED=y
>  CONFIG_NAMESPACES=y
>  CONFIG_USER_NS=y
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_INITRAMFS_SOURCE="initramfs.cpio.gz"
>  CONFIG_SYSCTL_SYSCALL=y
>  CONFIG_KALLSYMS_ALL=y
>  CONFIG_EMBEDDED=y
>
