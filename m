From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 16:08:01 +0200
Subject: [PATCH 2/2] arm: mvebu: adding SATA support: dt binding and
 config update
In-Reply-To: <1351086561-13569-3-git-send-email-gregory.clement@free-electrons.com>
References: <1351086561-13569-1-git-send-email-gregory.clement@free-electrons.com>
 <1351086561-13569-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121024140801.GB11837@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 03:49:21PM +0200, Gregory CLEMENT wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> ---
>  arch/arm/boot/dts/armada-370-db.dts  |    3 +++
>  arch/arm/boot/dts/armada-370-xp.dtsi |   10 ++++++++++
>  arch/arm/boot/dts/armada-xp-db.dts   |    3 +++
>  arch/arm/configs/mvebu_defconfig     |    7 +++++++
>  4 files changed, 23 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
> index 4a31b03..2a2aa75 100644
> --- a/arch/arm/boot/dts/armada-370-db.dts
> +++ b/arch/arm/boot/dts/armada-370-db.dts
> @@ -34,5 +34,8 @@
>  			clock-frequency = <200000000>;
>  			status = "okay";
>  		};
> +		sata at d00a0000 {
> +			status = "okay";
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 94b4b9e..3f08233 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -69,6 +69,16 @@
>  			compatible = "marvell,armada-addr-decoding-controller";
>  			reg = <0xd0020000 0x258>;
>  		};
> +
> +		sata at d00a0000 {
> +                        compatible = "marvell,orion-sata";
> +                        reg = <0xd00a0000 0x2400>;
> +                        interrupts = <55>;
> +                        nr-ports = <2>;
> +			clocks = <&coreclk 0>;//,  <&coreclk 0>;
> +                        status = "disabled";
> +		};
> +
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
> index b1fc728..b0db9a3 100644
> --- a/arch/arm/boot/dts/armada-xp-db.dts
> +++ b/arch/arm/boot/dts/armada-xp-db.dts
> @@ -46,5 +46,8 @@
>  			clock-frequency = <250000000>;
>  			status = "okay";
>  		};
> +		sata at d00a0000 {
> +			status = "okay";
> +		};
>  	};
>  };

Hi Gregory

Should there be some pinctrl setup somewhere, to ensure the pins used
for SATA are really setup up for SATA?

Also, for kirkwood, the number of SATA ports varies. So we don't
define it in the base kirkwood.dtsi and leave each board to set it.
Do we want to be consistent between kirkwood and 370/xp?

Thanks
    Andrew
