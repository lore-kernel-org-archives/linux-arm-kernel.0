From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Aug 2011 09:00:00 +0100
Subject: [PATCH 2/6] arm/imx: remove the uses of gpio_to_irq()
In-Reply-To: <1313135701-22456-3-git-send-email-shawn.guo@linaro.org>
References: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
	<1313135701-22456-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110812080000.GF4775@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2011 at 03:54:57PM +0800, Shawn Guo wrote:
> gpio_to_irq() is too generic to be defined and used by i.mx platform
> code.  The patch defines IMX_GPIO_TO_IRQ() in mach/hardware.h and
> replaces all the uses of gpio_to_irq() with IMX_GPIO_TO_IRQ().

That makes no sense.  Why not continue to use gpio_to_irq() but provide
the .to_irq method in your gpiolib driver so it can work, and use that
in the places where its used at runtime?

(You won't be able to use it for static initialization obviously.)
