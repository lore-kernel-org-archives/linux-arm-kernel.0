From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 2 Mar 2017 10:08:55 +0800
Subject: [PATCH 1/4] ARM: dts: rockchip: add rk3288 dw-mmc resets
In-Reply-To: <20170301235621.31726-1-heiko@sntech.de>
References: <20170301235621.31726-1-heiko@sntech.de>
Message-ID: <bec1b33e-e20c-5b0f-f8ef-3b6be0b8721f@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 2017/3/2 7:56, Heiko Stuebner wrote:
> dw-mmc got its reset-properties specified, so add the softresets
> for it in rk3288.
>

FWIW, for patch 1 to 4,

Reviwed-by: Shawn Lin <shawn.lin@rock-chips.com>

I guess you will follow up for ARM64 platforms?

> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index df8a0dbe9d91..ad5d6022e95f 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -236,6 +236,8 @@
>  		fifo-depth = <0x100>;
>  		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>  		reg = <0xff0c0000 0x4000>;
> +		resets = <&cru SRST_MMC0>;
> +		reset-names = "reset";
>  		status = "disabled";
>  	};
>
> @@ -248,6 +250,8 @@
>  		fifo-depth = <0x100>;
>  		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>  		reg = <0xff0d0000 0x4000>;
> +		resets = <&cru SRST_SDIO0>;
> +		reset-names = "reset";
>  		status = "disabled";
>  	};
>
> @@ -260,6 +264,8 @@
>  		fifo-depth = <0x100>;
>  		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>  		reg = <0xff0e0000 0x4000>;
> +		resets = <&cru SRST_SDIO1>;
> +		reset-names = "reset";
>  		status = "disabled";
>  	};
>
> @@ -272,6 +278,8 @@
>  		fifo-depth = <0x100>;
>  		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>  		reg = <0xff0f0000 0x4000>;
> +		resets = <&cru SRST_EMMC>;
> +		reset-names = "reset";
>  		status = "disabled";
>  	};
>
>


-- 
Best Regards
Shawn Lin
