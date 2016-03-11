From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 11 Mar 2016 12:21:12 +0800
Subject: [PATCH v1 3/3] ARM64: dts: rk3368: Add mailbox device nodes
In-Reply-To: <1445931106-683-4-git-send-email-wxt@rock-chips.com>
References: <1445931106-683-1-git-send-email-wxt@rock-chips.com>
 <1445931106-683-4-git-send-email-wxt@rock-chips.com>
Message-ID: <56E247B8.4060306@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


? 2015?10?27? 15:31, Caesar Wang ??:
> This adds mailbox device nodes in dts.
>
> Mailbox is used by the Rockchip CPU cores to communicate
> requests to MCU processor.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
>
> Changes in v1:
> - PATCH[3/3] dts:
> - fix "processormZ"--> "processor",the miss-fingerboard.
> - Remove the shared memory in mailbox controller dtsi.
>
>   arch/arm64/boot/dts/rockchip/rk3368.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> index cc093a4..cefdad3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> @@ -484,6 +484,18 @@
>   		status = "disabled";
>   	};
>   
> +	mbox: mbox at ff6b0000 {
> +		compatible = "rockchip,rk3368-mailbox";
> +		reg = <0x0 0xff6b0000 0x0 0x1000>,
s/,/;
> +		interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru PCLK_MAILBOX>;
> +		clock-names = "pclk_mailbox";
> +		#mbox-cells = <1>;
> +	};
> +
>   	pmugrf: syscon at ff738000 {
>   		compatible = "rockchip,rk3368-pmugrf", "syscon";
>   		reg = <0x0 0xff738000 0x0 0x1000>;
