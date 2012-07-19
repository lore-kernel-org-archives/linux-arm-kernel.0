From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 19 Jul 2012 10:28:56 +0200
Subject: [PATCH] usb: chipidea: ci13xxx-imx: remove global struct
In-Reply-To: <20120718233107.GA32622@pengutronix.de>
References: <20120718233107.GA32622@pengutronix.de>
Message-ID: <20120719082856.GB11782@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2012 at 01:31:07AM +0200, Michael Grzeschik wrote:
> This patch removes the limitation of having only one
> instance of the ci13xxx-imx. Each instance of the ci13xxx-imx
> could have different flags to be configured with, so we also
> move this settings to the devicetree properties.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  .../devicetree/bindings/usb/ci13xxx-imx.txt        |    6 +++++

New bindings should always have devicetree-discuss in CC.

>  drivers/usb/chipidea/ci13xxx_imx.c                 |   25 +++++++++++---------
>  drivers/usb/chipidea/core.c                        |   11 +++++++++
>  include/linux/usb/chipidea.h                       |    3 +++
>  4 files changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> index 2c29041..5485eb9 100644
> --- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> +++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> @@ -8,6 +8,9 @@ Required properties:
>  Optional properties:
>  - fsl,usbphy: phandler of usb phy that connects to the only one port
>  - vbus-supply: regulator for vbus
> +- require-transceiver: enable the flag in the driver
> +- pullup-on-vbus: enable the flag in the driver
> +- disable-streaming: enable the flag in the driver

NACK to the bindings. You are mapping platform data 1:1 which is nearly
always wrong. Having a quick look in the current devicetree bindings for
USB shows that there is a transceiver property. So, the the
(non-)presence of that property should make "require-transceiver"
superfluous? Also, is "disable-streaming" a description of the hardware?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120719/ad284a49/attachment.sig>
