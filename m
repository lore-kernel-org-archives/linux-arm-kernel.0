From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 13 Jun 2017 10:41:17 +0200
Subject: [PATCH 2/2] arm64: dts: marvell: disable the mdio nodes by default
In-Reply-To: <20170608100455.15769-2-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Thu, 8 Jun 2017 12:04:55 +0200")
References: <20170608100455.15769-1-antoine.tenart@free-electrons.com>
 <20170608100455.15769-2-antoine.tenart@free-electrons.com>
Message-ID: <877f0g9t5e.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On jeu., juin 08 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> Disable the mdio nodes by default in the cp110 slave and master dtsi as
> they're not wired on every board.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>


Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 1 +
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index ac8df5201cd6..5defde123f35 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -94,6 +94,7 @@
>  				#size-cells = <0>;
>  				compatible = "marvell,orion-mdio";
>  				reg = <0x12a200 0x10>;
> +				status = "disabled";
>  			};
>  
>  			cpm_syscon0: system-controller at 440000 {
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index 7740a75a8230..649a7b55fee4 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -101,6 +101,7 @@
>  				#size-cells = <0>;
>  				compatible = "marvell,orion-mdio";
>  				reg = <0x12a200 0x10>;
> +				status = "disabled";
>  			};
>  
>  			cps_syscon0: system-controller at 440000 {
> -- 
> 2.9.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
