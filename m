From: josh@joshtriplett.org (Josh Triplett)
Date: Fri, 19 Oct 2018 08:10:23 -0700
Subject: [PATCH 5/9] powerpc: PCI_MSI needs PCI
In-Reply-To: <20181019120952.32763-6-hch@lst.de>
References: <20181019120952.32763-1-hch@lst.de>
 <20181019120952.32763-6-hch@lst.de>
Message-ID: <20181019151019.GA5618@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 02:09:48PM +0200, Christoph Hellwig wrote:
> Various powerpc boards select the PCI_MSI config option without selecting
> PCI, resulting in potentially not compilable configurations if the by
> default enabled PCI option is disabled.  Explicitly select PCI to ensure
> we always have valid configs.
[...]
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -24,6 +24,7 @@ config BLUESTONE
>  	default n
>  	select PPC44x_SIMPLE
>  	select APM821xx
> +	select PCI
>  	select PCI_MSI
>  	select PPC4xx_MSI
>  	select PPC4xx_PCI_EXPRESS
> @@ -78,6 +79,7 @@ config KATMAI
>  	select 440SPe
>  	select PCI
>  	select PPC4xx_PCI_EXPRESS
> +	select PCI
>  	select PCI_MSI

This case already had PCI selected a couple of lines above.

>  	select PPC4xx_MSI
>  	help
> @@ -219,6 +221,7 @@ config AKEBONO
>  	select SWIOTLB
>  	select 476FPE
>  	select PPC4xx_PCI_EXPRESS
> +	select PCI
>  	select PCI_MSI
>  	select PPC4xx_HSTA_MSI
>  	select I2C
> -- 
> 2.19.1
> 
