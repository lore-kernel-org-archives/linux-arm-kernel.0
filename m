From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 3 Feb 2015 12:15:46 +0000
Subject: [PATCH v8 06/21] ARM64 / ACPI: Introduce PCI stub functions for
 ACPI
In-Reply-To: <1422881149-8177-7-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-7-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150203121546.GD3677@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 12:45:34PM +0000, Hanjun Guo wrote:
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index ce5836c..c17e7ea 100644
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
> @@ -68,3 +69,27 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>  	bus->domain_nr = domain;
>  }
>  #endif
> +
> +/*
> + * raw_pci_read/write - Platform-specific PCI config space access.
> + */
> +int raw_pci_read(unsigned int domain, unsigned int bus,
> +		  unsigned int devfn, int reg, int len, u32 *val)
> +{
> +	return -EINVAL;
> +}
> +
> +int raw_pci_write(unsigned int domain, unsigned int bus,
> +		unsigned int devfn, int reg, int len, u32 val)
> +{
> +	return -EINVAL;
> +}

You said you'll make these return -ENOSYS, which I think makes more
sense.

-- 
Catalin
