From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Jan 2017 11:49:32 +0100
Subject: [PATCH] arm64: dts: marvell: add generic-ahci compatibles for
 CP110 ahci
In-Reply-To: <E1cS72h-0004nc-Rr@rmk-PC.armlinux.org.uk> (Russell King's
 message of "Fri, 13 Jan 2017 18:57:39 +0000")
References: <E1cS72h-0004nc-Rr@rmk-PC.armlinux.org.uk>
Message-ID: <878tpwydz7.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
 
 On ven., janv. 13 2017, Russell King <rmk+kernel@armlinux.org.uk> wrote:

> Testing with an Armada 8040 board shows that adding the generic-ahci
> compatible to the CP110 AHCI nodes gets us working AHCI on the board.
> A previous patch series posted by Thomas Petazzoni was retracted when
> it was realised that the IP was supposed to be, and is, compatible
> with the standard register layout.
>
> Add this compatible.


Applied on mvebu/dt64

(not that it didn't apply cleanly on the mainline because in mainline we
don't use yet the ICU for the interrupt)

Thanks,

Gregory

>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
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

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
