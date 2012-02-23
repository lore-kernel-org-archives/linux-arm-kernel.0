From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Feb 2012 15:08:21 -0800
Subject: [RFC PATCH] gpio/omap: Fix IRQ handling for SPARSE_IRQ
In-Reply-To: <4F46C1AF.2040201@ti.com>
References: <4F46C1AF.2040201@ti.com>
Message-ID: <20120223230821.GD18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cousson, Benoit <b-cousson@ti.com> [120223 14:14]:
> The GPIO driver is still relying on internal OMAP IRQ defines that
> are not relevant anymore if OMAP is built with SPARSE_IRQ.

Great :)
 
> Please note that this patch is still RFC, because I do not know
> how to fix properly the ugly cpu_class_is_omap1 and the dependency
> with IH_MPUIO_BASE to detect a MPUIO.

Sounds like gpio_to_irq() needs to be set in the
arch/arm/*omap*/gpio*.c then.

Tony
