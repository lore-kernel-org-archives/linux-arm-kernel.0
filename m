From: sbranden@broadcom.com (Scott Branden)
Date: Mon, 23 Nov 2015 10:57:59 -0800
Subject: [PATCH] ARM: dts: enable PCIe PHY support for Cygnus
In-Reply-To: <1447870619-2828-2-git-send-email-rjui@broadcom.com>
References: <1447870619-2828-1-git-send-email-rjui@broadcom.com>
 <1447870619-2828-2-git-send-email-rjui@broadcom.com>
Message-ID: <565361B7.9020504@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ray,

Patch looks good.

On 15-11-18 10:16 AM, Ray Jui wrote:
> Enable PCIe PHY for both PCIe root complexes on Cygnus
>
> Signed-off-by: Ray Jui <rjui@broadcom.com>
Acked-by: Scott Branden <sbranden@broadcom.com>

> ---
>   arch/arm/boot/dts/bcm-cygnus.dtsi | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 2778533..5df5300 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -91,6 +91,21 @@
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>
> +		pcie_phy: phy at 0301d0a0 {
> +			compatible = "brcm,cygnus-pcie-phy";
> +			reg = <0x0301d0a0 0x14>;
> +
> +			pcie0_phy: phy at 0 {
> +				reg = <0>;
> +				#phy-cells = <0>;
> +			};
> +
> +			pcie1_phy: phy at 1 {
> +				reg = <1>;
> +				#phy-cells = <0>;
> +			};
> +		};
> +
>   		pinctrl: pinctrl at 0x0301d0c8 {
>   			compatible = "brcm,cygnus-pinmux";
>   			reg = <0x0301d0c8 0x30>,
> @@ -161,6 +176,9 @@
>   			ranges = <0x81000000 0 0	  0x28000000 0 0x00010000
>   				  0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
>
> +			phys = <&pcie0_phy>;
> +			phy-names = "pcie-phy";
> +
>   			status = "disabled";
>   		};
>
> @@ -182,6 +200,9 @@
>   			ranges = <0x81000000 0 0	  0x48000000 0 0x00010000
>   				  0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
>
> +			phys = <&pcie1_phy>;
> +			phy-names = "pcie-phy";
> +
>   			status = "disabled";
>   		};
>
>
