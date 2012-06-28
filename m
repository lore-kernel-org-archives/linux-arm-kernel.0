From: linuxzsc@gmail.com (Richard Zhao)
Date: Thu, 28 Jun 2012 22:06:05 +0800
Subject: [PATCH v2 1/4] usb: chipidea: pci: make platformdata static
In-Reply-To: <1340891629-13145-2-git-send-email-mkl@pengutronix.de>
References: <1340891629-13145-1-git-send-email-mkl@pengutronix.de>
 <1340891629-13145-2-git-send-email-mkl@pengutronix.de>
Message-ID: <20120628140603.GA2799@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 03:53:46PM +0200, Marc Kleine-Budde wrote:
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/usb/chipidea/ci13xxx_pci.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci13xxx_pci.c b/drivers/usb/chipidea/ci13xxx_pci.c
> index 918e149..9f5c171 100644
> --- a/drivers/usb/chipidea/ci13xxx_pci.c
> +++ b/drivers/usb/chipidea/ci13xxx_pci.c
> @@ -23,17 +23,17 @@
>  /******************************************************************************
>   * PCI block
>   *****************************************************************************/
> -struct ci13xxx_platform_data pci_platdata = {
> +static struct ci13xxx_platform_data pci_platdata = {
what about adding __devinitdata?

Thanks
Richard
>  	.name		= UDC_DRIVER_NAME,
>  	.capoffset	= DEF_CAPOFFSET,
>  };
>  
> -struct ci13xxx_platform_data langwell_pci_platdata = {
> +static struct ci13xxx_platform_data langwell_pci_platdata = {
>  	.name		= UDC_DRIVER_NAME,
>  	.capoffset	= 0,
>  };
>  
> -struct ci13xxx_platform_data penwell_pci_platdata = {
> +static struct ci13xxx_platform_data penwell_pci_platdata = {
>  	.name		= UDC_DRIVER_NAME,
>  	.capoffset	= 0,
>  	.power_budget	= 200,
> -- 
> 1.7.10
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
