From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Nov 2011 10:09:39 +0000
Subject: [PATCH v7 04/11] ARM: pxa: rename gpio_to_irq and irq_to_gpio
In-Reply-To: <1320806851-13928-5-git-send-email-haojian.zhuang@marvell.com>
References: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
 <1320806851-13928-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20111114100939.GA25150@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2011 at 10:47:24AM +0800, Haojian Zhuang wrote:
> diff --git a/arch/arm/mach-pxa/cm-x2xx-pci.c b/arch/arm/mach-pxa/cm-x2xx-pci.c
> index ebd9259..e79e081 100644
> --- a/arch/arm/mach-pxa/cm-x2xx-pci.c
> +++ b/arch/arm/mach-pxa/cm-x2xx-pci.c
> @@ -43,9 +43,9 @@ void __cmx2xx_pci_init_irq(int irq_gpio)
>  
>  	cmx2xx_it8152_irq_gpio = irq_gpio;
>  
> -	irq_set_irq_type(gpio_to_irq(irq_gpio), IRQ_TYPE_EDGE_RISING);
> +	irq_set_irq_type(PXA_GPIO_TO_IRQ(irq_gpio), IRQ_TYPE_EDGE_RISING);
>  
> -	irq_set_chained_handler(gpio_to_irq(irq_gpio),
> +	irq_set_chained_handler(PXA_GPIO_TO_IRQ(irq_gpio),
>  				cmx2xx_it8152_irq_demux);

The only comment remaining from the previous review of these patches is
that these changes to the runtime usage of gpio_to_irq() should not be
necessary.

If gpiolib is implemented correctly, when running on PXA,
PXA_GPIO_TO_IRQ(gpio) should be the same as gpio_to_irq(gpio).
