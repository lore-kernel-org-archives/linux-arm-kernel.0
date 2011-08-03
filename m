From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 3 Aug 2011 22:10:46 +0300
Subject: [PATCH] gpio: pl061: add DT binding support
In-Reply-To: <1312397661-3328-1-git-send-email-robherring2@gmail.com>
References: <1312397661-3328-1-git-send-email-robherring2@gmail.com>
Message-ID: <20110803191045.GA30783@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Aug 03, 2011 at 01:54:21PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds devicetree binding support to the ARM pl061 driver removing the
> platform_data dependency. When DT binding is used, the gpio numbering is
> assigned dynamically. The interrupt assignment is converted to use the
> irq_domain infrastructure.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
>  drivers/gpio/gpio-pl061.c |   32 +++++++++++++++++++++++---------
>  1 files changed, 23 insertions(+), 9 deletions(-)
> 

[snip]

> @@ -283,7 +295,7 @@ static int pl061_probe(struct amba_device *dev, const 
> struct amba_id *id)
>  	 * irq_chip support
>  	 */
>  
> -	if (chip->irq_base == (unsigned) -1)
> +	if (chip->irq_base == NO_IRQ)

Please update the comment at include/linux/amba/pl061.h as well.

>  		return 0;
>  
>  	writeb(0, chip->base + GPIOIE); /* disable irqs */
> @@ -307,11 +319,13 @@ static int pl061_probe(struct amba_device *dev, const struct amba_id *id)

[snip]

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
