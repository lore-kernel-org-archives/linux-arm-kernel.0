From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 6 Mar 2015 18:31:57 +0000
Subject: [PATCH v9 08/21] ARM64 / ACPI: Introduce PCI stub functions for
 ACPI
In-Reply-To: <1424853601-6675-9-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-9-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150306183157.GC26888@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 08:39:48AM +0000, Hanjun Guo wrote:

[...]

> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 6f93c24..4095379 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -10,6 +10,7 @@
>   *
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -46,3 +47,27 @@ int pcibios_add_device(struct pci_dev *dev)
>  
>  	return 0;
>  }
> +
> +/*
> + * raw_pci_read/write - Platform-specific PCI config space access.
> + */
> +int raw_pci_read(unsigned int domain, unsigned int bus,
> +		  unsigned int devfn, int reg, int len, u32 *val)
> +{
> +	return -ENXIO;
> +}
> +
> +int raw_pci_write(unsigned int domain, unsigned int bus,
> +		unsigned int devfn, int reg, int len, u32 val)
> +{
> +	return -ENXIO;
> +}
> +

It would be nice to see:

https://lkml.org/lkml/2015/2/27/264

merged at the same time, so that the two functions above disappear :)

Lorenzo
