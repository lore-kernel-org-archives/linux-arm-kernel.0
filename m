From: stern@rowland.harvard.edu (Alan Stern)
Date: Sat, 12 Oct 2013 10:40:37 -0400 (EDT)
Subject: [PATCH 10/11] usb: chipidea: imx: add binding for supporting
 runtime pm
In-Reply-To: <1381570513-24927-11-git-send-email-peter.chen@freescale.com>
Message-ID: <Pine.LNX.4.44L0.1310121039250.25996-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 12 Oct 2013, Peter Chen wrote:

> Add property for supporting runtime power management
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  .../devicetree/bindings/usb/ci13xxx-imx.txt        |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> index b4b5b79..f666598 100644
> --- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> +++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> @@ -18,6 +18,7 @@ Optional properties:
>  - vbus-supply: regulator for vbus
>  - disable-over-current: disable over current detect
>  - external-vbus-divider: enables off-chip resistor divider for Vbus
> +- supports_runtime_pm: enable runtime pm support
>  
>  Examples:
>  usb at 02184000 { /* USB OTG */
> @@ -28,4 +29,5 @@ usb at 02184000 { /* USB OTG */
>  	fsl,usbmisc = <&usbmisc 0>;
>  	disable-over-current;
>  	external-vbus-divider;
> +	supports_runtime_pm;
>  };

This does not sound like a property of the hardware.  What's the 
_hardware_ difference between parts that support runtime PM and parts 
that don't?

Alan Stern
