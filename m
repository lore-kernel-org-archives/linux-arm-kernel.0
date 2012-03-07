From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 07 Mar 2012 12:59:18 +0100
Subject: [PATCH v3 02/13] gpio/omap: fix wakeup_en register update in
 _set_gpio_wakeup()
In-Reply-To: <1331118963-26364-3-git-send-email-tarun.kanti@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <1331118963-26364-3-git-send-email-tarun.kanti@ti.com>
Message-ID: <4F574D96.5070306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 March 2012 12:15 PM, Tarun Kanti DebBarma wrote:
> There are two ways through which wakeup_en register can be programmed
> using gpiolib APIs as shown below. It is seen that in the second case
> in _set_gpio_wakeup(), even though bank->suspend_wakeup is updated
> correctly, its value is not programmed in wakeup_en register. Fix this.
> 
> chip.irq_set_type()->gpio_irq_type()->_set_gpio_triggering()->set_gpio_trigger()
> chip.irq_set_wake()->gpio_wake_enable()->_set_gpio_wakeup()
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
Looks good.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
