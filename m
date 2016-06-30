From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 30 Jun 2016 13:50:49 +0200
Subject: [PATCH v4 4/4] arm64: dts: marvell: add XOR engine description
 for Armada 7K/8K CP
In-Reply-To: <1466080116-26777-5-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Thu, 16 Jun 2016 14:28:36 +0200")
References: <1466080116-26777-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1466080116-26777-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87d1myx5d2.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On jeu., juin 16 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> This commit adds the Device Tree description for the two XOR engines
> found in the CP part of the Armada 7K/8K SoC.

Applied on mvebu/dt64

Thanks,

Gregory

>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index 367138b..da31bbb 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -107,6 +107,24 @@
>  				status = "disabled";
>  			};
>  
> +			cpm_xor0: xor at 6a0000 {
> +				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
> +				reg = <0x6a0000 0x1000>,
> +				      <0x6b0000 0x1000>;
> +				dma-coherent;
> +				msi-parent = <&gic_v2m0>;
> +				clocks = <&cpm_syscon0 1 8>;
> +			};
> +
> +			cpm_xor1: xor at 6c0000 {
> +				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
> +				reg = <0x6c0000 0x1000>,
> +				      <0x6d0000 0x1000>;
> +				dma-coherent;
> +				msi-parent = <&gic_v2m0>;
> +				clocks = <&cpm_syscon0 1 7>;
> +			};
> +
>  			cpm_spi0: spi at 700600 {
>  				compatible = "marvell,armada-380-spi";
>  				reg = <0x700600 0x50>;
> -- 
> 2.7.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
