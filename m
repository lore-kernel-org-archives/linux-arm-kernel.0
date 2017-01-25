From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jan 2017 14:35:48 +0100
Subject: [RFC PATCH v1] ARM: Import tango4_defconfig
In-Reply-To: <5c615aa5-678e-63b8-ecae-f5f0bd8a6f2c@sigmadesigns.com>
References: <5c615aa5-678e-63b8-ecae-f5f0bd8a6f2c@sigmadesigns.com>
Message-ID: <4729631.76bAWajetU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 24, 2017 4:11:31 PM CET Marc Gonzalez wrote:
> Import minimal defconfig for tango4 boards.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  arch/arm/configs/tango4_defconfig | 96 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 arch/arm/configs/tango4_defconfig
> 
> diff --git a/arch/arm/configs/tango4_defconfig b/arch/arm/configs/tango4_defconfig
> new file mode 100644
> index 000000000000..aab931fc0e03
> --- /dev/null
> +++ b/arch/arm/configs/tango4_defconfig
> @@ -0,0 +1,96 @@
> +CONFIG_CROSS_COMPILE="arm-linux-gnueabihf-"

This may cause problems with build bots, please remove that line

> +# CONFIG_SWAP is not set
> +CONFIG_SYSVIPC=y
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_HIGH_RES_TIMERS=y
> +# CONFIG_COMPAT_BRK is not set
> +CONFIG_SLAB=y
> +CONFIG_MODULES=y
> +CONFIG_MODULE_UNLOAD=y
> +CONFIG_MODVERSIONS=y
> +CONFIG_ARCH_TANGO=y
> +# CONFIG_ARM_ERRATA_643719 is not set
> +CONFIG_SMP=y
> +CONFIG_PREEMPT=y
> +CONFIG_HZ_300=y

Any specific reason for HZ=300?

> +CONFIG_AEABI=y
> +CONFIG_HIGHMEM=y
> +# CONFIG_ATAGS is not set
> +CONFIG_ARM_APPENDED_DTB=y
> +CONFIG_ARM_ATAG_DTB_COMPAT=y
> +CONFIG_CMDLINE="console=ttyS0,115200 mem=256M"

You shouldn't need the command line override, as both the console port
and the memory size can reliably be found in the DTB

Please also make sure that any hardware specific drivers are enabled in
multi_v7_defconfig along with your platform specific one, and check
that multi_v7_defconfig works as well as your own config.

	Arnd
