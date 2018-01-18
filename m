From: philippe.cornu@st.com (Philippe CORNU)
Date: Thu, 18 Jan 2018 16:37:15 +0000
Subject: [PATCH 1/2] clk: stm32: END_PRIMARY_CLK should be declare after
 CLK_SYSCLK
In-Reply-To: <1516286980-8603-2-git-send-email-gabriel.fernandez@st.com>
References: <1516286980-8603-1-git-send-email-gabriel.fernandez@st.com>
 <1516286980-8603-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1dd9d895-016f-f74b-ec9d-8e02959a561d@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel,

Tested successfully on f469 disco board.

Tested-by: Philippe Cornu <philippe.cornu@st.com>

Many thanks,
Philippe :-)

On 01/18/2018 03:49 PM, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> Update of END_PRIMARY_CLK was missed, it should be after CLK_SYSCLK
> hsi and sysclk are overwritten by gpioa and gpiob.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>   include/dt-bindings/clock/stm32fx-clock.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/stm32fx-clock.h b/include/dt-bindings/clock/stm32fx-clock.h
> index 49bb3c2..4d523b0 100644
> --- a/include/dt-bindings/clock/stm32fx-clock.h
> +++ b/include/dt-bindings/clock/stm32fx-clock.h
> @@ -33,11 +33,11 @@
>   #define CLK_SAI2		11
>   #define CLK_I2SQ_PDIV		12
>   #define CLK_SAIQ_PDIV		13
> -
> -#define END_PRIMARY_CLK		14
> -
>   #define CLK_HSI			14
>   #define CLK_SYSCLK		15
> +
> +#define END_PRIMARY_CLK		16
> +
>   #define CLK_HDMI_CEC		16
>   #define CLK_SPDIF		17
>   #define CLK_USART1		18
> 
