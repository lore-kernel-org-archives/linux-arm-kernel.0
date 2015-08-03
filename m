From: robherring2@gmail.com (Rob Herring)
Date: Mon, 3 Aug 2015 09:00:46 -0500
Subject: [PATCH v2 04/10] Doc: usb: ci-hdrc-usb2: add ahb-burst-config for
 binding doc
In-Reply-To: <1438577238-10153-5-git-send-email-peter.chen@freescale.com>
References: <1438577238-10153-1-git-send-email-peter.chen@freescale.com>
 <1438577238-10153-5-git-send-email-peter.chen@freescale.com>
Message-ID: <CAL_Jsq+GNQq+SQCeMhy=W-XTPJn1ROAYHpm2+W9wwUa9+t-XwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 2, 2015 at 11:47 PM, Peter Chen <peter.chen@freescale.com> wrote:
> It is used to change ahb burst configuration for platforms, it is
> vendor specific.
>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> index 4159c8c..3c377a3 100644
> --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> @@ -32,6 +32,8 @@ Optional properties:
>  - external-vbus-divider: (FSL only) enables off-chip resistor divider for Vbus
>  - itc-setting: interrupt threshold control register control, the setting
>    should be aligned with ITC bits at register USBCMD.
> +- ahb-burst-config: it is vendor dependent, the required value should be
> +  aligned with AHBBRST at SBUSCFG, the range is from 0x0 to 0x7.

What do the values mean and what happens if the property is not
present? Please define that here.

Rob

>
>  Example:
>
> @@ -44,4 +46,6 @@ Example:
>                 phy-names = "usb-phy";
>                 vbus-supply = <&reg_usb0_vbus>;
>                 gadget-itc-setting = <0x4>; /* 4 micro-frames */
> +                /* Incremental burst of unspecified length */
> +               ahb-burst-config = <0x0>;
>         };
> --
> 1.9.1
>
