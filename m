From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 31 May 2011 09:44:24 +0100
Subject: [PATCH 1/4] gpio: gpio-mxc: add gpio driver for Freescale MXC
	architecture
In-Reply-To: <1306767139-24763-2-git-send-email-shawn.guo@linaro.org>
References: <1306767139-24763-1-git-send-email-shawn.guo@linaro.org>
	<1306767139-24763-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110531084424.GA2266@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, May 30, 2011 at 10:52:16PM +0800, Shawn Guo wrote:
> Add gpio-mxc driver by copying arch/arm/plat-mxc/gpio.c into
> drivers/gpio with the following changes.
> 
>  * Use readl/writel to replace mach-specific accessors
>    __raw_readl/__raw_writel
> 
>  * Migrate to platform driver by adding .probe function
> 
>  * Add a list to save all mx2 ports references, so that
>    mx2_gpio_irq_handler can walk through all interrupt status
>    registers
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

Could you use the stuff in drivers/gpio/basic_mmio_gpio.c for 
implementing the gpio_chip?  I had a go a little while ago [1] but since 
then we've made it possible to embed the bgpio_chip in your own 
structure which may be cleaner.

Jamie

1. http://permalink.gmane.org/gmane.linux.ports.arm.kernel/113139
