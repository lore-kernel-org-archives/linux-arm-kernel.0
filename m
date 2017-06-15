From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 15 Jun 2017 21:00:58 +0100
Subject: [PATCH v3 2/2] arm64: dts: add sp804 timer node for Hi3660
In-Reply-To: <1495428748-11153-3-git-send-email-leo.yan@linaro.org>
References: <1495428748-11153-1-git-send-email-leo.yan@linaro.org>
 <1495428748-11153-3-git-send-email-leo.yan@linaro.org>
Message-ID: <5942E77A.8080500@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

On 2017/5/22 5:52, Leo Yan wrote:
> The Hi3660 SoC comes with the sp804 timer in addition to the
> architecture timers. These ones are shutdown when reaching a deep idle
> states and a backup timer is needed. The sp804 belongs to another power
> domain and can fulfill the purpose of replacing temporarily an
> architecture timer when the CPU is idle.
> 
> Describe it in the device tree, so it can be enabled at boot time.
> 
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 138fcba..f75c792 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -173,6 +173,17 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		dual_timer0: timer at fff14000 {
> +			compatible = "arm,sp804", "arm,primecell";
> +			reg = <0x0 0xfff14000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&crg_ctrl HI3660_OSC32K>,
> +				 <&crg_ctrl HI3660_OSC32K>,
> +				 <&crg_ctrl HI3660_OSC32K>;
> +			clock-names = "timer1", "timer2", "apb_pclk";
> +		};
> +
>  		ufs: ufs at ff3b0000 {
>  			compatible = "jedec,ufs-1.1", "hisilicon,hi3660-ufs";
>  			reg = <0x0 0xff3b0000 0x0 0x1000>, /* 0: HCI standard */
> 

Since the dts part is not depended on the driver and Guodong has put this into another
patch set[1], I will pick up that one.
Thanks!

[1]: https://lkml.org/lkml/2017/6/14/1049

BR,
Wei
