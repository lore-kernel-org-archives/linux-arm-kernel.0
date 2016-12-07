From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 07 Dec 2016 17:53:57 +0100
Subject: [PATCH] arm: dts: rockchip: add qos node for rk3288
In-Reply-To: <1481077065-11309-1-git-send-email-zhangqing@rock-chips.com>
References: <1481077065-11309-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <5856854.mtF1yXxMzF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 7. Dezember 2016, 10:17:45 CET schrieb Elaine Zhang:
> when pd power on/off, the qos regs need to save and restore.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 84
> +++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 84
> insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 4fad13368a7b..2628edc871fa 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -699,6 +699,76 @@
>  		reg = <0xff720000 0x1000>;
>  	};
> 
> +	qos_gpu_r: qos at ffaa0000 {
> +		compatible = "syscon";
> +		reg = <0xffaa0000 0x20>;
> +	};

applied for 4.11, after moving the qos nodes to their correct place (please 
sort according to register address [aka 0xffaa.... behind the hdmi])


Thanks
Heiko
