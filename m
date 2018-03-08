From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 8 Mar 2018 16:57:19 +0000
Subject: [PATCH v8 3/5] arm64: dts: add ufs dts node
In-Reply-To: <20180213101412.5717-4-liwei213@huawei.com>
References: <20180213101412.5717-1-liwei213@huawei.com>
 <20180213101412.5717-4-liwei213@huawei.com>
Message-ID: <5AA16B6F.2000702@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Li Wei,

On 2018/2/13 10:14, Li Wei wrote:
> arm64: dts: add ufs node for Hisilicon.
> 
> Signed-off-by: Li Wei <liwei213@huawei.com>

Fine to me. Thanks!

Acked-by: Wei Xu <xuwei5@hisilicon.com>

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index ab0b95ba5ae5..d0dfa97fdad1 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -904,6 +904,25 @@
>  			reset-gpios = <&gpio11 1 0 >;
>  		};
>  
> +		/* UFS */
> +		ufs: ufs at ff3b0000 {
> +			compatible = "hisilicon,hi3660-ufs", "jedec,ufs-1.1";
> +			/* 0: HCI standard */
> +			/* 1: UFS SYS CTRL */
> +			reg = <0x0 0xff3b0000 0x0 0x1000>,
> +				<0x0 0xff3b1000 0x0 0x1000>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&crg_ctrl HI3660_CLK_GATE_UFSIO_REF>,
> +				<&crg_ctrl HI3660_CLK_GATE_UFSPHY_CFG>;
> +			clock-names = "ref_clk", "phy_clk";
> +			/* offset: 0x84; bit: 12 */
> +			/* offset: 0x84; bit: 7  */
> +			resets = <&crg_rst 0x84 12>,
> +				<&crg_rst 0x84 7>;
> +			reset-names = "rst", "assert";
> +		};
> +
>  		/* SD */
>  		dwmmc1: dwmmc1 at ff37f000 {
>  			#address-cells = <1>;
> 
