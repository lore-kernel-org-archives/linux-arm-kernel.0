From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 18 May 2015 17:29:09 +0200
Subject: [PATCH] ARM: stm32: do not try to use a ramdisk in defconfig
In-Reply-To: <2564815.ICm4KsbZzD@wuerfel>
References: <2564815.ICm4KsbZzD@wuerfel>
Message-ID: <555A0545.1050505@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 05/18/2015 05:19 PM, Arnd Bergmann wrote:
> The original stm32 defconfig file looks for a ./rootfs.cpio file,
> but that breaks with
>
>    ../scripts/gen_initramfs_list.sh: Cannot open './rootfs.cpio'
>
> when trying to build this kernel. Anybody who relies on the
> current behavior should change their build scripts to append
> the initramfs manually, as this patch removes that default
> in order to help autmatic testing.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'm applying this to the next/defconfig branch directly, to get the
> kernelci builder to succeed on this config.
>
> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
> index af757925d0ae..fab9cf9bff02 100644
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -2,7 +2,6 @@ CONFIG_NO_HZ_IDLE=y
>   CONFIG_HIGH_RES_TIMERS=y
>   CONFIG_LOG_BUF_SHIFT=16
>   CONFIG_BLK_DEV_INITRD=y
> -CONFIG_INITRAMFS_SOURCE="./rootfs.cpio"
>   CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>   # CONFIG_UID16 is not set
>   # CONFIG_BASE_FULL is not set
>

Sorry, I forgot to remove it.

Thanks for fixing the issue:
Acked-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Kind regards,
Maxime
