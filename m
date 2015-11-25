From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 25 Nov 2015 15:39:54 +0100
Subject: [PATCH 1/2] ARM: mvebu: update v5 defconfig
In-Reply-To: <1448461036-16724-1-git-send-email-linus.walleij@linaro.org>
References: <1448461036-16724-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20151125143954.GD11384@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 03:17:16PM +0100, Linus Walleij wrote:
> This just regenerates the v5 mvebu defconfig with the latest
> defaults so as to avoid too much fuzz when applying patches to
> it.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/configs/mvebu_v5_defconfig | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
> index 824de499237b..519c72725798 100644
> --- a/arch/arm/configs/mvebu_v5_defconfig
> +++ b/arch/arm/configs/mvebu_v5_defconfig
> @@ -12,7 +12,6 @@ CONFIG_MODULE_UNLOAD=y
>  # CONFIG_ARCH_MULTI_V7 is not set
>  CONFIG_ARCH_MVEBU=y
>  CONFIG_MACH_KIRKWOOD=y
> -CONFIG_MACH_NETXBIG=y
>  # CONFIG_CPU_FEROCEON_OLD_ID is not set
>  CONFIG_PCI_MVEBU=y
>  CONFIG_PREEMPT=y
> @@ -66,8 +65,6 @@ CONFIG_ATA=y
>  CONFIG_SATA_AHCI=y
>  CONFIG_SATA_MV=y
>  CONFIG_NETDEVICES=y
> -CONFIG_NET_DSA_MV88E6123_61_65=y
> -CONFIG_NET_DSA_MV88E6171=y

This is interesting. I guess because of switchdev.

>  CONFIG_MV643XX_ETH=y
>  CONFIG_R8169=y
>  CONFIG_MARVELL_PHY=y
> @@ -91,7 +88,6 @@ CONFIG_I2C_MV64XXX=y
>  CONFIG_SPI=y
>  CONFIG_SPI_ORION=y
>  CONFIG_GPIO_SYSFS=y
> -CONFIG_POWER_SUPPLY=y
>  CONFIG_POWER_RESET=y
>  CONFIG_POWER_RESET_GPIO=y
>  CONFIG_POWER_RESET_QNAP=y
> @@ -103,16 +99,15 @@ CONFIG_SENSORS_LM85=y
>  CONFIG_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_ORION_WATCHDOG=y
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  CONFIG_FB=y
>  CONFIG_SOUND=y
>  CONFIG_SND=y
>  CONFIG_SND_SOC=y
>  CONFIG_SND_KIRKWOOD_SOC=y
> -CONFIG_SND_KIRKWOOD_SOC_T5325=y

Humm

I think i will be sending a follow-up patch to re-enable these things.
Add the missing dependencies.

  Andrew
