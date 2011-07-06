From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 08:55:42 +0100
Subject: [PATCH] ARM: get rid of a few StrongARM cache-related build
	time constants
In-Reply-To: <1309919636-20546-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309919636-20546-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20110706075542.GK8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 10:33:56PM -0400, Nicolas Pitre wrote:
> index 087bc77..f8a94d6 100644
> --- a/arch/arm/mach-ebsa110/core.c
> +++ b/arch/arm/mach-ebsa110/core.c
> @@ -23,6 +23,7 @@
>  #include <asm/pgtable.h>
>  #include <asm/page.h>
>  #include <asm/system.h>
> +#include <asm/cacheflush.h>
>  
>  #include <asm/mach/arch.h>
>  #include <asm/mach/irq.h>
> @@ -114,9 +115,12 @@ static struct map_desc ebsa110_io_desc[] __initdata = {
>  	}
>  };
>  
> +#define SRAM_PHYS		0xdf000000
...
> -#define FLUSH_BASE_PHYS		0x40000000
> -#define FLUSH_BASE		0xdf000000

Looks like you chose the wrong constant.
