From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Feb 2010 16:36:49 +0000
Subject: [PATCH 1/1] add mx3 cupid bsp
In-Reply-To: <D99582E5322435468A77E74BB0039E7B176E1F3BB3@SRV02.hamburg.garz-fricke.de>
References: <D99582E5322435468A77E74BB0039E7B176E1F3BB3@SRV02.hamburg.garz-fricke.de>
Message-ID: <20100218163649.GC20243@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2010 at 11:54:29AM +0100, Carsten Behling wrote:
> +config MACH_GUF_CUPID
> +       bool "Support Garz & Fricke Cupid platform"
> +       select ARCH_MX35
> +       default n

default n is the default already; there's no need to explicitly state it.

> +#if defined CONFIG_I2C_IMX || defined CONFIG_I2C_IMX_MODULE
> +#include <mach/i2c.h>
> +#endif

Don't ifdef include files.
