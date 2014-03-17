From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Mar 2014 12:29:38 +0100
Subject: [PATCH RESEND 1/2] ARM: ixp4xx: Make dma_set_coherent_mask common,
 correct implementation
In-Reply-To: <20140317105659.449505d8@marrow.netinsight.se>
References: <20140317105448.14bcb617@marrow.netinsight.se>
 <20140317105659.449505d8@marrow.netinsight.se>
Message-ID: <201403171229.39021.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 March 2014, Simon K?gstr?m wrote:
> diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
> index 200970d..b02c764 100644
> --- a/arch/arm/mach-ixp4xx/common-pci.c
> +++ b/arch/arm/mach-ixp4xx/common-pci.c
> @@ -481,14 +481,6 @@ int ixp4xx_setup(int nr, struct pci_sys_data *sys)
>         return 1;
>  }
>  
> -int dma_set_coherent_mask(struct device *dev, u64 mask)
> -{
> -       if (mask >= SZ_64M - 1)
> -               return 0;
> -
> -       return -EIO;
> -}
> -
>  EXPORT_SYMBOL(ixp4xx_pci_read);
>  EXPORT_SYMBOL(ixp4xx_pci_write);
>  EXPORT_SYMBOL(dma_set_coherent_mask);

When you move this function, you should really move the
'EXPORT_SYMBOL' along with it.

	Arnd
