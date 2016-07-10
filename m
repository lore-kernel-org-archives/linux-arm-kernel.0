From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jul 2016 00:11:31 +0200
Subject: [PATCH v2 01/10] ARM: NUC900: Add nuc970 machine support
In-Reply-To: <1468135649-19980-2-git-send-email-vw@iommu.org>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
 <1468135649-19980-2-git-send-email-vw@iommu.org>
Message-ID: <4947302.8IpnGALVQ9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, July 10, 2016 3:27:21 PM CEST Wan Zongshun wrote:
> +
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio.h>
> +#include <linux/init.h>
> +#include <linux/reboot.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/sys_soc.h>
> +#include <linux/semaphore.h>
> +
> +#include <asm/system_misc.h>
> +#include <asm/mach/arch.h>
> +
> +static void __init nuc900_machine_init(void)
> +{
> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}


This is the default for .init_machine, so you can leave the function
undefined.

> +static const char *nuc900_dt_compat[] __initconst = {
> +       "nuvoton,nuc970",
> +       NULL,
> +};
> +
> +DT_MACHINE_START(nuc900_dt, "Nuvoton NUC900 (Device Tree Support)")
> +       .init_machine   = nuc900_machine_init,
> +       .dt_compat      = nuc900_dt_compat,
> +MACHINE_END
> 

After that, you can probably remove most of the #include statements.
The file is still needed for now, until you move to ARCH_MULTIPLATFORM,
at which point the entire machine descriptor is redundant.

	Arnd
