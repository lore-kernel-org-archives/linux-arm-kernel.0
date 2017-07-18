From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 18 Jul 2017 15:49:36 +0200
Subject: [PATCH 3/3] arm64: dts: marvell: add description for SDHCI
 controller in CP110 slave
In-Reply-To: <20170718131034.25167-4-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Tue, 18 Jul 2017 15:10:34 +0200")
References: <20170718131034.25167-1-thomas.petazzoni@free-electrons.com>
 <20170718131034.25167-4-thomas.petazzoni@free-electrons.com>
Message-ID: <87lgnl7t3j.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mar., juil. 18 2017, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> The two CP110 blocks present in the Armada 8K are identical, so since
> there is an SDHCI controller described in the master CP110
> description, it should also be described in the slave CP110.


Actually they are not totally identically and there is no SD/eMMC
controller on the CP slave.

Gregory

>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index 2e6422a..ef95718 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -258,6 +258,16 @@
>  				status = "okay";
>  			};
>  
> +			cps_sdhci0: sdhci at 780000 {
> +				compatible = "marvell,armada-cp110-sdhci";
> +				reg = <0x780000 0x300>;
> +				interrupts = <ICU_GRP_NSR 27 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-names = "core";
> +				clocks = <&cps_clk 1 4>;
> +				dma-coherent;
> +				status = "disabled";
> +			};
> +
>  			cps_crypto: crypto at 800000 {
>  				compatible = "inside-secure,safexcel-eip197";
>  				reg = <0x800000 0x200000>;
> -- 
> 2.9.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
