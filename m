From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 16 Dec 2017 16:52:17 +0100
Subject: [PATCH v2 1/4] dt-bindings: usb: add DT binding for RK3328 dwc3
 controller
In-Reply-To: <20171204094041.25439-1-heiko@sntech.de>
References: <20171204094041.25439-1-heiko@sntech.de>
Message-ID: <1863083.H0I2rMmhUr@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg, Felipe,

Am Montag, 4. Dezember 2017, 10:40:38 CET schrieb Heiko Stuebner:
> From: William Wu <william.wu@rock-chips.com>
> 
> Adds the device tree bindings description for RK3328 and
> compatible USB DWC3 controller.
> 
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

do you want to pick this patch with only the small dt-binding
change or Ack it for me to pick up together with the actual
devicetree changes in the other patches?


Thanks
Heiko

> ---
> changes in v2:
> - add Rob's Ack
> 
> Ideally usb maintainers would pick up this patch to the binding
> document and I'll take the devicetree changes after that.
> 
> But if so desired, I can also pick up the binding change myself
> but would need an Ack for that.
> 
>  Documentation/devicetree/bindings/usb/rockchip,dwc3.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
> index 50a31536e975..2c3f6a467fda 100644
> --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
> @@ -1,7 +1,9 @@
>  Rockchip SuperSpeed DWC3 USB SoC controller
>  
>  Required properties:
> -- compatible:	should contain "rockchip,rk3399-dwc3" for rk3399 SoC
> +- compatible:	should be one of the following:
> +  - "rockchip,rk3399-dwc3": for rk3399 SoC
> +  - "rockchip,rk3328-dwc3", "rockchip,rk3399-dwc3": for rk3328 SoC
>  - clocks:	A list of phandle + clock-specifier pairs for the
>  		clocks listed in clock-names
>  - clock-names:	Should contain the following:
> 
