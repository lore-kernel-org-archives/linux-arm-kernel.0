From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Aug 2017 16:48:31 +0200
Subject: [PATCH] arm64: dts: marvell: add UART muxing on Armada 7K/8K
In-Reply-To: <20170830101606.8339-1-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Wed, 30 Aug 2017 12:16:06 +0200")
References: <20170830101606.8339-1-thomas.petazzoni@free-electrons.com>
Message-ID: <87r2vt2jsw.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mer., ao?t 30 2017, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> This commit adds the relevant details in the Armada 7K/8K Device Tree
> to properly mux the UART used for the serial console. Since there is
> basically only one possible muxing for the UART0 on the AP, the muxing
> configuration is described in armada-ap806.dtsi, and selected from the
> individual boards (other boards could be using a different UART).
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied on mvebu/dt64-4.15

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts    | 2 ++
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts    | 2 ++
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 2 ++
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi     | 5 +++++
>  4 files changed, 11 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> index 9c3bdf8..64a8e02 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> @@ -124,6 +124,8 @@
>  
>  &uart0 {
>  	status = "okay";
> +	pinctrl-0 = <&uart0_pins>;
> +	pinctrl-names = "default";
>  };
>  
>  
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> index 0d7b2ae..2a9b68e 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> @@ -139,6 +139,8 @@
>  /* Accessible over the mini-USB CON9 connector on the main board */
>  &uart0 {
>  	status = "okay";
> +	pinctrl-0 = <&uart0_pins>;
> +	pinctrl-names = "default";
>  };
>  
>  
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> index 21fb721..ac7438e 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> @@ -101,6 +101,8 @@
>  
>  &uart0 {
>  	status = "okay";
> +	pinctrl-0 = <&uart0_pins>;
> +	pinctrl-names = "default";
>  };
>  
>  &ap_sdhci0 {
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 4d36071..1eb51e0 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -263,6 +263,11 @@
>  
>  				ap_pinctrl: pinctrl {
>  					compatible = "marvell,ap806-pinctrl";
> +
> +					uart0_pins: uart0-pins {
> +						marvell,pins = "mpp11", "mpp19";
> +						marvell,function = "uart0";
> +					};
>  				};
>  
>  				ap_gpio: gpio {
> -- 
> 2.9.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
