From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 16 Nov 2012 12:06:57 +0200
Subject: [PATCH 1/9] usb: chipidea: pci: mark platformdata as static and
 __devinitdata
In-Reply-To: <1352909950-32555-2-git-send-email-m.grzeschik@pengutronix.de>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-2-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <87haop7tfi.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Grzeschik <m.grzeschik@pengutronix.de> writes:

> From: Marc Kleine-Budde <mkl@pengutronix.de>
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

static yes, __devinitdata -- probably not. These structs are used
everywhere throughout the driver currently, not only at initialization
time.

> ---
>  drivers/usb/chipidea/ci13xxx_pci.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/chipidea/ci13xxx_pci.c b/drivers/usb/chipidea/ci13xxx_pci.c
> index 918e149..97d25c8 100644
> --- a/drivers/usb/chipidea/ci13xxx_pci.c
> +++ b/drivers/usb/chipidea/ci13xxx_pci.c
> @@ -23,17 +23,17 @@
>  /******************************************************************************
>   * PCI block
>   *****************************************************************************/
> -struct ci13xxx_platform_data pci_platdata = {
> +static struct ci13xxx_platform_data pci_platdata __devinitdata = {
>  	.name		= UDC_DRIVER_NAME,
>  	.capoffset	= DEF_CAPOFFSET,
>  };
>  
> -struct ci13xxx_platform_data langwell_pci_platdata = {
> +static struct ci13xxx_platform_data langwell_pci_platdata __devinitdata = {
>  	.name		= UDC_DRIVER_NAME,
>  	.capoffset	= 0,
>  };
>  
> -struct ci13xxx_platform_data penwell_pci_platdata = {
> +static struct ci13xxx_platform_data penwell_pci_platdata __devinitdata = {
>  	.name		= UDC_DRIVER_NAME,
>  	.capoffset	= 0,
>  	.power_budget	= 200,
> -- 
> 1.7.10.4
