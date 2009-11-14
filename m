From: daniel@caiaq.de (Daniel Mack)
Date: Sat, 14 Nov 2009 17:19:09 +0100
Subject: [PATCH 1/3] Basic support for Arcom Zeus SBC
In-Reply-To: <20091114162416.04cff97c@taxman.wild-wind.fr.eu.org>
References: <20091114162041.5cbbb58e@taxman.wild-wind.fr.eu.org>
	<20091114162416.04cff97c@taxman.wild-wind.fr.eu.org>
Message-ID: <20091114161909.GZ14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 14, 2009 at 04:24:16PM +0100, Marc Zyngier wrote:
> Signed-off-by: Marc Zyngier <maz@misterjones.org>
> ---
>  arch/arm/mach-pxa/Kconfig             |    7 +
>  arch/arm/mach-pxa/Makefile            |    1 +
>  arch/arm/mach-pxa/include/mach/zeus.h |   82 ++++
>  arch/arm/mach-pxa/zeus.c              |  791 +++++++++++++++++++++++++++++++++
>  4 files changed, 881 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-pxa/include/mach/zeus.h
>  create mode 100644 arch/arm/mach-pxa/zeus.c
> 
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index a6f8eab..a2fff7e 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -178,6 +178,13 @@ config ARCH_VIPER
>  	select PXA_HAVE_BOARD_IRQS
>  	select PXA_HAVE_ISA_IRQS
>  
> +config MACH_ARCOM_ZEUS
> +	bool "Arcom/Eurotech ZEUS SBC"
> +	select PXA27x
> +	select ISA
> +	select PXA_HAVE_BOARD_IRQS
> +	select PXA_HAVE_ISA_IRQS
> +
>  config ARCH_PXA_ESERIES
>  	bool "PXA based Toshiba e-series PDAs"
>  	select PXA25x
> diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
> index f10e152..b23c7d1 100644
> --- a/arch/arm/mach-pxa/Makefile
> +++ b/arch/arm/mach-pxa/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_MACH_PALMLD)	+= palmld.o
>  obj-$(CONFIG_MACH_PALMZ72)	+= palmz72.o
>  obj-$(CONFIG_MACH_TREO680)	+= treo680.o
>  obj-$(CONFIG_ARCH_VIPER)	+= viper.o
> +obj-$(CONFIG_MACH_ARCOM_ZEUS)	+= zeus.o

These two files have recently been changed. You should to rebase your
patches against the 'devel' branch of Eric's PXA tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git


Best regards,
Daniel
