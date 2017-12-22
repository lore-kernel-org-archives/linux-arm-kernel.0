From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 22 Dec 2017 09:34:00 +0000
Subject: [PATCH] arm64: dts: hi3798cv200: add SD card support
In-Reply-To: <1508036687-13926-1-git-send-email-shawnguo@kernel.org>
References: <1508036687-13926-1-git-send-email-shawnguo@kernel.org>
Message-ID: <5A3CD188.2070206@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 2017/10/15 4:04, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> It adds device mmc at 9820000 which is used as SD card on poplar board.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Applied into hisilicon dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts |  6 ++++++
>  arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi       | 12 ++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
> index b9142871d6fe..e6fd9f296497 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
> @@ -146,6 +146,12 @@
>  	status = "okay";
>  };
>  
> +&sd0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	status = "okay";
> +};
> +
>  &spi0 {
>  	status = "okay";
>  	label = "LS-SPI0";
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> index 75865f8a862a..962bd79139e4 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> @@ -192,6 +192,18 @@
>  			status = "disabled";
>  		};
>  
> +		sd0: mmc at 9820000 {
> +			compatible = "snps,dw-mshc";
> +			reg = <0x9820000 0x10000>;
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&crg HISTB_SDIO0_CIU_CLK>,
> +				 <&crg HISTB_SDIO0_BIU_CLK>;
> +			clock-names = "ciu", "biu";
> +			resets = <&crg 0x9c 4>;
> +			reset-names = "reset";
> +			status = "disabled";
> +		};
> +
>  		emmc: mmc at 9830000 {
>  			compatible = "snps,dw-mshc";
>  			reg = <0x9830000 0x10000>;
> 
