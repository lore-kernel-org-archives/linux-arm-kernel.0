From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 3 Nov 2016 17:45:05 +0100
Subject: [PATCH v2 6/6] ARM: dts: stm32f429: Add QSPI clock
In-Reply-To: <1476436699-21879-7-git-send-email-gabriel.fernandez@st.com>
References: <1476436699-21879-1-git-send-email-gabriel.fernandez@st.com>
 <1476436699-21879-7-git-send-email-gabriel.fernandez@st.com>
Message-ID: <25482d71-4d19-997c-656a-75fbe1f43131@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel,

On 10/14/2016 11:18 AM, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>
> This patch adds the QSPI clock for stm32f469 discovery board.
>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  arch/arm/boot/dts/stm32f469-disco.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
> index e911af8..4052023 100644
> --- a/arch/arm/boot/dts/stm32f469-disco.dts
> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
> @@ -66,6 +66,10 @@
>  	};
>  };
>
> +&rcc {
> +	compatible = "st,stm32f469-rcc", "st,stm32-rcc";
> +};
> +

With this patch, stm32f469-disco doesn't boot if clk drivers patch are 
not applied.
Can you please send a new version to keep compatibility with older clk 
driver.

&rcc {
 > +	compatible = "st,stm32f469-rcc", "st,stm32-rcc";
-> compatible = "st,stm32f469-rcc", "st,stm32f42xx-rcc", "st,stm32-rcc";
 > +};
 > +
I will take it in next pull request round.


Regards
Alex


>  &clk_hse {
>  	clock-frequency = <8000000>;
>  };
>
