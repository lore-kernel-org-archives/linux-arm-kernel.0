From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 22 Nov 2016 17:05:49 +0100
Subject: [PATCH] net: mvneta: Only disable mvneta_bm for 64-bits
In-Reply-To: <20161122153848.13071-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Tue, 22 Nov 2016 16:38:48 +0100")
References: <20161122153848.13071-1-gregory.clement@free-electrons.com>
Message-ID: <87polno5ya.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mar., nov. 22 2016, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Actually only the mvneta_bm support is not 64-bits compatible.
> The mvneta code itself can run on 64-bits architecture.

I have just realized that my topic prefix was wrong (net-next was
missing), I am send a new email with the correct prefix.

Sorry for the noise.

Gregory

>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/net/ethernet/marvell/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/Kconfig b/drivers/net/ethernet/marvell/Kconfig
> index 66fd9dbb2ca7..2ccea9dd9248 100644
> --- a/drivers/net/ethernet/marvell/Kconfig
> +++ b/drivers/net/ethernet/marvell/Kconfig
> @@ -44,6 +44,7 @@ config MVMDIO
>  config MVNETA_BM_ENABLE
>  	tristate "Marvell Armada 38x/XP network interface BM support"
>  	depends on MVNETA
> +	depends on !64BIT
>  	---help---
>  	  This driver supports auxiliary block of the network
>  	  interface units in the Marvell ARMADA XP and ARMADA 38x SoC
> @@ -58,7 +59,6 @@ config MVNETA
>  	tristate "Marvell Armada 370/38x/XP network interface support"
>  	depends on PLAT_ORION || COMPILE_TEST
>  	depends on HAS_DMA
> -	depends on !64BIT
>  	select MVMDIO
>  	select FIXED_PHY
>  	---help---
> @@ -71,6 +71,7 @@ config MVNETA
>  
>  config MVNETA_BM
>  	tristate
> +	depends on !64BIT
>  	default y if MVNETA=y && MVNETA_BM_ENABLE!=n
>  	default MVNETA_BM_ENABLE
>  	select HWBM
> -- 
> 2.10.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
