From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Apr 2010 16:40:37 +0100
Subject: [PATCH 1/3] ARM: cns3xxx: Add basic support for Cavium
	Networks CNS3xxx processors
In-Reply-To: <20100330190245.GB7611@oksana.dev.rtsoft.ru>
References: <20100330190216.GA7611@oksana.dev.rtsoft.ru>
	<20100330190245.GB7611@oksana.dev.rtsoft.ru>
Message-ID: <20100414154037.GC21526@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 30, 2010 at 11:02:45PM +0400, Anton Vorontsov wrote:
> diff --git a/arch/arm/mach-cns3xxx/include/mach/io.h b/arch/arm/mach-cns3xxx/include/mach/io.h
> new file mode 100644
> index 0000000..b4ff09a
> --- /dev/null
> +++ b/arch/arm/mach-cns3xxx/include/mach/io.h
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright 2008 Cavium Networks
> + * Copyright 2003 ARM Limited
> + *
> + * This file is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, Version 2, as
> + * published by the Free Software Foundation.
> + */
> +#ifndef __MACH_IO_H
> +#define __MACH_IO_H
> +
> +#define IO_SPACE_LIMIT 0xffffffff
> +
> +static inline void __iomem *__io(unsigned long addr)
> +{
> +	return (void __iomem *)addr;
> +}

I'm not sure why you define a static inline function for __io here - it's
overriden by the following macro:

> +
> +#define __io(a)			__typesafe_io(a)
> +#define __mem_pci(a)		(a)
