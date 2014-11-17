From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 17 Nov 2014 13:54:45 +0800
Subject: [PATCH v7 09/13] Documentation: bindings: add doc for the USB2
 ChipIdea USB driver
In-Reply-To: <1415978763-27345-10-git-send-email-antoine.tenart@free-electrons.com>
References: <1415978763-27345-1-git-send-email-antoine.tenart@free-electrons.com>
 <1415978763-27345-10-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20141117055444.GD30017@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 04:25:59PM +0100, Antoine Tenart wrote:
> Document the USB2 ChipIdea driver (ci13xxx) bindings.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  .../devicetree/bindings/usb/ci-hdrc-usb2.txt       | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> new file mode 100644
> index 000000000000..27f8b1e5ee46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> @@ -0,0 +1,24 @@
> +* USB2 ChipIdea USB controller for ci13xxx
> +
> +Required properties:
> +- compatible: should be "chipidea,usb2"
> +- reg: base address and length of the registers
> +- interrupts: interrupt for the USB controller
> +
> +Optional properties:
> +- clocks: reference to the USB clock
> +- phys: reference to the USB PHY
> +- phy-names: should be "usb-phy"
> +- vbus-supply: reference to the VBUS regulator
> +
> +Example:
> +
> +	usb at f7ed0000 {
> +		compatible = "chipidea,usb2";
> +		reg = <0xf7ed0000 0x10000>;
> +		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&chip CLKID_USB0>;
> +		phys = <&usb_phy0>;
> +		phy-names = "usb-phy";
> +		vbus-supply = <&reg_usb0_vbus>;
> +	};
> -- 
> 2.1.0
> 

Acked-by: Peter Chen <peter.chen@freescale.com>

-- 

Best Regards,
Peter Chen
