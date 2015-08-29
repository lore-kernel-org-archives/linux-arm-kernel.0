From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Sat, 29 Aug 2015 10:11:23 -0700
Subject: [PATCH] gpio: omap: Fix gpiochip_add() handling for deferred probe
In-Reply-To: <1440787489-15992-1-git-send-email-tony@atomide.com>
References: <1440787489-15992-1-git-send-email-tony@atomide.com>
Message-ID: <55E1E7BB.7020200@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

8/28/2015 11:44 AM, Tony Lindgren wrote:
> Currently we gpio-omap breaks if gpiochip_add() returns -EPROBE_DEFER:
>
> [    0.570000] gpiochip_add: GPIOs 0..31 (gpio) failed to register
> [    0.570000] omap_gpio 48310000.gpio: Could not register gpio chip -517
> ...
> [    3.670000] omap_gpio 48310000.gpio: Unbalanced pm_runtime_enable!
>
> Let's fix the issue by adding the missing pm_runtime_put() on error.
>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/gpio/gpio-omap.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
