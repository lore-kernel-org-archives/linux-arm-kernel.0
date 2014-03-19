From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 19 Mar 2014 23:50:43 +0300
Subject: [PATCH 59/62] ARM: shmobile: ak4642 needs i2c support
In-Reply-To: <1395257399-359545-60-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-60-git-send-email-arnd@arndb.de>
Message-ID: <532A0323.3080305@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/19/2014 10:29 PM, Arnd Bergmann wrote:

> We cannot select SND_SOC_AK4642 if the I2C core layer
> is disabled. Making the select statement conditional
> ensures that we can build all configurations.

    Yes, but you also touch WM8978 selects. Is it the same as AK4642 or you 
just forgot to mention that?

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-sh at vger.kernel.org
> ---
>   arch/arm/mach-shmobile/Kconfig | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 5249ff0..6e3904e 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -170,7 +170,7 @@ config MACH_MACKEREL
>   	select ARCH_REQUIRE_GPIOLIB
>   	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>   	select SMSC_PHY if SMSC911X
> -	select SND_SOC_AK4642 if SND_SIMPLE_CARD
> +	select SND_SOC_AK4642 if SND_SIMPLE_CARD && I2C=y
>   	select USE_OF
>
>   config MACH_ARMADILLO800EVA
> @@ -179,7 +179,7 @@ config MACH_ARMADILLO800EVA
>   	select ARCH_REQUIRE_GPIOLIB
>   	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>   	select SMSC_PHY if SH_ETH
> -	select SND_SOC_WM8978 if SND_SIMPLE_CARD
> +	select SND_SOC_WM8978 if SND_SIMPLE_CARD && I2C=y
>   	select USE_OF
>
>   config MACH_ARMADILLO800EVA_REFERENCE
> @@ -188,7 +188,7 @@ config MACH_ARMADILLO800EVA_REFERENCE
>   	select ARCH_REQUIRE_GPIOLIB
>   	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>   	select SMSC_PHY if SH_ETH
> -	select SND_SOC_WM8978 if SND_SIMPLE_CARD
> +	select SND_SOC_WM8978 if SND_SIMPLE_CARD && I2C=y
>   	select USE_OF
>   	---help---
>   	   Use reference implementation of Aramdillo800 EVA board support
[...]

WBR, Sergei
