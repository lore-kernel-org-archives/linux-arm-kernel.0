From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Mon, 9 Dec 2013 14:52:00 +0100
Subject: [PATCH 3/3] arm64: add EFI runtime services
In-Reply-To: <1385762712-17043-4-git-send-email-msalter@redhat.com>
References: <1385762712-17043-1-git-send-email-msalter@redhat.com>
 <1385762712-17043-4-git-send-email-msalter@redhat.com>
Message-ID: <20131209135158.GH24997@rocoto.smurfnet.nu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apologies for late feedback.

On Fri, Nov 29, 2013 at 05:05:12PM -0500, Mark Salter wrote:
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> new file mode 100644
> index 0000000..1bad8a7
> --- /dev/null
> +++ b/arch/arm64/kernel/efi.c
> @@ -0,0 +1,507 @@
> +/*
> + * Extensible Firmware Interface
> + *
> + * Based on Extensible Firmware Interface Specification version 2.3.1

Actually, for arm64, we're relying on UEFI 2.4 or later.

> + *
> + * Copyright (C) 2013 Linaro Ltd.

And I'd say you've easily done enough here to motivate adding Red Hat.

> + *
> + * Adapted for arm64 from arch/arm/kernel/efi.c code
> + */
> +
> +#include <linux/efi.h>
> +#include <linux/export.h>
> +#include <linux/memblock.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/bootmem.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/efi.h>
> +#include <asm/tlbflush.h>
> +#include <asm/mmu_context.h>
> +
> +#define efi_early_remap(a, b) \
> +	((__force void *)early_ioremap((a), (b)))

Do we not want early_memremap() here, rather than early_ioremap()?

/
    Leif
