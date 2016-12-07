From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Wed, 07 Dec 2016 13:13:07 -0500
Subject: [PATCH] Input: lpc32xx-keys - fix invalid error handling of a
 requested irq
In-Reply-To: <20161205014753.2092-1-vz@mleia.com>
References: <20161205014753.2092-1-vz@mleia.com>
Message-ID: <1481134387.9248.8.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-12-05 at 03:47 +0200, Vladimir Zapolskiy wrote:
> Semantics of NR_IRQS is different on machines with SPARSE_IRQ option
> disabled or enabled, in the latter case IRQs are allocated starting
> at least from the value specified by NR_IRQS and going upwards, so
> the check of (irq >= NR_IRQ) to decide about an error code returned by
> platform_get_irq() is completely invalid, don't attempt to overrule
> irq subsystem in the driver.
> 
> The change fixes lpc32xx_keys driver initialization on boot:
> 
>   lpc32xx_keys 40050000.key: failed to get platform irq
>   lpc32xx_keys: probe of 40050000.key failed with error -22
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  drivers/input/keyboard/lpc32xx-keys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Cosmetic - please update the subject line when doing the commit:
replace " -" by ":" after lpc32xx-keys

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
