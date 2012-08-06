From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Mon, 6 Aug 2012 13:38:42 +0200
Subject: [PATCH 1/4] gpio/mxc: remove redundant shadow variables
 initialization
In-Reply-To: <1344146488-9496-1-git-send-email-shawn.guo@linaro.org>
References: <1344146488-9496-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <501FACC2.4010008@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.08.2012 08:01, Shawn Guo wrote:
> With commit 3e11f7b (gpio/generic: initialize basic_mmio_gpio shadow
> variables properly) in place, the shadow variables initialization is
> being done in generic driver bgpio_init call.
> 
> Remove the redundant shadow variables initialization from gpio-mxc
> driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Whole series:

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Looks good :)

Many thanks

Dirk

> ---
>  drivers/gpio/gpio-mxc.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index 4db460b..76e8cda 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -466,8 +466,6 @@ static int __devinit mxc_gpio_probe(struct platform_device *pdev)
>  
>  	port->bgc.gc.to_irq = mxc_gpio_to_irq;
>  	port->bgc.gc.base = pdev->id * 32;
> -	port->bgc.dir = port->bgc.read_reg(port->bgc.reg_dir);
> -	port->bgc.data = port->bgc.read_reg(port->bgc.reg_set);
>  
>  	err = gpiochip_add(&port->bgc.gc);
>  	if (err)
