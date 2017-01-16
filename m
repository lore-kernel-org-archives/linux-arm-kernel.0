From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Jan 2017 12:06:21 +0000
Subject: [PATCH] arm64: dts: marvell: add generic-ahci compatibles for
 CP110 ahci
In-Reply-To: <E1cS72h-0004nc-Rr@rmk-PC.armlinux.org.uk>
References: <E1cS72h-0004nc-Rr@rmk-PC.armlinux.org.uk>
Message-ID: <20170116120621.GE5908@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 06:57:39PM +0000, Russell King wrote:
> Testing with an Armada 8040 board shows that adding the generic-ahci
> compatible to the CP110 AHCI nodes gets us working AHCI on the board.
> A previous patch series posted by Thomas Petazzoni was retracted when
> it was realised that the IP was supposed to be, and is, compatible
> with the standard register layout.
> 
> Add this compatible.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Assuming the above is correct this looks sane to me. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 3 ++-
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index 464b491c7291..65ad781d7910 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -128,7 +128,8 @@
>  			};
>  
>  			cpm_sata0: sata at 540000 {
> -				compatible = "marvell,armada-8k-ahci";
> +				compatible = "marvell,armada-8k-ahci",
> +					     "generic-ahci";
>  				reg = <0x540000 0x30000>;
>  				interrupts = <ICU_GRP_NSR 107 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&cpm_syscon0 1 15>;
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index b10f4781d8fb..168d667d50a3 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -128,7 +128,8 @@
>  			};
>  
>  			cps_sata0: sata at 540000 {
> -				compatible = "marvell,armada-8k-ahci";
> +				compatible = "marvell,armada-8k-ahci",
> +					     "generic-ahci";
>  				reg = <0x540000 0x30000>;
>  				interrupts = <ICU_GRP_NSR 107 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&cps_syscon0 1 15>;
> -- 
> 2.7.4
> 
