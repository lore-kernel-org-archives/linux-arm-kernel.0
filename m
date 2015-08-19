From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 19 Aug 2015 12:35:58 +0200
Subject: [PATCH 0/3] gpiolib: Initializing GPIOs using DT property
 gpio-initval
In-Reply-To: <1439979512-3894-1-git-send-email-mpa@pengutronix.de>
References: <1439979512-3894-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20150819103558.GP11161@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 12:18:29PM +0200, Markus Pargmann wrote:
> Hi,
> 
> This series adds a gpio-initval property to the devicetree. It provides a way
> to initialize GPIOs to a defined value.
> 
> The previous patch was '[PATCH v2] gpio: Allow hogged gpios to be requested'
> which would have allowed to request hogged GPIOs. Linus suggested a separate DT
> property as hogged gpios should not be requested.
> 
> There are 3 patches. The first two simplify the function gpiod_hog. The third
> reuses the gpiod_hog()_code for a new gpiod_initialize() and adds the parsing
> of the DT.
> 
> This series is based on the series
> "[PATCH v3 0/9] gpiolib: Add GPIO name support".

Messed up all the author/signed-off-bys. I will fix it in v2 but will
wait for some feedback first.

Best regards,

Markus

> 
> Best regards,
> 
> Markus
> 
> 
> Markus Pargmann (3):
>   gpio: Use __gpiod_request directly
>   gpiolib: gpiod_hog remove separate name argument
>   gpiolib: Add GPIO initialization
> 
>  Documentation/devicetree/bindings/gpio/gpio.txt | 29 ++++++----
>  drivers/gpio/gpiolib-of.c                       | 11 +++-
>  drivers/gpio/gpiolib.c                          | 74 +++++++++++++++++--------
>  drivers/gpio/gpiolib.h                          |  6 +-
>  4 files changed, 83 insertions(+), 37 deletions(-)
> 
> -- 
> 2.4.6
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150819/bbf71c15/attachment.sig>
