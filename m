From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 05 Feb 2015 21:24:01 +0300
Subject: [PATCH 2/4] Documentation: dt-bindings: add dt binding info for
 hi6220
In-Reply-To: <1423147620-5760-3-git-send-email-zhangfei.gao@linaro.org>
References: <1423147620-5760-1-git-send-email-zhangfei.gao@linaro.org>
 <1423147620-5760-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <54D3B541.1070404@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/05/2015 05:46 PM, Zhangfei Gao wrote:

> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>   .../devicetree/bindings/usb/hi6220-usb.txt         | 50 ++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/usb/hi6220-usb.txt

> diff --git a/Documentation/devicetree/bindings/usb/hi6220-usb.txt b/Documentation/devicetree/bindings/usb/hi6220-usb.txt
> new file mode 100644
> index 0000000..e926364
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/hi6220-usb.txt
> @@ -0,0 +1,50 @@
> +Hisilicon hi6220  SoC USB controlle

    Controller.

> +-----------------------------
> +
> +usb controller is inherited from dwc2, refer dwc2.txt
> +-----
> +
> +Required properties:
> +- compatible: "hisilicon,hi6220-usb-phy"

    PHY? I thought you were describing the USB controller.

> +Refer to dwc2.txt for dwc2 usb properties
> +
> +
> +phy:
> +-----
> +
> +Required properties:
> +- compatible: "hisilicon,hi6220-usb-phy"
> +- vcc-supply: phandle to the regulator that provides power to the PHY.
> +- clocks: phandle to the PHY clock. Use as per Documentation/devicetree

    Actually, it's phandle and clock specifier.

> +  /bindings/clock/clock-bindings.txt
> +- hisilicon,peripheral-syscon: phandle of syscon used to control peripheral.
> +- hisilicon,gpio_vbus_det: gpio of detecting vbus.
> +- hisilicon,gpio_id_det: gpio of detecting id.

    Hyphens are preferred over underscores in the prop names.

[...]

WBR, Sergei
