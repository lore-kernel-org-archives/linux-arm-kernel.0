From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 2 Mar 2013 10:54:08 +0530
Subject: [PATCH 1/2] gpio/omap: convert gpio irq domain to linear mapping
In-Reply-To: <1362158568-1624-2-git-send-email-jon-hunter@ti.com>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
 <1362158568-1624-2-git-send-email-jon-hunter@ti.com>
Message-ID: <51318CF8.4020604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 March 2013 10:52 PM, Jon Hunter wrote:
> Currently the OMAP GPIO driver uses a legacy mapping for the GPIO IRQ
> domain. This is not necessary because we do not need to assign a
> specific interrupt number to the GPIO IRQ domain. Therefore, convert
> the OMAP GPIO driver to use a linear mapping instead.
> 
> Please note that this also allows to simplify the logic in the OMAP
> gpio_irq_handler() routine, by using irq_find_mapping() to obtain the
> virtual irq number from the GPIO bank and bank index.
> 
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
Cool.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
