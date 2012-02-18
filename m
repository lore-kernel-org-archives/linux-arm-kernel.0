From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Feb 2012 23:20:27 +0000
Subject: [PATCH 1/4] ARM: sa1100: fix sa1100 after sparse irq conversion
In-Reply-To: <1329449534-23811-2-git-send-email-robherring2@gmail.com>
References: <1329449534-23811-1-git-send-email-robherring2@gmail.com>
 <1329449534-23811-2-git-send-email-robherring2@gmail.com>
Message-ID: <20120218232027.GB1269@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 09:32:11PM -0600, Rob Herring wrote:
> diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
> index 0c9a0bd..cfcaaef 100644
> --- a/arch/arm/mach-sa1100/jornada720.c
> +++ b/arch/arm/mach-sa1100/jornada720.c
> @@ -23,7 +23,6 @@
>  #include <linux/mtd/partitions.h>
>  #include <video/s1d13xxxfb.h>
>  
> -#include <mach/hardware.h>
>  #include <asm/hardware/sa1111.h>
>  #include <asm/irq.h>
>  #include <asm/page.h>
> @@ -34,6 +33,9 @@
>  #include <asm/mach/map.h>
>  #include <asm/mach/serial_sa1100.h>
>  
> +#include <mach/hardware.h>
> +#include <mach/irqs.h>

Does this still need asm/irq.h ?

> diff --git a/arch/arm/mach-sa1100/ssp.c b/arch/arm/mach-sa1100/ssp.c
> index b20ff93..1c14617 100644
> --- a/arch/arm/mach-sa1100/ssp.c
> +++ b/arch/arm/mach-sa1100/ssp.c
> @@ -21,6 +21,7 @@
>  
>  #include <asm/irq.h>
>  #include <mach/hardware.h>
> +#include <mach/irqs.h>

Ditto.

> diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
> index ef7a21a..2ca5959 100644
> --- a/drivers/tty/serial/sa1100.c
> +++ b/drivers/tty/serial/sa1100.c
> @@ -38,6 +38,7 @@
>  
>  #include <asm/irq.h>
>  #include <mach/hardware.h>
> +#include <mach/irqs.h>

Ditto.
