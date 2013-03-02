From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 2 Mar 2013 10:57:19 +0530
Subject: [PATCH 2/2] gpio/omap: warn if bank is not enabled on setting
 irq type
In-Reply-To: <1362158568-1624-3-git-send-email-jon-hunter@ti.com>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
 <1362158568-1624-3-git-send-email-jon-hunter@ti.com>
Message-ID: <51318DB7.5070601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 March 2013 10:52 PM, Jon Hunter wrote:
> For OMAP devices, if a gpio is being used as an interrupt source but has
> not been requested by calling gpio_request(), a call to request_irq()
> may cause the kernel hang because the gpio bank may be disabled and
> hence the register access will fail. To prevent such hangs, test for
> this case and warn if this is detected.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
