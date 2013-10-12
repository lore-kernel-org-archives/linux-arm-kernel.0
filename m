From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 12 Oct 2013 17:05:23 +0200
Subject: [PATCH 11/12] usb: phy-mxs: update binding for adding
 disconnect line property
In-Reply-To: <1381568986-19802-12-git-send-email-peter.chen@freescale.com>
References: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
 <1381568986-19802-12-git-send-email-peter.chen@freescale.com>
Message-ID: <20131012170523.13726549@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter Chen,

On Sat, 12 Oct 2013 17:09:45 +0800, Peter Chen wrote:
> This property is used to disconnect line between USB PHY and
> USB controller.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  Documentation/devicetree/bindings/usb/mxs-phy.txt |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mxs-phy.txt b/Documentation/devicetree/bindings/usb/mxs-phy.txt
> index 1a9bd85..099b0bb 100644
> --- a/Documentation/devicetree/bindings/usb/mxs-phy.txt
> +++ b/Documentation/devicetree/bindings/usb/mxs-phy.txt
> @@ -5,6 +5,9 @@ Required properties:
>  - reg: Should contain registers location and length
>  - interrupts: Should contain phy interrupt
>  - fsl,anatop: phandle for anatop register
> +- disconnect_line_without_vbus: needs to disconnect
> +connection between USB PHY and controller, it can avoid
> +unexpected wakeup interrupt when the PHY is out of power
>  
>  Example:
>  usbphy1: usbphy at 020c9000 {
> @@ -12,4 +15,5 @@ usbphy1: usbphy at 020c9000 {
>  	reg = <0x020c9000 0x1000>;
>  	interrupts = <0 44 0x04>;
>  	fsl,anatop = <&anatop>;
> +	disconnect_line_without_vbus;
>  };

Device Tree properties use "-" as a separator, not "_". So, it should
be:

	disconnect-line-without-vbus

Also, all your patches touching Device Tree bindings should be Cc'ed to
the devicetree@ mailing list.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
