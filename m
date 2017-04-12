From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 12 Apr 2017 11:01:59 +0200
Subject: [PATCH v2] ARM: dts: armada-38x: label USB and SATA nodes
In-Reply-To: <20170408101626.14032-1-ralph.sennhauser@gmail.com> (Ralph
 Sennhauser's message of "Sat, 8 Apr 2017 12:16:26 +0200")
References: <20170408101626.14032-1-ralph.sennhauser@gmail.com>
Message-ID: <87k26qgfso.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ralph,
 
 On sam., avril 08 2017, Ralph Sennhauser <ralph.sennhauser@gmail.com> wrote:

> Recently most nodes got labels to make them referenceable. The USB 3.0
> nodes as well as the nodes for the SATA controllers were left out,
> rectify the omission.
>
> The labels "sataX" are already used by some boards for the SATA ports,
> therefore use "ahciX" to label the SATA controller nodes.
>
> To avoid potential confusion by labeling an USB3.0 controller "usb2" use
> usb3_X as labels. This also coincides with the node names themselves
> (usb at xxxxx vs usb3 at xxxxx).
>
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

Applied on mvebu/dt

Thanks,

Gregory

> ---
>
> Hi everybody,
>
> Using satacX for controllers with satacXpY for ports might have been a
> possiblity, since ahciX is already used similarly (to avoid a conflict
> with current use of sataX) ahciX seems the better choice. Works well me
> thinks.
>
> The usb3_X labels still seem the best choice even though they aren't
> perfectly consitent, however, I don't see an alternative which would fit
> this requirement either.
>
> Regards
> Ralph
>
> ---
>
> Changes v1 -> v2:
>   * use ahciX instead of satacX for the SATA controller nodes (suggested
>     by Andrew Lunn)
>
>
>  arch/arm/boot/dts/armada-38x.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index ba27ec1..8b165c3 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -530,7 +530,7 @@
>  				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  
> -			sata at a8000 {
> +			ahci0: sata at a8000 {
>  				compatible = "marvell,armada-380-ahci";
>  				reg = <0xa8000 0x2000>;
>  				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> @@ -546,7 +546,7 @@
>  				status = "disabled";
>  			};
>  
> -			sata at e0000 {
> +			ahci1: sata at e0000 {
>  				compatible = "marvell,armada-380-ahci";
>  				reg = <0xe0000 0x2000>;
>  				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> @@ -590,7 +590,7 @@
>  				status = "disabled";
>  			};
>  
> -			usb3 at f0000 {
> +			usb3_0: usb3 at f0000 {
>  				compatible = "marvell,armada-380-xhci";
>  				reg = <0xf0000 0x4000>,<0xf4000 0x4000>;
>  				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> @@ -598,7 +598,7 @@
>  				status = "disabled";
>  			};
>  
> -			usb3 at f8000 {
> +			usb3_1: usb3 at f8000 {
>  				compatible = "marvell,armada-380-xhci";
>  				reg = <0xf8000 0x4000>,<0xfc000 0x4000>;
>  				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 2.10.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
