From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 7 Sep 2012 11:00:49 -0400
Subject: [PATCH v2 5/6] ARM: orion: move custom gpio functions to
 orion-gpio.h
In-Reply-To: <1346960563-18689-6-git-send-email-robherring2@gmail.com>
References: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
 <1346960563-18689-6-git-send-email-robherring2@gmail.com>
Message-ID: <20120907150049.GC19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 02:42:42PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Move custom orion platforms gpio code to orion-gpio to remove the
> dependency on mach/gpio.h.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> ---
...
>  arch/arm/plat-orion/include/plat/gpio.h       |   37 -------------------------
>  arch/arm/plat-orion/include/plat/orion-gpio.h |   37 +++++++++++++++++++++++++
...
>  delete mode 100644 arch/arm/plat-orion/include/plat/gpio.h
>  create mode 100644 arch/arm/plat-orion/include/plat/orion-gpio.h

This looks like a 100% rename, is that true?

Other than that,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

> 
> diff --git a/arch/arm/mach-dove/include/mach/gpio.h b/arch/arm/mach-dove/include/mach/gpio.h
> index e7e5101..40a8c17 100644
> --- a/arch/arm/mach-dove/include/mach/gpio.h
> +++ b/arch/arm/mach-dove/include/mach/gpio.h
> @@ -1,9 +1 @@
> -/*
> - * arch/arm/mach-dove/include/mach/gpio.h
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#include <plat/gpio.h>
> +/* empty */
> diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
> index 9bc97a5..186357f 100644
> --- a/arch/arm/mach-dove/irq.c
> +++ b/arch/arm/mach-dove/irq.c
> @@ -18,6 +18,7 @@
>  #include <asm/mach/irq.h>
>  #include <mach/pm.h>
>  #include <mach/bridge-regs.h>
> +#include <plat/orion-gpio.h>
>  #include "common.h"
>  
>  static void pmu_irq_mask(struct irq_data *d)
> diff --git a/arch/arm/mach-dove/mpp.c b/arch/arm/mach-dove/mpp.c
> index 7f70afc..60bd729 100644
> --- a/arch/arm/mach-dove/mpp.c
> +++ b/arch/arm/mach-dove/mpp.c
> @@ -13,6 +13,7 @@
>  #include <linux/io.h>
>  #include <plat/mpp.h>
>  #include <mach/dove.h>
> +#include <plat/orion-gpio.h>
>  #include "mpp.h"
>  
>  struct dove_mpp_grp {
> diff --git a/arch/arm/mach-kirkwood/include/mach/gpio.h b/arch/arm/mach-kirkwood/include/mach/gpio.h
> index 84f340b..40a8c17 100644
> --- a/arch/arm/mach-kirkwood/include/mach/gpio.h
> +++ b/arch/arm/mach-kirkwood/include/mach/gpio.h
> @@ -1,9 +1 @@
> -/*
> - * arch/asm-arm/mach-kirkwood/include/mach/gpio.h
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#include <plat/gpio.h>
> +/* empty */
> diff --git a/arch/arm/mach-kirkwood/irq.c b/arch/arm/mach-kirkwood/irq.c
> index 720063f..20149a7 100644
> --- a/arch/arm/mach-kirkwood/irq.c
> +++ b/arch/arm/mach-kirkwood/irq.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/irq.h>
>  #include <mach/bridge-regs.h>
> +#include <plat/orion-gpio.h>
>  #include <plat/irq.h>
>  
>  static int __initdata gpio0_irqs[4] = {
> diff --git a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
> index f742a66..19072c8 100644
> --- a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
> +++ b/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
> @@ -19,6 +19,7 @@
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <mach/kirkwood.h>
> +#include <plat/orion-gpio.h>
>  #include "common.h"
>  
>  #define RD88F6192_GPIO_USB_VBUS		10
> diff --git a/arch/arm/mach-mv78xx0/irq.c b/arch/arm/mach-mv78xx0/irq.c
> index eff9a75..4d720f2 100644
> --- a/arch/arm/mach-mv78xx0/irq.c
> +++ b/arch/arm/mach-mv78xx0/irq.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/irq.h>
>  #include <mach/bridge-regs.h>
> +#include <plat/orion-gpio.h>
>  #include <plat/irq.h>
>  #include "common.h"
>  
> diff --git a/arch/arm/mach-orion5x/d2net-setup.c b/arch/arm/mach-orion5x/d2net-setup.c
> index d75dcfa..e3629c0 100644
> --- a/arch/arm/mach-orion5x/d2net-setup.c
> +++ b/arch/arm/mach-orion5x/d2net-setup.c
> @@ -27,6 +27,7 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/pci.h>
>  #include <mach/orion5x.h>
> +#include <plat/orion-gpio.h>
>  #include "common.h"
>  #include "mpp.h"
>  
> diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
> index d470864..0e19db6 100644
> --- a/arch/arm/mach-orion5x/dns323-setup.c
> +++ b/arch/arm/mach-orion5x/dns323-setup.c
> @@ -34,6 +34,7 @@
>  #include <asm/mach/pci.h>
>  #include <asm/system_info.h>
>  #include <mach/orion5x.h>
> +#include <plat/orion-gpio.h>
>  #include "common.h"
>  #include "mpp.h"
>  
> diff --git a/arch/arm/mach-orion5x/include/mach/gpio.h b/arch/arm/mach-orion5x/include/mach/gpio.h
> index a1d0b78..40a8c17 100644
> --- a/arch/arm/mach-orion5x/include/mach/gpio.h
> +++ b/arch/arm/mach-orion5x/include/mach/gpio.h
> @@ -1,9 +1 @@
> -/*
> - * arch/arm/mach-orion5x/include/mach/gpio.h
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#include <plat/gpio.h>
> +/* empty */
> diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
> index 17da709..e152641 100644
> --- a/arch/arm/mach-orion5x/irq.c
> +++ b/arch/arm/mach-orion5x/irq.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/irq.h>
>  #include <mach/bridge-regs.h>
> +#include <plat/orion-gpio.h>
>  #include <plat/irq.h>
>  
>  static int __initdata gpio0_irqs[4] = {
> diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5x/net2big-setup.c
> index 0180c39..3506f16 100644
> --- a/arch/arm/mach-orion5x/net2big-setup.c
> +++ b/arch/arm/mach-orion5x/net2big-setup.c
> @@ -25,6 +25,7 @@
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <mach/orion5x.h>
> +#include <plat/orion-gpio.h>
>  #include "common.h"
>  #include "mpp.h"
>  
> diff --git a/arch/arm/plat-orion/include/plat/gpio.h b/arch/arm/plat-orion/include/plat/gpio.h
> deleted file mode 100644
> index 81c6fc8..0000000
> --- a/arch/arm/plat-orion/include/plat/gpio.h
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -/*
> - * arch/arm/plat-orion/include/plat/gpio.h
> - *
> - * Marvell Orion SoC GPIO handling.
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#ifndef __PLAT_GPIO_H
> -#define __PLAT_GPIO_H
> -
> -#include <linux/init.h>
> -#include <linux/types.h>
> -#include <linux/irqdomain.h>
> -/*
> - * Orion-specific GPIO API extensions.
> - */
> -void orion_gpio_set_unused(unsigned pin);
> -void orion_gpio_set_blink(unsigned pin, int blink);
> -int orion_gpio_led_blink_set(unsigned gpio, int state,
> -	unsigned long *delay_on, unsigned long *delay_off);
> -
> -#define GPIO_INPUT_OK		(1 << 0)
> -#define GPIO_OUTPUT_OK		(1 << 1)
> -void orion_gpio_set_valid(unsigned pin, int mode);
> -
> -/* Initialize gpiolib. */
> -void __init orion_gpio_init(struct device_node *np,
> -			    int gpio_base, int ngpio,
> -			    void __iomem *base, int mask_offset,
> -			    int secondary_irq_base,
> -			    int irq[4]);
> -
> -void __init orion_gpio_of_init(int irq_gpio_base);
> -#endif
> diff --git a/arch/arm/plat-orion/include/plat/orion-gpio.h b/arch/arm/plat-orion/include/plat/orion-gpio.h
> new file mode 100644
> index 0000000..81c6fc8
> --- /dev/null
> +++ b/arch/arm/plat-orion/include/plat/orion-gpio.h
> @@ -0,0 +1,37 @@
> +/*
> + * arch/arm/plat-orion/include/plat/gpio.h
> + *
> + * Marvell Orion SoC GPIO handling.
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __PLAT_GPIO_H
> +#define __PLAT_GPIO_H
> +
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/irqdomain.h>
> +/*
> + * Orion-specific GPIO API extensions.
> + */
> +void orion_gpio_set_unused(unsigned pin);
> +void orion_gpio_set_blink(unsigned pin, int blink);
> +int orion_gpio_led_blink_set(unsigned gpio, int state,
> +	unsigned long *delay_on, unsigned long *delay_off);
> +
> +#define GPIO_INPUT_OK		(1 << 0)
> +#define GPIO_OUTPUT_OK		(1 << 1)
> +void orion_gpio_set_valid(unsigned pin, int mode);
> +
> +/* Initialize gpiolib. */
> +void __init orion_gpio_init(struct device_node *np,
> +			    int gpio_base, int ngpio,
> +			    void __iomem *base, int mask_offset,
> +			    int secondary_irq_base,
> +			    int irq[4]);
> +
> +void __init orion_gpio_of_init(int irq_gpio_base);
> +#endif
> diff --git a/arch/arm/plat-orion/mpp.c b/arch/arm/plat-orion/mpp.c
> index 3b1e17b..c140c2f 100644
> --- a/arch/arm/plat-orion/mpp.c
> +++ b/arch/arm/plat-orion/mpp.c
> @@ -14,6 +14,7 @@
>  #include <linux/io.h>
>  #include <linux/gpio.h>
>  #include <mach/hardware.h>
> +#include <plat/gpio.h>
>  #include <plat/mpp.h>
>  
>  /* Address of the ith MPP control register */
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
