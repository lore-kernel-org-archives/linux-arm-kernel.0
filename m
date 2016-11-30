From: robh@kernel.org (Rob Herring)
Date: Wed, 30 Nov 2016 14:53:33 -0600
Subject: [PATCH v2 4/9] clk: stm32f4: Add lcd-tft clock
In-Reply-To: <1479998749-20358-5-git-send-email-gabriel.fernandez@st.com>
References: <1479998749-20358-1-git-send-email-gabriel.fernandez@st.com>
 <1479998749-20358-5-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20161130205333.tiukcjbspuqmedgw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 03:45:44PM +0100, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch introduces lcd-tft clock for stm32f4 soc.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  .../devicetree/bindings/clock/st,stm32-rcc.txt     |   1 +
>  drivers/clk/clk-stm32f4.c                          | 118 +++++++++++++++++++++
>  include/dt-bindings/clock/stm32f4-clock.h          |   3 +-
>  3 files changed, 121 insertions(+), 1 deletion(-)


> diff --git a/include/dt-bindings/clock/stm32f4-clock.h b/include/dt-bindings/clock/stm32f4-clock.h
> index 56b8e10..1be4a3a 100644
> --- a/include/dt-bindings/clock/stm32f4-clock.h
> +++ b/include/dt-bindings/clock/stm32f4-clock.h
> @@ -27,7 +27,8 @@
>  #define CLK_RTC			5
>  #define PLL_VCO_I2S		6
>  #define PLL_VCO_SAI		7
> +#define CLK_LCD			8
>  
> -#define END_PRIMARY_CLK		8
> +#define END_PRIMARY_CLK		9

Do you really need this? Having this change could cause compatibility 
problems between dtb and kernel versions.

Please restructure the patch series and put all of the binding changes 
including this header into a single patch. Incrementally add s/w 
features, not h/w.

Rob
