From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 16 Dec 2013 11:24:10 -0500
Subject: [PATCH 1/2] gpio: davinci: don't create irq_domain in case of
 unbanked irqs
In-Reply-To: <1386871973-26762-2-git-send-email-grygorii.strashko@ti.com>
References: <1386871973-26762-1-git-send-email-grygorii.strashko@ti.com>
 <1386871973-26762-2-git-send-email-grygorii.strashko@ti.com>
Message-ID: <52AF292A.4020106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 December 2013 01:12 PM, Grygorii Strashko wrote:
> The system may crash if:
> - there are more then 1 bank
> - unbanked irqs are enabled
> - someone will call gpio_to_irq() for GPIO from bank2 or above
> 
> Hence, fix it by not creating irq_domain if unbanked irqs are enabled
> and correct gpio_to_irq_banked() to handle this properly.
> 
> CC: Linus Walleij <linus.walleij@linaro.org>
> CC: Sekhar Nori <nsekhar@ti.com>
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
