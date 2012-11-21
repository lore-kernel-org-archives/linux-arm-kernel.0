From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 21 Nov 2012 23:28:36 +0300
Subject: [PATCH v3 6/7] usb: chipidea: usbmisc: add mx53 support
In-Reply-To: <1353506793-8354-7-git-send-email-m.grzeschik@pengutronix.de>
References: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
 <1353506793-8354-7-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <50AD3974.4000608@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/21/2012 05:06 PM, Michael Grzeschik wrote:

> This adds mx53 as the next user of the usbmisc driver and makes it
> possible to disable the overcurrent-detection of the internal phy.

> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Changes since v2:
> * added defines for register offsets and bitmasks
> * fixed disable_oc option for all ports

>  drivers/usb/chipidea/usbmisc_imx.c |   51 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> index e090e0f..b1811df 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -19,6 +19,13 @@
>  
>  #define USB_DEV_MAX 4
>  
> +#define MX53_USB_OTG_PHY_CTRL_0_OFFSET	0x08;
> +#define MX53_USB_UH2_CTRL_OFFSET	0x14;
> +#define MX53_USB_UH3_CTRL_OFFSET	0x18;

   Semicolons here? This can't be right.

WBR, Sergei
