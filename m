From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 27 Feb 2018 16:54:44 +0100
Subject: [PATCH] ARM: dts: stm32: Add push button to stm32f769 Discovery
 board
In-Reply-To: <20180117094005.20728-4-benjamin.gaignard@st.com>
References: <20180117094005.20728-1-benjamin.gaignard@st.com>
 <20180117094005.20728-4-benjamin.gaignard@st.com>
Message-ID: <5fc99f45-873d-163f-03a6-606735c8e30f@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 01/17/2018 10:40 AM, Benjamin Gaignard wrote:
> Add node for user push button.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>   arch/arm/boot/dts/stm32f769-disco.dts | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
> index 25a4b71f0317..8b3e1b518570 100644
> --- a/arch/arm/boot/dts/stm32f769-disco.dts
> +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> @@ -71,6 +71,18 @@
>   			gpios = <&gpioj 13 0>;
>   		};
>   	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		autorepeat;
> +		button at 0 {
> +			label = "User";
> +			linux,code = <KEY_HOME>;
> +			gpios = <&gpioa 0 0>;
> +		};
> +	};
>   };
>   
>   &cec {
> 


Applied on stm32-next.

thanks
alex
