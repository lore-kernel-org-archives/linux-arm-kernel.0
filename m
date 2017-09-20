From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 20 Sep 2017 14:47:30 +0200
Subject: [PATCH 4/9] arm64: dts: marvell: add comphy nodes on cp110 master
 and slave
In-Reply-To: <20170918075814.27405-5-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Mon, 18 Sep 2017 09:58:09 +0200")
References: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
 <20170918075814.27405-5-antoine.tenart@free-electrons.com>
Message-ID: <87poalpme5.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On lun., sept. 18 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> This patch describes the comphy available in the cp110 master and slave.
> This comphy provides serdes lanes used by various controllers such as
> the network one.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  .../boot/dts/marvell/armada-cp110-master.dtsi      | 38 ++++++++++++++++++++++
>  .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 38 ++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index faf7d4a497aa..a26948ff72b4 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -109,6 +109,44 @@
>  				};
>  			};
>  
> +			cpm_comphy: phy at 120000 {
> +				compatible = "marvell,comphy-cp110";
> +				reg = <0x120000 0x6000>;
> +				marvell,system-controller = <&cpm_syscon0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				cpm_comphy0: phy at 0 {
> +					reg = <0>;
> +					#phy-cells = <1>;
> +				};
> +
> +				cpm_comphy1: phy at 1 {
> +					reg = <1>;
> +					#phy-cells = <1>;
> +				};
> +
> +				cpm_comphy2: phy at 2 {
> +					reg = <2>;
> +					#phy-cells = <1>;
> +				};
> +
> +				cpm_comphy3: phy at 3 {
> +					reg = <3>;
> +					#phy-cells = <1>;
> +				};
> +
> +				cpm_comphy4: phy at 4 {
> +					reg = <4>;
> +					#phy-cells = <1>;
> +				};
> +
> +				cpm_comphy5: phy at 5 {
> +					reg = <5>;
> +					#phy-cells = <1>;
> +				};
> +			};
> +
>  			cpm_mdio: mdio at 12a200 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index 02d6e2f1a7bf..fe326074edb6 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -109,6 +109,44 @@
>  				};
>  			};
>  
> +			cps_comphy: phy at 120000 {
> +				compatible = "marvell,comphy-cp110";
> +				reg = <0x120000 0x6000>;
> +				marvell,system-controller = <&cps_syscon0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				cps_comphy0: phy at 0 {
> +					reg = <0>;
> +					#phy-cells = <1>;
> +				};
> +
> +				cps_comphy1: phy at 1 {
> +					reg = <1>;
> +					#phy-cells = <1>;
> +				};
> +
> +				cps_comphy2: phy at 2 {
> +					reg = <2>;
> +					#phy-cells = <1>;
> +				};
> +
> +				cps_comphy3: phy at 3 {
> +					reg = <3>;
> +					#phy-cells = <1>;
> +				};
> +
> +				cps_comphy4: phy at 4 {
> +					reg = <4>;
> +					#phy-cells = <1>;
> +				};
> +
> +				cps_comphy5: phy at 5 {
> +					reg = <5>;
> +					#phy-cells = <1>;
> +				};
> +			};
> +
>  			cps_mdio: mdio at 12a200 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> -- 
> 2.13.5
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
