From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 3 Oct 2018 15:31:10 +0200
Subject: [PATCH] arm64: dts: clearfog-gt-8k: add PCIe slot description
In-Reply-To: <ac8d233a624411272616d19f070cea756f625235.1538572981.git.baruch@tkos.co.il>
References: <ac8d233a624411272616d19f070cea756f625235.1538572981.git.baruch@tkos.co.il>
Message-ID: <20181003133110.GD427@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2018 at 04:23:01PM +0300, Baruch Siach wrote:
> This adds support for the PCIe interface on the CON4 mini-PCIe
> connector.

Hi Baruch

Is there a dependency between this and the implementation of the
reset-gpios? It would be good to at least mention if there is/is not
such a dependency. You could put it under the ---.

> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> index 2e06d82bec58..a13549749ee7 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> @@ -233,6 +233,13 @@
>  	};
>  };
>  
> +&cp0_pcie0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cp0_pci0_reset_pins>;
> +	reset-gpios = <&cp0_gpio2 0 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
>  &cp0_gpio2 {
>  	sata_reset {
>  		gpio-hog;
> -- 
> 2.19.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
