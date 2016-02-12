From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 12 Feb 2016 17:50:53 +0100
Subject: [PATCH v2 2/2] ARM: mvebu: add NAND description to Armada 370 DB
 and Armada XP DB
In-Reply-To: <1455121756-20804-2-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Wed, 10 Feb 2016 17:29:16 +0100")
References: <1455121756-20804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1455121756-20804-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87egchx47m.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mer., f?vr. 10 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> This commit adds the Device Tree description for the 1GB NAND flash
> present in the Armada 370 DB and Armada XP DB evaluation boards from
> Marvell.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied on mvebu/dt, I renamed the patch to: "ARM: dts: mvebu: add NAND
description to Armada 370 DB and Armada XP DB" to unify the way we label
the dt related patch. I also added the reviewed-by tag from Andrew.

Thanks,

Gregory
> ---
> Changes since v1:
>  - Use the new MTD partitions DT binding, with all partitions grouped
>    into a 'partitions' subnode. Suggested by Andrew Lunn.
> ---
>  arch/arm/boot/dts/armada-370-db.dts | 27 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/armada-xp-db.dts  | 28 ++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
> index bb280de..2364fc5 100644
> --- a/arch/arm/boot/dts/armada-370-db.dts
> +++ b/arch/arm/boot/dts/armada-370-db.dts
> @@ -168,6 +168,33 @@
>  					spi-max-frequency = <50000000>;
>  				};
>  			};
> +
> +			nand at d0000 {
> +				status = "okay";
> +				num-cs = <1>;
> +				marvell,nand-keep-config;
> +				marvell,nand-enable-arbiter;
> +				nand-on-flash-bbt;
> +
> +				partitions {
> +					compatible = "fixed-partitions";
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +
> +					partition at 0 {
> +						label = "U-Boot";
> +						reg = <0 0x800000>;
> +					};
> +					partition at 800000 {
> +						label = "Linux";
> +						reg = <0x800000 0x800000>;
> +					};
> +					partition at 1000000 {
> +						label = "Filesystem";
> +						reg = <0x1000000 0x3f000000>;
> +					};
> +				};
> +			};
>  		};
>  
>  		pcie-controller {
> diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
> index f774101..96aaaed 100644
> --- a/arch/arm/boot/dts/armada-xp-db.dts
> +++ b/arch/arm/boot/dts/armada-xp-db.dts
> @@ -229,6 +229,34 @@
>  					spi-max-frequency = <20000000>;
>  				};
>  			};
> +
> +			nand at d0000 {
> +				status = "okay";
> +				num-cs = <1>;
> +				marvell,nand-keep-config;
> +				marvell,nand-enable-arbiter;
> +				nand-on-flash-bbt;
> +
> +				partitions {
> +					compatible = "fixed-partitions";
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +
> +					partition at 0 {
> +						label = "U-Boot";
> +						reg = <0 0x800000>;
> +					};
> +					partition at 800000 {
> +						label = "Linux";
> +						reg = <0x800000 0x800000>;
> +					};
> +					partition at 1000000 {
> +						label = "Filesystem";
> +						reg = <0x1000000 0x3f000000>;
> +
> +					};
> +				};
> +			};
>  		};
>  	};
>  };
> -- 
> 2.6.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
