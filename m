From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 14 Sep 2016 16:21:41 +0200
Subject: [PATCH 2/2] arm64: dts: marvell: enable MSI for PCIe on Armada
 7K/8K
In-Reply-To: <1472744484-19132-3-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Thu, 1 Sep 2016 17:41:24 +0200")
References: <1472744484-19132-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1472744484-19132-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <871t0md0ju.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On jeu., sept. 01 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> This commit adds a reference to the appropriate MSI controller in the
> description of the PCIe controllers on Marvel Armada 7K and 8K
> platforms.

Applied on mvebu/dt64

Thanks,

Gregory

>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 3 +++
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index ceb83b0..ff469e1 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -177,6 +177,7 @@
>  			#interrupt-cells = <1>;
>  			device_type = "pci";
>  			dma-coherent;
> +			msi-parent = <&gic_v2m0>;
>  
>  			bus-range = <0 0xff>;
>  			ranges =
> @@ -202,6 +203,7 @@
>  			#interrupt-cells = <1>;
>  			device_type = "pci";
>  			dma-coherent;
> +			msi-parent = <&gic_v2m0>;
>  
>  			bus-range = <0 0xff>;
>  			ranges =
> @@ -228,6 +230,7 @@
>  			#interrupt-cells = <1>;
>  			device_type = "pci";
>  			dma-coherent;
> +			msi-parent = <&gic_v2m0>;
>  
>  			bus-range = <0 0xff>;
>  			ranges =
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index 2d863f2..43cecf0 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -177,6 +177,7 @@
>  			#interrupt-cells = <1>;
>  			device_type = "pci";
>  			dma-coherent;
> +			msi-parent = <&gic_v2m0>;
>  
>  			bus-range = <0 0xff>;
>  			ranges =
> @@ -202,6 +203,7 @@
>  			#interrupt-cells = <1>;
>  			device_type = "pci";
>  			dma-coherent;
> +			msi-parent = <&gic_v2m0>;
>  
>  			bus-range = <0 0xff>;
>  			ranges =
> @@ -228,6 +230,7 @@
>  			#interrupt-cells = <1>;
>  			device_type = "pci";
>  			dma-coherent;
> +			msi-parent = <&gic_v2m0>;
>  
>  			bus-range = <0 0xff>;
>  			ranges =
> -- 
> 2.7.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
