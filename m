From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 13 Jun 2017 10:41:02 +0200
Subject: [PATCH 1/2] arm64: dts: marvell: explicitly enable the mdio nodes
 for 7k/8k DB
In-Reply-To: <20170608100455.15769-1-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Thu, 8 Jun 2017 12:04:54 +0200")
References: <20170608100455.15769-1-antoine.tenart@free-electrons.com>
Message-ID: <87bmps9t5t.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On jeu., juin 08 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> Explicitly enable the MDIO nodes in the Marvell Armada 7k DB and Marvell
> Armada 8k DB. This is needed as the MDIO nodes will be disabled in the
> CP 110 slave and master dtsi by a following up patch.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts | 2 ++
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> index 12442329b80f..771311051421 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> @@ -162,6 +162,8 @@
>  };
>  
>  &cpm_mdio {
> +	status = "okay";
> +
>  	phy0: ethernet-phy at 0 {
>  		reg = <0>;
>  	};
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> index 3cde649f96e4..6af3c39bbb99 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> @@ -125,6 +125,8 @@
>  };
>  
>  &cpm_mdio {
> +	status = "okay";
> +
>  	phy1: ethernet-phy at 1 {
>  		reg = <1>;
>  	};
> @@ -170,6 +172,8 @@
>  };
>  
>  &cps_mdio {
> +	status = "okay";
> +
>  	phy0: ethernet-phy at 0 {
>  		reg = <0>;
>  	};
> -- 
> 2.9.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
