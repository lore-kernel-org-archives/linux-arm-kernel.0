From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 10 Feb 2015 14:37:01 +0300
Subject: [resend PATCH v3 2/4] Documentation: dt-bindings: add dt binding
 info for hi6220
In-Reply-To: <1423559404-13058-3-git-send-email-zhangfei.gao@linaro.org>
References: <1423559404-13058-1-git-send-email-zhangfei.gao@linaro.org>
 <1423559404-13058-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <54D9ED5D.2000001@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 2/10/2015 12:10 PM, Zhangfei Gao wrote:

> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>   .../devicetree/bindings/usb/hi6220-usb.txt         | 49 ++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/usb/hi6220-usb.txt

> diff --git a/Documentation/devicetree/bindings/usb/hi6220-usb.txt b/Documentation/devicetree/bindings/usb/hi6220-usb.txt
> new file mode 100644
> index 0000000..b8278de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/hi6220-usb.txt
> @@ -0,0 +1,49 @@
> +Hisilicon hi6220 SoC USB controller
> +-----------------------------
[...]
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

    Actually, GPIO bindings say that GPIO properties should be named 
"[<name>-]gpios".

> +
> +Example:
> +
> +	peripheral_ctrl: syscon at f7030000 {
> +	        compatible = "syscon";
> +	        reg = <0x0 0xf7030000 0x0 0x1000>;
> +	};
> +
> +	usb2_phy: usbphy {

    Please name it "usb-phy" as it better resembles "ethernet-phy" 
standardized by ePAPR.

[...]

WBR, Sergei
