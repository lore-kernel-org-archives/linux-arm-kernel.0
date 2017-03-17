From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 17 Mar 2017 12:04:19 +0100
Subject: [PATCH] arm64: dts: rockchip: add dmac nodes for rk3368 SoCs
In-Reply-To: <1488534549-26175-1-git-send-email-huibin.hong@rock-chips.com>
References: <1488534549-26175-1-git-send-email-huibin.hong@rock-chips.com>
Message-ID: <36338936.qaTCZ9qzt4@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 3. M?rz 2017, 17:49:09 CET schrieb Huibin Hong:
> Addd dmac bus and dmac peri dts nodes for peripherals,
> such as I2S, SPI, UART and so on.
> 
> Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>

applied for 4.12, with the changes described below

> ---
>  arch/arm64/boot/dts/rockchip/rk3368.dtsi | 31
> +++++++++++++++++++++++++++++++ 1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3368.dtsi index a635adc..c9be1b2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> @@ -204,6 +204,37 @@
>  				     <&cpu_b2>, <&cpu_b3>;
>  	};
> 
> +	amba {

moved "amba" above "arm-pmu", please mind the alphabetical ordering in the 
future.

> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		dmac_peri: dma-controller at ff250000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x0 0xff250000 0x0 0x4000>;
> +			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			clocks = <&cru ACLK_DMAC_PERI>;
> +			clock-names = "apb_pclk";
> +			arm,pl330-broken-no-flushp;
> +			peripherals-req-type-burst;

dropped peripherals-req-type-burst, as it is not part of mainline (yet?).
Please send a patch readding that if it gets submitted and accepted at some 
point.


Heiko
