From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 16 Jan 2017 15:39:22 +0100
Subject: [PATCHv3 RESEND 1/8] ARM: dts: stm32: set HSE_RTC clock frequency
 to 1 MHz on stm32f429
In-Reply-To: <1484573388-590-1-git-send-email-amelie.delaunay@st.com>
References: <1484573388-590-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <52199299-524a-631a-d076-080c03433674@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Am?lie,

On 01/16/2017 02:29 PM, Amelie Delaunay wrote:
> This patch set HSE_RTC clock frequency to 1 MHz, as the clock supplied to
> the RTC must be 1 MHz.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  arch/arm/boot/dts/stm32f429.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index e9324a3..557c1f4 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -433,6 +433,8 @@
>  			reg = <0x40023800 0x400>;
>  			clocks = <&clk_hse>, <&clk_i2s_ckin>;
>  			st,syscfg = <&pwrcfg>;
> +			assigned-clocks = <&rcc 1 CLK_HSE_RTC>;
> +			assigned-clock-rates = <1000000>;
>  		};
>
>  		dma1: dma-controller at 40026000 {
>

Applied on stm32-dt-for-v4.11

Thanks
Alex
