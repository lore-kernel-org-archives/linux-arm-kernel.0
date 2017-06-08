From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 08 Jun 2017 19:13:42 +0200
Subject: [PATCH] arm64: dts: marvell: cp110: add required clocks for mdio
 interface
In-Reply-To: <1496743035-4618-1-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Tue, 6 Jun 2017 11:57:15 +0200")
References: <1496743035-4618-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87h8zqpfll.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mar., juin 06 2017, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> Add the three required clocks for the MDIO interface to be functional
> on Armada 8k platforms.  Without this, the CPU hangs, causing RCU
> stalls or the system to become unresponsive.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> [Thomas:
>  - remove mg_core_clock, since it's a parent of mg_clock
>  - also add clock references to the slave CP mdio instance]
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 1 +
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index 00af338..c33e891 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -95,6 +95,7 @@
>  				#size-cells = <0>;
>  				compatible = "marvell,orion-mdio";
>  				reg = <0x12a200 0x10>;
> +				clocks = <&cpm_syscon0 1 9>, <&cpm_syscon0 1 5>;
>  			};
>  
>  			cpm_icu: interrupt-controller at 1e0000 {
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index bee48ae..2a99ff8 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -100,6 +100,7 @@
>  				#size-cells = <0>;
>  				compatible = "marvell,orion-mdio";
>  				reg = <0x12a200 0x10>;
> +				clocks = <&cps_syscon0 1 9>, <&cps_syscon0 1 5>;
>  			};
>  
>  			cps_icu: interrupt-controller at 1e0000 {
> -- 
> 2.7.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
