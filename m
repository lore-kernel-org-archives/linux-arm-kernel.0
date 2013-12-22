From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 22 Dec 2013 21:05:11 +0530
Subject: [PATCH v2 2/2] gpio: davinci: reuse for Keystone SoC
In-Reply-To: <1387361272-20861-3-git-send-email-grygorii.strashko@ti.com>
References: <1387361272-20861-1-git-send-email-grygorii.strashko@ti.com>
 <1387361272-20861-3-git-send-email-grygorii.strashko@ti.com>
Message-ID: <52B706AF.8040408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Wednesday 18 December 2013 03:37 PM, Grygorii Strashko wrote:
> The similar GPIO HW block is used by keystone SoCs as
> in Davinci SoCs.
> Hence, reuse Davinci GPIO driver for Keystone taking into
> account that Keystone contains ARM GIC IRQ controller which
> is implemented using IRQ Chip.
> 
> Documentation:
> 	http://www.ti.com/lit/ug/sprugv1/sprugv1.pdf
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: devicetree at vger.kernel.org
> 
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  .../devicetree/bindings/gpio/gpio-davinci.txt      |    4 +-
>  drivers/gpio/gpio-davinci.c                        |   46 ++++++++++++++++----
>  2 files changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
> index a2e839d..4ce9862 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
> @@ -1,7 +1,7 @@
> -Davinci GPIO controller bindings
> +Davinci/Keystone GPIO controller bindings
>  
>  Required Properties:
> -- compatible: should be "ti,dm6441-gpio"
> +- compatible: should be "ti,dm6441-gpio", "ti,keystone-gpio"

Can I get your ack for this change? Its pretty trivial, but still..

Thanks,
Sekhar
