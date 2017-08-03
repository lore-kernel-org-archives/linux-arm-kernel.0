From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 03 Aug 2017 14:23:32 +0200
Subject: [PATCH] arm64: dts: marvell: Fully re-order nodes in Marvell
 CP110 dtsi files
In-Reply-To: <20170718144224.7228-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Tue, 18 Jul 2017 16:42:24 +0200")
References: <20170718144224.7228-1-gregory.clement@free-electrons.com>
Message-ID: <87y3r096wr.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mar., juil. 18 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Since the introduction of the CP110 dt files, the sata node was
> misplaced. Move it at the right place. Thanks to this, the files are
> completely ordered.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/dt64

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 18 +++++++++---------
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 18 +++++++++---------
>  2 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index 394e54d37fff..1acd6a92d1a7 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -162,15 +162,6 @@
>  				};
>  			};
>  
> -			cpm_sata0: sata at 540000 {
> -				compatible = "marvell,armada-8k-ahci",
> -					     "generic-ahci";
> -				reg = <0x540000 0x30000>;
> -				interrupts = <ICU_GRP_NSR 107 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&cpm_clk 1 15>;
> -				status = "disabled";
> -			};
> -
>  			cpm_usb3_0: usb3 at 500000 {
>  				compatible = "marvell,armada-8k-xhci",
>  					     "generic-xhci";
> @@ -191,6 +182,15 @@
>  				status = "disabled";
>  			};
>  
> +			cpm_sata0: sata at 540000 {
> +				compatible = "marvell,armada-8k-ahci",
> +					     "generic-ahci";
> +				reg = <0x540000 0x30000>;
> +				interrupts = <ICU_GRP_NSR 107 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&cpm_clk 1 15>;
> +				status = "disabled";
> +			};
> +
>  			cpm_xor0: xor at 6a0000 {
>  				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
>  				reg = <0x6a0000 0x1000>,
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index 2e6422a66d76..a21814855799 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -163,15 +163,6 @@
>  
>  			};
>  
> -			cps_sata0: sata at 540000 {
> -				compatible = "marvell,armada-8k-ahci",
> -					     "generic-ahci";
> -				reg = <0x540000 0x30000>;
> -				interrupts = <ICU_GRP_NSR 107 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&cps_clk 1 15>;
> -				status = "disabled";
> -			};
> -
>  			cps_usb3_0: usb3 at 500000 {
>  				compatible = "marvell,armada-8k-xhci",
>  					     "generic-xhci";
> @@ -192,6 +183,15 @@
>  				status = "disabled";
>  			};
>  
> +			cps_sata0: sata at 540000 {
> +				compatible = "marvell,armada-8k-ahci",
> +					     "generic-ahci";
> +				reg = <0x540000 0x30000>;
> +				interrupts = <ICU_GRP_NSR 107 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&cps_clk 1 15>;
> +				status = "disabled";
> +			};
> +
>  			cps_xor0: xor at 6a0000 {
>  				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
>  				reg = <0x6a0000 0x1000>,
> -- 
> 2.13.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
