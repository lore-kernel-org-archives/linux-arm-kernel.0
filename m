From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 2 Jan 2018 09:54:01 +0800
Subject: [PATCH] ARM: sunxi_defconfig: Enable SUNXI_CCU
In-Reply-To: <20180101192208.11738-1-clabbe.montjoie@gmail.com>
References: <20180101192208.11738-1-clabbe.montjoie@gmail.com>
Message-ID: <CAGb2v6750AVU3cHJA_DTBehNMV7orm3ZFMymddgYC1bV22x1mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 2, 2018 at 3:22 AM, Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> While looking for missing symbol by diffing sunxi_defconfig and my
> .config, I just found that no CLK symbol are present in sunxi_defconfig.

This does not take into account default values in Kconfig. Use
`make savedefconfg` then compare the resulting defconfig file.

>
> This patch add the missing CONFIG_SUNXI_CCU in sunxi_defconfig.
> All other symbol will be automatically selected via their default value.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/configs/sunxi_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
> index 5caaf971fb50..5ed920e75842 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -16,6 +16,7 @@ CONFIG_CPU_FREQ=y
>  CONFIG_CPUFREQ_DT=y
>  CONFIG_VFP=y
>  CONFIG_NEON=y
> +CONFIG_SUNXI_CCU=y

Not needed. See the last line of:

config SUNXI_CCU
        bool "Clock support for Allwinner SoCs"
        depends on ARCH_SUNXI || COMPILE_TEST
        select RESET_CONTROLLER
        default ARCH_SUNXI

Surely kernelci hasn't been broken since the introduction of
sunxi-ng. :)

ChenYu

>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
> --
> 2.13.6
>
