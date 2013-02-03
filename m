From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 3 Feb 2013 17:23:28 +0530
Subject: [PATCH v2 2/6] ARM: davinci: da850: add DT node for mdio device
In-Reply-To: <1359380879-26306-3-git-send-email-prabhakar.lad@ti.com>
References: <1359380879-26306-1-git-send-email-prabhakar.lad@ti.com>
 <1359380879-26306-3-git-send-email-prabhakar.lad@ti.com>
Message-ID: <510E4FB8.4050705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/28/2013 7:17 PM, Prabhakar Lad wrote:
> From: Lad, Prabhakar <prabhakar.lad@ti.com>
> 
> Add mdio device tree node information to da850 by
> providing register details and bus frequency of mdio.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: netdev at vger.kernel.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Heiko Schocher <hs@denx.de>
> ---
>  arch/arm/boot/dts/da850-evm.dts |    3 +++
>  arch/arm/boot/dts/da850.dtsi    |    7 +++++++
>  2 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index 98c1a48..a319491 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -27,6 +27,9 @@
>  		serial2: serial at 1d0d000 {
>  			status = "okay";
>  		};
> +		mdio: davinci_mdio at 1e24000 {

This should just be:

mdio: mdio at 1e24000

inline with how we avoid adding davinci prefix to each node name.

> +			status = "okay";
> +		};
>  	};
>  	nand_cs3 at 62000000 {
>  		status = "okay";
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 7c84822..ba28f2d 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -81,6 +81,13 @@
>  			interrupts = <61>;
>  			status = "disabled";
>  		};
> +		mdio: davinci_mdio at 1e24000 {
> +			compatible = "ti,davinci_mdio";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x224000 0x1000>;
> +			bus_freq = <2200000>;

The bus frequency is board specific and it is better this is defined in
da850-evm.dts

Thanks,
Sekhar
