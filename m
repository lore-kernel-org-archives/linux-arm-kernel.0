From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 20 Sep 2017 14:47:57 +0200
Subject: [PATCH 7/9] arm64: dts: marvell: cp110: add PPv2 port interrupts
In-Reply-To: <20170918075814.27405-8-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Mon, 18 Sep 2017 09:58:12 +0200")
References: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
 <20170918075814.27405-8-antoine.tenart@free-electrons.com>
Message-ID: <87lgl9pmde.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On lun., sept. 18 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> Ports interrupts are used by the PPv2 driver when no PHY is connected to
> a port. This patch adds a description of these interrupts.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Tested-by: Marcin Wojtas <mw@semihalf.com>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 15 +++++++++------
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 15 +++++++++------
>  2 files changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index a26948ff72b4..b1119c541f16 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -74,9 +74,10 @@
>  						     <ICU_GRP_NSR 43 IRQ_TYPE_LEVEL_HIGH>,
>  						     <ICU_GRP_NSR 47 IRQ_TYPE_LEVEL_HIGH>,
>  						     <ICU_GRP_NSR 51 IRQ_TYPE_LEVEL_HIGH>,
> -						     <ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>;
> +						     <ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>,
> +						     <ICU_GRP_NSR 129 IRQ_TYPE_LEVEL_HIGH>;
>  					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
> -							  "tx-cpu3", "rx-shared";
> +							  "tx-cpu3", "rx-shared", "link";
>  					port-id = <0>;
>  					gop-port-id = <0>;
>  					status = "disabled";
> @@ -87,9 +88,10 @@
>  						     <ICU_GRP_NSR 44 IRQ_TYPE_LEVEL_HIGH>,
>  						     <ICU_GRP_NSR 48 IRQ_TYPE_LEVEL_HIGH>,
>  						     <ICU_GRP_NSR 52 IRQ_TYPE_LEVEL_HIGH>,
> -						     <ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>;
> +						     <ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>,
> +						     <ICU_GRP_NSR 128 IRQ_TYPE_LEVEL_HIGH>;
>  					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
> -							  "tx-cpu3", "rx-shared";
> +							  "tx-cpu3", "rx-shared", "link";
>  					port-id = <1>;
>  					gop-port-id = <2>;
>  					status = "disabled";
> @@ -100,9 +102,10 @@
>  						     <ICU_GRP_NSR 45 IRQ_TYPE_LEVEL_HIGH>,
>  						     <ICU_GRP_NSR 49 IRQ_TYPE_LEVEL_HIGH>,
>  						     <ICU_GRP_NSR 53 IRQ_TYPE_LEVEL_HIGH>,
> -						     <ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>;
> +						     <ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>,
> +						     <ICU_GRP_NSR 127 IRQ_TYPE_LEVEL_HIGH>;
>  					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
> -							  "tx-cpu3", "rx-shared";
> +							  "tx-cpu3", "rx-shared", "link";
>  					port-id = <2>;
>  					gop-port-id = <3>;
>  					status = "disabled";
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index fe326074edb6..497d233d6c47 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -74,9 +74,10 @@
>  						     <ICU_GRP_NSR 43 IRQ_TYPE_LEVEL_HIGH>,
>  						     <ICU_GRP_NSR 47 IRQ_TYPE_LEVEL_HIGH>,
>  						     <ICU_GRP_NSR 51 IRQ_TYPE_LEVEL_HIGH>,
> -						     <ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>;
> +						     <ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>,
> +						     <ICU_GRP_NSR 129 IRQ_TYPE_LEVEL_HIGH>;
>  					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
> -							  "tx-cpu3", "rx-shared";
> +							  "tx-cpu3", "rx-shared", "link";
>  					port-id = <0>;
>  					gop-port-id = <0>;
>  					status = "disabled";
> @@ -87,9 +88,10 @@
>  						     <ICU_GRP_NSR 44 IRQ_TYPE_LEVEL_HIGH>,
>  						     <ICU_GRP_NSR 48 IRQ_TYPE_LEVEL_HIGH>,
>  						     <ICU_GRP_NSR 52 IRQ_TYPE_LEVEL_HIGH>,
> -						     <ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>;
> +						     <ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>,
> +						     <ICU_GRP_NSR 128 IRQ_TYPE_LEVEL_HIGH>;
>  					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
> -							  "tx-cpu3", "rx-shared";
> +							  "tx-cpu3", "rx-shared", "link";
>  					port-id = <1>;
>  					gop-port-id = <2>;
>  					status = "disabled";
> @@ -100,9 +102,10 @@
>  						     <ICU_GRP_NSR 45 IRQ_TYPE_LEVEL_HIGH>,
>  						     <ICU_GRP_NSR 49 IRQ_TYPE_LEVEL_HIGH>,
>  						     <ICU_GRP_NSR 53 IRQ_TYPE_LEVEL_HIGH>,
> -						     <ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>;
> +						     <ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>,
> +						     <ICU_GRP_NSR 127 IRQ_TYPE_LEVEL_HIGH>;
>  					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
> -							  "tx-cpu3", "rx-shared";
> +							  "tx-cpu3", "rx-shared", "link";
>  					port-id = <2>;
>  					gop-port-id = <3>;
>  					status = "disabled";
> -- 
> 2.13.5
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
