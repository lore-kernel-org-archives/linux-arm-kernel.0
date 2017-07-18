From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 18 Jul 2017 16:28:46 +0200
Subject: [PATCH 2/3] arm64: dts: marvell: re-order RTC nodes in Marvell
 CP110 description
In-Reply-To: <20170718131034.25167-3-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Tue, 18 Jul 2017 15:10:33 +0200")
References: <20170718131034.25167-1-thomas.petazzoni@free-electrons.com>
 <20170718131034.25167-3-thomas.petazzoni@free-electrons.com>
Message-ID: <87h8y97ra9.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mar., juil. 18 2017, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> In both the CP110 master and slave description, the node describing
> the RTC was at the wrong place when taking into account increasing
> register addresses. Interestingly, it was not even at the same (wrong)
> place in both files.
>
> This commit adjusts that, making the master and slave descriptions
> more aligned.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 14 +++++++-------
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 14 +++++++-------
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index 1294d62..394e54d 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -115,6 +115,13 @@
>  				msi-parent = <&gicp>;
>  			};
>  
> +			cpm_rtc: rtc at 284000 {
> +				compatible = "marvell,armada-8k-rtc";
> +				reg = <0x284000 0x20>, <0x284080 0x24>;
> +				reg-names = "rtc", "rtc-soc";
> +				interrupts = <ICU_GRP_NSR 77 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
>  			cpm_syscon0: system-controller at 440000 {
>  				compatible = "syscon", "simple-mfd";
>  				reg = <0x440000 0x1000>;
> @@ -155,13 +162,6 @@
>  				};
>  			};
>  
> -			cpm_rtc: rtc at 284000 {
> -				compatible = "marvell,armada-8k-rtc";
> -				reg = <0x284000 0x20>, <0x284080 0x24>;
> -				reg-names = "rtc", "rtc-soc";
> -				interrupts = <ICU_GRP_NSR 77 IRQ_TYPE_LEVEL_HIGH>;
> -			};
> -
>  			cpm_sata0: sata at 540000 {
>  				compatible = "marvell,armada-8k-ahci",
>  					     "generic-ahci";
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index 67936f7..2e6422a 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -60,13 +60,6 @@
>  			compatible = "simple-bus";
>  			ranges = <0x0 0x0 0xf4000000 0x2000000>;
>  
> -			cps_rtc: rtc at 284000 {
> -				compatible = "marvell,armada-8k-rtc";
> -				reg = <0x284000 0x20>, <0x284080 0x24>;
> -				reg-names = "rtc", "rtc-soc";
> -				interrupts = <ICU_GRP_NSR 77 IRQ_TYPE_LEVEL_HIGH>;
> -			};
> -
>  			cps_ethernet: ethernet at 0 {
>  				compatible = "marvell,armada-7k-pp22";
>  				reg = <0x0 0x100000>, <0x129000 0xb000>;
> @@ -122,6 +115,13 @@
>  				msi-parent = <&gicp>;
>  			};
>  
> +			cps_rtc: rtc at 284000 {
> +				compatible = "marvell,armada-8k-rtc";
> +				reg = <0x284000 0x20>, <0x284080 0x24>;
> +				reg-names = "rtc", "rtc-soc";
> +				interrupts = <ICU_GRP_NSR 77 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
>  			cps_syscon0: system-controller at 440000 {
>  				compatible = "syscon", "simple-mfd";
>  				reg = <0x440000 0x1000>;
> -- 
> 2.9.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
