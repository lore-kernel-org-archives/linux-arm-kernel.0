From: stillcompiling@gmail.com (Joshua Clayton)
Date: Mon, 18 Jul 2016 08:24:50 -0700
Subject: [PATCH 2/4] doc: usb: ci-hdrc-usb2: add property
 over-current-polarity
In-Reply-To: <1468840547-17899-2-git-send-email-jun.li@nxp.com>
References: <1468840547-17899-1-git-send-email-jun.li@nxp.com>
 <1468840547-17899-2-git-send-email-jun.li@nxp.com>
Message-ID: <578CF4C2.4000804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,
On 07/18/2016 04:15 AM, Li Jun wrote:
> Adding over-current-polarity to indicate the over current flag
> is low active or high active.
>
> Signed-off-by: Li Jun <jun.li@nxp.com>
> ---
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> index 341dc67..c5d35f4 100644
> --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> @@ -81,6 +81,8 @@ i.mx specific properties
>  - fsl,usbmisc: phandler of non-core register device, with one
>    argument that indicate usb controller index
>  - disable-over-current: disable over current detect
> +- over-current-polarity: 0 if the over current signal polarity is low active,
> +  1 if the over current signal polarity is high active.
>  - external-vbus-divider: enables off-chip resistor divider for Vbus
>  
>  Example:
The gpio device bindings already have active low/ active high.
Could that be used here?

In the imx SPI subsystem, for instance, the developers used gpio rather than
MUXED spi chipselect lines for exactly this kind of flexibility.

If there is no magic happening in silicon (which would seem to be the case if we can
handle inverting polarity in the driver), I would suggest going the gpiod route.

Thanks,
Joshua
