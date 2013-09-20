From: steev@pwnieexpress.com (Steev Klimaszewski)
Date: Thu, 19 Sep 2013 19:59:57 -0500
Subject: [PATCH] ARM: tegra_defconfig: enable CONFIG_ARM_APPENDED_DTB
In-Reply-To: <1379638594-28888-1-git-send-email-olof@lixom.net>
References: <1379638594-28888-1-git-send-email-olof@lixom.net>
Message-ID: <CAKCjkJbavWtWBxvKqpesmJfcKTUCpbsM_xL0JfS49vOpkZ8AUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CompuLab provide a u-boot that supports dtb, and afaik, it's supported
in mainline u-boot as well.

On Thu, Sep 19, 2013 at 7:56 PM, Olof Johansson <olof@lixom.net> wrote:
> This is needed on TrimSlice, since the u-boot on that hardware is too old
> to support native device tree booting. Same for any device that currently
> run fastboot, but none of that hardware is supported in mainline today;
> or at least there are modern u-boot ports for it.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm/configs/tegra_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
> index ea042e8..b694a09 100644
> --- a/arch/arm/configs/tegra_defconfig
> +++ b/arch/arm/configs/tegra_defconfig
> @@ -39,6 +39,8 @@ CONFIG_AEABI=y
>  CONFIG_HIGHMEM=y
>  CONFIG_ZBOOT_ROM_TEXT=0x0
>  CONFIG_ZBOOT_ROM_BSS=0x0
> +CONFIG_ARM_APPENDED_DTB=y
> +CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_KEXEC=y
>  CONFIG_CPU_FREQ=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> --
> 1.7.10.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
This e-mail and any attachments are for the sole use of the intended 
recipients(s) and may be confidential. Use of any Pwnie Express product 
signifies your agreement to the Rapid Focus Security EULA<http://pwnieexpress.com/pdfs/RFSEULA.pdf>and is subject to export controls under the U.S. Commerce Department's 
Export Administration Regulations ("EAR").
