From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 02 Mar 2013 19:39:08 +0000
Subject: [PATCH 1/2] gpio/omap: convert gpio irq domain to linear mapping
In-Reply-To: <1362158568-1624-2-git-send-email-jon-hunter@ti.com>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
 <1362158568-1624-2-git-send-email-jon-hunter@ti.com>
Message-ID: <20130302193908.DCA413E10F3@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Mar 2013 11:22:47 -0600, Jon Hunter <jon-hunter@ti.com> wrote:
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

Applied, thanks.

g.
