From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 14 Feb 2016 11:44:44 +0800
Subject: [PATCH] dts: ls102xa: ifc: Add the partition for NOR flash
In-Reply-To: <1454487404-330-1-git-send-email-b18965@freescale.com>
References: <1454487404-330-1-git-send-email-b18965@freescale.com>
Message-ID: <20160214034444.GG6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 04:16:44PM +0800, Alison Wang wrote:
> According to the new mapping table, the partition for NOR flash
> is added.

How do you know that everyone using the board wants the NOR flash to be
partitioned this way?  It's really a matter of software configuration
and may vary from system to system.

Shawn

> 
> Signed-off-by: Alison Wang <alison.wang@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a-qds.dts | 60 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/ls1021a-twr.dts | 60 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 120 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
> index 9408753..904ee09 100644
> --- a/arch/arm/boot/dts/ls1021a-qds.dts
> +++ b/arch/arm/boot/dts/ls1021a-qds.dts
> @@ -237,6 +237,66 @@
>  		reg = <0x0 0x0 0x8000000>;
>  		bank-width = <2>;
>  		device-width = <1>;
> +
> +		partition at 0 {
> +			/* 128KB for bank0 RCW */
> +			reg = <0x00000000 0x00020000>;
> +			label = "NOR bank0 RCW Image";
> +		};
> +
> +		partition at 100000 {
> +			/* 1MB for bank0 u-boot Image */
> +			reg = <0x00100000 0x00100000>;
> +			label = "NOR bank0 u-boot Image";
> +		};
> +
> +		partition at 200000 {
> +			/* 1MB for bank0 DTB */
> +			reg = <0x00200000 0x00100000>;
> +			label = "NOR bank0 DTB Image";
> +		};
> +
> +		partition at 300000 {
> +			/* 7MB for bank0 Linux Kernel */
> +			reg = <0x00300000 0x00700000>;
> +			label = "NOR bank0 Linux Kernel Image";
> +		};
> +
> +		partition at a00000 {
> +			/* 54MB for bank0 Ramdisk Root File System */
> +			reg = <0x00a00000 0x03600000>;
> +			label = "NOR bank0 Ramdisk Root File System Image";
> +		};
> +
> +		partition at 4000000 {
> +			/* 128KB for bank4 RCW */
> +			reg = <0x04000000 0x00020000>;
> +			label = "NOR bank4 RCW Image";
> +		};
> +
> +		partition at 4100000 {
> +			/* 1MB for bank4 u-boot Image */
> +			reg = <0x04100000 0x00100000>;
> +			label = "NOR bank4 u-boot Image";
> +		};
> +
> +		partition at 4200000 {
> +			/* 1MB for bank4 DTB */
> +			reg = <0x04200000 0x00100000>;
> +			label = "NOR bank4 DTB Image";
> +		};
> +
> +		partition at 4300000 {
> +			/* 7MB for bank4 Linux Kernel */
> +			reg = <0x04300000 0x00700000>;
> +			label = "NOR bank4 Linux Kernel Image";
> +		};
> +
> +		partition at 4a00000 {
> +			/* 54MB for bank4 Ramdisk Root File System */
> +			reg = <0x04a00000 0x03600000>;
> +			label = "NOR bank4 Ramdisk Root File System Image";
> +		};
>  	};
>  
>  	fpga: board-control at 3,0 {
> diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
> index 75ecaed..f5e9616 100644
> --- a/arch/arm/boot/dts/ls1021a-twr.dts
> +++ b/arch/arm/boot/dts/ls1021a-twr.dts
> @@ -194,6 +194,66 @@
>  		reg = <0x0 0x0 0x8000000>;
>  		bank-width = <2>;
>  		device-width = <1>;
> +
> +		partition at 0 {
> +			/* 128KB for bank0 RCW */
> +			reg = <0x00000000 0x00020000>;
> +			label = "NOR bank0 RCW Image";
> +		};
> +
> +		partition at 100000 {
> +			/* 1MB for bank0 u-boot Image */
> +			reg = <0x00100000 0x00100000>;
> +			label = "NOR bank0 u-boot Image";
> +		};
> +
> +		partition at 200000 {
> +			/* 1MB for bank0 DTB */
> +			reg = <0x00200000 0x00100000>;
> +			label = "NOR bank0 DTB Image";
> +		};
> +
> +		partition at 300000 {
> +			/* 7MB for bank0 Linux Kernel */
> +			reg = <0x00300000 0x00700000>;
> +			label = "NOR bank0 Linux Kernel Image";
> +		};
> +
> +		partition at a00000 {
> +			/* 54MB for bank0 Ramdisk Root File System */
> +			reg = <0x00a00000 0x03600000>;
> +			label = "NOR bank0 Ramdisk Root File System Image";
> +		};
> +
> +		partition at 4000000 {
> +			/* 128KB for bank4 RCW */
> +			reg = <0x04000000 0x00020000>;
> +			label = "NOR bank4 RCW Image";
> +		};
> +
> +		partition at 4100000 {
> +			/* 1MB for bank4 u-boot Image */
> +			reg = <0x04100000 0x00100000>;
> +			label = "NOR bank4 u-boot Image";
> +		};
> +
> +		partition at 4200000 {
> +			/* 1MB for bank4 DTB */
> +			reg = <0x04200000 0x00100000>;
> +			label = "NOR bank4 DTB Image";
> +		};
> +
> +		partition at 4300000 {
> +			/* 7MB for bank4 Linux Kernel */
> +			reg = <0x04300000 0x00700000>;
> +			label = "NOR bank4 Linux Kernel Image";
> +		};
> +
> +		partition at 4a00000 {
> +			/* 54MB for bank4 Ramdisk Root File System */
> +			reg = <0x04a00000 0x03600000>;
> +			label = "NOR bank4 Ramdisk Root File System Image";
> +		};
>  	};
>  };
>  
> -- 
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
