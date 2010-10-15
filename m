From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Oct 2010 21:23:30 +0100
Subject: [PATCH 1/2] ARM: imx: Add wake functionality to GPIO
In-Reply-To: <1287173908-25758-1-git-send-email-Dinh.Nguyen@freescale.com>
References: <1287173908-25758-1-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20101015202330.GA25365@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 15, 2010 at 03:18:27PM -0500, Dinh.Nguyen at freescale.com wrote:
> From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> 
> Add function definition for irq_chip.set_wake to enable GPIO to
> wake-up the system.
> 
> Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> ---
>  arch/arm/plat-mxc/gpio.c              |   35 +++++++++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/gpio.h |    3 ++
>  2 files changed, 38 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
> index 57ec4a8..7647ba3 100644
> --- a/arch/arm/plat-mxc/gpio.c
> +++ b/arch/arm/plat-mxc/gpio.c
> @@ -20,9 +20,11 @@
>   */
>  
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/gpio.h>
> +#include <mach/gpio.h>

Not necessary.  linux/gpio.h -> asm/gpio.h -> mach/gpio.h
