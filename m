From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 3 Jul 2014 15:36:53 +0200
Subject: [PATCH 1/2] ARM: mvebu: add appended DTB support in
 mvebu_v5_defconfig
In-Reply-To: <1404375830-22169-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404375830-22169-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140703133653.GQ20799@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 10:23:49AM +0200, Thomas Petazzoni wrote:
> The mvebu_v5_defconfig is currently used for Kirkwood platforms, and
> in the future hopefully used for Orion5x platforms. Those platforms
> use fairly old bootloaders that don't have Device Tree support, so it
> makes sense to enable appended DTB support by default, as well as the
> backward compatibility with ATAGS passed by the bootloader for those
> platforms. It helps having a defconfig that works fine out of the box
> for most Kirkwood platforms.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hi Thomas

Acked-by: Andrew Lunn <andrew@lunn.ch>

And a minor nit. Jason would like to see kirkwood in the subject,
instead of mvebu, so we have a simple way to filter patches by SoC
in mvebu.

	  Andrew




> ---
>  arch/arm/configs/mvebu_v5_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
> index 27c732f..9f70f59 100644
> --- a/arch/arm/configs/mvebu_v5_defconfig
> +++ b/arch/arm/configs/mvebu_v5_defconfig
> @@ -19,6 +19,8 @@ CONFIG_AEABI=y
>  CONFIG_HIGHMEM=y
>  CONFIG_ZBOOT_ROM_TEXT=0x0
>  CONFIG_ZBOOT_ROM_BSS=0x0
> +CONFIG_ARM_APPENDED_DTB=y
> +CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_CPU_FREQ=y
>  CONFIG_CPU_FREQ_STAT_DETAILS=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> -- 
> 2.0.0
> 
