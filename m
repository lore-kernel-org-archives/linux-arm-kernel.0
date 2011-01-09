From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Sun, 9 Jan 2011 06:03:36 +0300
Subject: [PATCH v4 1/3] ahci_platform: rename module ahci_platform to
	ahci_platforms
In-Reply-To: <1294537775-21714-2-git-send-email-mkl0301@gmail.com>
References: <1294537775-21714-1-git-send-email-mkl0301@gmail.com>
	<1294537775-21714-2-git-send-email-mkl0301@gmail.com>
Message-ID: <20110109030336.GC27507@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 09, 2011 at 09:49:33AM +0800, mkl0301 at gmail.com wrote:
> From: Mac Lin <mkl0301@gmail.com>
> 
> Due to build system limitations, intermediate and final objects can't have the
> same names. And as we're going to start building SoC-specific objects, rename
> ahci_platform to ahci_platforms, into which link ahci_platform and SoC-specific
> objects.
> 
> Signed-off-by: Mac Lin <mkl0301@gmail.com>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks Mac!

> ---
>  drivers/ata/Makefile |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 2b67c90..d17bfe7 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -3,7 +3,9 @@ obj-$(CONFIG_ATA)		+= libata.o
>  
>  # non-SFF interface
>  obj-$(CONFIG_SATA_AHCI)		+= ahci.o libahci.o
> -obj-$(CONFIG_SATA_AHCI_PLATFORM) += ahci_platform.o libahci.o
> +obj-$(CONFIG_SATA_AHCI_PLATFORM) += ahci_platforms.o libahci.o
> +ahci_platforms-y		+= ahci_platform.o
> +
>  obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
>  obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
>  obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
> -- 
> 1.7.3

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
