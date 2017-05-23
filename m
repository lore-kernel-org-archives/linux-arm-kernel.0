From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 23 May 2017 15:59:13 +0200
Subject: [PATCH v3 3/5] ARM: dts: stm32: Add CRC support to stm32f429
In-Reply-To: <c6975a76f3437b3111c1c9f5560ad78951baa774.1495463449.git.cosardindar@gmail.com>
References: <cover.1495463449.git.cosardindar@gmail.com>
 <c6975a76f3437b3111c1c9f5560ad78951baa774.1495463449.git.cosardindar@gmail.com>
Message-ID: <3ae8fbbc-8ff1-904f-abd7-cbdf65245cff@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/22/2017 04:34 PM, Cosar Dindar wrote:
> Add CRC32 Crypto support to stm32f429.
>
> Signed-off-by: Cosar Dindar <cosardindar@gmail.com>

Will be applied in STM32 branch for next pull request.

Thanks
Alex

> ---
>  arch/arm/boot/dts/stm32f429.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index b2a2b5c..18343de 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -766,6 +766,13 @@
>  			};
>  		};
>
> +		crc: crc at 40023000 {
> +			compatible = "st,stm32f4-crc";
> +			reg = <0x40023000 0x400>;
> +			clocks = <&rcc 0 STM32F4_AHB1_CLOCK(CRC)>;
> +			status = "disabled";
> +		};
> +
>  		rcc: rcc at 40023810 {
>  			#reset-cells = <1>;
>  			#clock-cells = <2>;
>
