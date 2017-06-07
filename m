From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 7 Jun 2017 18:02:49 +0530
Subject: [PATCH 2/3] dt-bindings: Add Broadcom STB USB PHY binding document
In-Reply-To: <1496426512-10590-3-git-send-email-alcooperx@gmail.com>
References: <1496426512-10590-1-git-send-email-alcooperx@gmail.com>
 <1496426512-10590-3-git-send-email-alcooperx@gmail.com>
Message-ID: <dd1addfb-6bfd-cb0a-839b-6dac00decd47@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 02 June 2017 11:31 PM, Al Cooper wrote:
> Add DT bindings document for Broadcom STB USB PHYs
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  .../bindings/phy/brcm,brcmstb-usb-phy.txt          | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
> new file mode 100644
> index 0000000..e1e9b16
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
> @@ -0,0 +1,37 @@
> +Broadcom STB USB PHY
> +
> +Required properties:
> + - compatible: brcm,brcmstb-usb-phy
> + - reg: two offset and length pairs. The second pair specifies optional
> +        registers used by some of the SoCs that support USB 3.x

and the first pair?
> + - #phy-cells: Shall be 1 as it expects one argument for setting
> +	       the type of the PHY. Possible values are 0 (1.1 and 2.0),
> +	       1 (3.x)

It should use PHY_TYPE_USB2 or PHY_TYPE_USB3 (see include/dt-bindings/phy/phy.h).

Thanks
Kishon
