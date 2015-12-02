From: broonie@kernel.org (Mark Brown)
Date: Wed, 2 Dec 2015 11:18:29 +0000
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
In-Reply-To: <20151202111244.b7ee49ee06b4a95e407e740d@kernel.org>
References: <20151202111244.b7ee49ee06b4a95e407e740d@kernel.org>
Message-ID: <20151202111829.GE1929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 11:12:44AM +0000, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the mvebu tree got a conflict in  between commit
> 377524dc4d77f50e ("ARM: mmp: move into ARCH_MULTIPLATFORM") from the arm-soc
> tree and commit 5f4423af9dd17 ("ARM: orion: multiplatform support") from the
> mvebu tree.

Ccing in Arnd since I forgot to do that.

> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5a328472bd8c..882f5f33bc7d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -490,46 +490,6 @@ config ARCH_IXP4XX
>  	help
>  	  Support for Intel's IXP4XX (XScale) family of processors.
>  
> -config ARCH_DOVE
> -	bool "Marvell Dove"
> -	select ARCH_REQUIRE_GPIOLIB
> -	select CPU_PJ4
> -	select GENERIC_CLOCKEVENTS
> -	select MIGHT_HAVE_PCI
> -	select MVEBU_MBUS
> -	select PINCTRL
> -	select PINCTRL_DOVE
> -	select PLAT_ORION_LEGACY
> -	help
> -	  Support for the Marvell Dove SoC 88AP510
> -
> -config ARCH_MV78XX0
> -	bool "Marvell MV78xx0"
> -	select ARCH_REQUIRE_GPIOLIB
> -	select CPU_FEROCEON
> -	select GENERIC_CLOCKEVENTS
> -	select MVEBU_MBUS
> -	select PCI
> -	select PLAT_ORION_LEGACY
> -	help
> -	  Support for the following Marvell MV78xx0 series SoCs:
> -	  MV781x0, MV782x0.
> -
> -config ARCH_ORION5X
> -	bool "Marvell Orion"
> -	depends on MMU
> -	select ARCH_REQUIRE_GPIOLIB
> -	select CPU_FEROCEON
> -	select GENERIC_CLOCKEVENTS
> -	select MVEBU_MBUS
> -	select PCI
> -	select PLAT_ORION_LEGACY
> -	select MULTI_IRQ_HANDLER
> -	help
> -	  Support for the following Marvell Orion 5x series SoCs:
> -	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
> -	  Orion-2 (5281), Orion-1-90 (6183).
> -
>  config ARCH_KS8695
>  	bool "Micrel/Kendin KS8695"
>  	select ARCH_REQUIRE_GPIOLIB


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151202/a6c11cfc/attachment.sig>
