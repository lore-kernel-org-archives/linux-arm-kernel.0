From: balbi@ti.com (Felipe Balbi)
Date: Fri, 6 Dec 2013 14:30:26 -0600
Subject: [PATCH v2 4/5] ARM: dts: keystone: Add usb devicetree bindings
In-Reply-To: <1386187811-9596-5-git-send-email-w-kwok2@ti.com>
References: <1386187811-9596-1-git-send-email-w-kwok2@ti.com>
 <1386187811-9596-5-git-send-email-w-kwok2@ti.com>
Message-ID: <20131206203026.GJ21086@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 04, 2013 at 03:10:10PM -0500, WingMan Kwok wrote:
> diff --git a/Documentation/devicetree/bindings/usb/keystone-usb.txt b/Documentation/devicetree/bindings/usb/keystone-usb.txt
> new file mode 100644
> index 0000000..ac2c7cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/keystone-usb.txt
> @@ -0,0 +1,41 @@
> +TI Keystone Soc USB Controller
> +
> +DWC3 GLUE
> +
> +Required properties:
> + - compatible: should be "ti,keystone-dwc3".
> + - #address-cells, #size-cells : should be '1' if the device has sub-nodes
> +   with 'reg' property.
> + - reg : Address and length of the register set for the USB subsystem on
> +   the SOC.
> + - interrupts : The irq number of this device that is used to interrupt the
> +   MPU.
> + - ranges: allows valid 1:1 translation between child's address space and
> +   parent's address space.
> + - clocks: Clock IDs array as required by the controller.
> + - clock-names: names of clocks correseponding to IDs in the clock property.
> +
> +Sub-nodes:
> +The dwc3 core should be added as subnode to Keystone DWC3 glue.
> +- dwc3 :
> +   The binding details of dwc3 can be found in:
> +   Documentation/devicetree/bindings/usb/dwc3.txt
> +
> +Example:
> +	usb: usb at 2680000 {
> +		compatible = "ti,keystone-dwc3";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x2680000 0x10000>;
> +		clocks = <&clkusb>;
> +		clock-names = "usb";
> +		interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
> +		ranges;
> +
> +		dwc3 at 2690000 {
> +			compatible = "synopsys,dwc3";
> +			reg = <0x2690000 0x70000>;
> +			interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
> +			usb-phy = <&usb_phy>, <&usb_phy>;
> +		};
> +	};
> diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
> index d497d9e..0911bb7 100644
> --- a/arch/arm/boot/dts/keystone.dtsi
> +++ b/arch/arm/boot/dts/keystone.dtsi
> @@ -188,5 +188,23 @@
>  			#size-cells = <1>;
>  			reg = <0x2620738 32>;
>  		};
> +
> +		usb: usb at 2680000 {

likewise, status = disabled ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/1d736762/attachment-0001.sig>
