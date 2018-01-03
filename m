From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 03 Jan 2018 17:09:52 +0100
Subject: [PATCH] arm64: dts: marvell: add Ethernet aliases
In-Reply-To: <20180103151852.15735-1-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Wed, 3 Jan 2018 16:18:52 +0100")
References: <20180103151852.15735-1-antoine.tenart@free-electrons.com>
Message-ID: <87d12qc4a7.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On mer., janv. 03 2018, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> From: Yan Markman <ymarkman@marvell.com>
>
> This patch adds Ethernet aliases in the Marvell Armada 7040 DB, 8040 DB
> and 8040 mcbin device trees so that the bootloader setup the MAC
> addresses correctly.
>
> Signed-off-by: Yan Markman <ymarkman@marvell.com>
> [Antoine: commit message, small fixes]
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>
> Hi,
>
> This patch is based on the latest mvebu/dt64 tree, which already
> contains Thomas' DT de-duplication patches, so there shouldn't be any
> conflict.
>
> Thanks!
> Antoine
>
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts    | 6 ++++++
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts    | 7 +++++++
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 6 ++++++
>  3 files changed, 19 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> index 44c95b97a422..3ae05eee2c9a 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> @@ -61,6 +61,12 @@
>  		reg = <0x0 0x0 0x0 0x80000000>;
>  	};
>  
> +	aliases {
> +		ethernet0 = &cp0_eth0;
> +		ethernet1 = &cp0_eth1;
> +		ethernet2 = &cp0_eth2;
> +	};
> +
>  	cp0_reg_usb3_0_vbus: cp0-usb3-0-vbus {
>  		compatible = "regulator-fixed";
>  		regulator-name = "usb3h0-vbus";
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> index 13e3209d554a..dba55baff20f 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> @@ -61,6 +61,13 @@
>  		reg = <0x0 0x0 0x0 0x80000000>;
>  	};
>  
> +	aliases {
> +		ethernet0 = &cp0_eth0;
> +		ethernet1 = &cp0_eth2;
> +		ethernet2 = &cp1_eth0;
> +		ethernet3 = &cp1_eth1;
> +	};
> +
>  	cp0_reg_usb3_0_vbus: cp0-usb3-0-vbus {
>  		compatible = "regulator-fixed";
>  		regulator-name = "cp0-usb3h0-vbus";
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> index cf0ebd38a2b9..91c19dd04082 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> @@ -62,6 +62,12 @@
>  		reg = <0x0 0x0 0x0 0x80000000>;
>  	};
>  
> +	aliases {
> +		ethernet0 = &cp0_eth0;
> +		ethernet1 = &cp1_eth0;
> +		ethernet2 = &cp1_eth1;
> +	};
> +
>  	/* Regulator labels correspond with schematics */
>  	v_3_3: regulator-3-3v {
>  		compatible = "regulator-fixed";
> -- 
> 2.14.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
