From: david@lechnology.com (David Lechner)
Date: Fri, 13 Jan 2017 13:36:03 -0600
Subject: [PATCH 09/10] ARM: dts: da850: add the SATA node
In-Reply-To: <1484311084-31547-10-git-send-email-bgolaszewski@baylibre.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
 <1484311084-31547-10-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <4eb4ada8-1d2d-2fa1-7961-21da56ea0082@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2017 06:38 AM, Bartosz Golaszewski wrote:
> Add the SATA node to the da850 device tree.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 1f6a47d..f5086b1 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -427,6 +427,12 @@
>  			phy-names = "usb-phy";
>  			status = "disabled";
>  		};
> +		sata: ahci at 0x218000 {

0x needs to be omitted.

	sata: ahci at 218000 {

> +			compatible = "ti,da850-ahci";
> +			reg = <0x218000 0x2000>, <0x22c018 0x4>;
> +			interrupts = <67>;
> +			status = "disabled";
> +		};
>  		mdio: mdio at 224000 {
>  			compatible = "ti,davinci_mdio";
>  			#address-cells = <1>;
>
