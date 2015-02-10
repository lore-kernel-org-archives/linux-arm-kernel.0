From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 Feb 2015 13:28:36 +0000
Subject: [PATCH v3 2/5] Documentation: dt-bindings: add dt binding info
 for hi6220
In-Reply-To: <1423554627-694-3-git-send-email-zhangfei.gao@linaro.org>
References: <1423554627-694-1-git-send-email-zhangfei.gao@linaro.org>
 <1423554627-694-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20150210132836.GB9432@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 10, 2015 at 07:50:24AM +0000, Zhangfei Gao wrote:
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  .../devicetree/bindings/usb/hi6220-usb.txt         | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/hi6220-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/hi6220-usb.txt b/Documentation/devicetree/bindings/usb/hi6220-usb.txt
> new file mode 100644
> index 0000000..b8278de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/hi6220-usb.txt
> @@ -0,0 +1,49 @@
> +Hisilicon hi6220 SoC USB controller
> +-----------------------------
> +
> +usb controller is inherited from dwc2, refer dwc2.txt
> +-----
> +
> +Required properties:
> +- compatible: "hisilicon,hi6220-usb"
> +Refer to dwc2.txt for dwc2 usb properties
> +
> +
> +PHY:
> +-----
> +
> +Required properties:
> +- compatible: "hisilicon,hi6220-usb-phy"
> +- vcc-supply: phandle to the regulator that provides power to the PHY.
> +- clocks: phandle and clock specifier of the PHY clock.
> +- hisilicon,peripheral-syscon: phandle of syscon used to control peripheral.
> +- hisilicon,gpio-vbus: gpio of detecting vbus.
> +- hisilicon,gpio-id: gpio of detecting id.

These should be vbus-gpios and id-gpios respectively.

> +
> +Example:
> +
> +	peripheral_ctrl: syscon at f7030000 {
> +	        compatible = "syscon";
> +	        reg = <0x0 0xf7030000 0x0 0x1000>;
> +	};

We should have a real string for this in addition to "syscon".

Thanks,
Mark.
