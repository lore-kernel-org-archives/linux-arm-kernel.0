From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 08 Jul 2014 20:28:59 +0400
Subject: [PATCH 2/2] usb: ci_hdrc_imx doc: fsl,usbphy is required
In-Reply-To: <1404814481-7652-2-git-send-email-mpa@pengutronix.de>
References: <1404814481-7652-1-git-send-email-mpa@pengutronix.de>
 <1404814481-7652-2-git-send-email-mpa@pengutronix.de>
Message-ID: <53BC1C4B.6060207@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/08/2014 02:14 PM, Markus Pargmann wrote:

> fsl,usbphy is no optional property. This patch moves it to the list of
> required properties.

> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>   Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt
> index a6a32cb7f777..8014d0d050f8 100644
> --- a/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-imx.txt
> @@ -4,6 +4,7 @@ Required properties:
>   - compatible: Should be "fsl,imx27-usb"
>   - reg: Should contain registers location and length
>   - interrupts: Should contain controller interrupt
> +- fsl,usbphy: phandler of usb phy that connects to the only one port

    s/phandler/phandle/. Can fix, while at it...


> @@ -12,7 +13,6 @@ Recommended properies:
>   - dr_mode: One of "host", "peripheral" or "otg". Defaults to "otg"
>
>   Optional properties:
> -- fsl,usbphy: phandler of usb phy that connects to the only one port
>   - fsl,usbmisc: phandler of non-core register device, with one argument
>     that indicate usb controller index
>   - vbus-supply: regulator for vbus

WBR, Sergei
