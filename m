From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 10 Nov 2013 15:54:13 +0100
Subject: [PATCH 2/4] dt: exynos5250: Enable support for generic USB 3.0 phy
In-Reply-To: <1383205544-32244-3-git-send-email-gautam.vivek@samsung.com>
References: <1383205544-32244-1-git-send-email-gautam.vivek@samsung.com>
 <1383205544-32244-3-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1538612.pj7iqCuQ7M@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On Thursday 31 of October 2013 13:15:42 Vivek Gautam wrote:
> Update device tree bindings for DWC3 controller and
> USB 3.0 phy present on Exynos 5250 SoC, to start using
> the phy driver based on generic phy framework.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |   17 ++++++-----------
>  1 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index bbac42a..31a6595 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -472,22 +472,17 @@
>  			compatible = "synopsys,dwc3";
>  			reg = <0x12000000 0x10000>;
>  			interrupts = <0 72 0>;
> -			usb-phy = <&usb2_phy &usb3_phy>;
> +			phys = <&usb3_phy>;
> +			phy-names = "usb3-phy";

Does the driver already support generic PHY framework?

Also it looks like originally it required two PHYs, while your patch
changes it to just one.

>  		};
>  	};
>  
>  	usb3_phy: usbphy at 12100000 {
>  		compatible = "samsung,exynos5250-usb3phy";

Hmm, this is not fully right. The new bindings should have new compatible
value. This is also a comment to patch 1/1. This is because a device tree
binding associated with specific compatible value is an ABI and should not
be changed in a way that breaks backwards compatibility.

Best regards,
Tomasz
