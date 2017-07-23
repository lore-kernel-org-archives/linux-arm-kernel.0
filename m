From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 23 Jul 2017 11:53:37 +0100
Subject: [PATCH 2/3] dt-bindings: iio: adc: stm32: add optional
 min-sample-time
In-Reply-To: <1500381332-17086-3-git-send-email-fabrice.gasnier@st.com>
References: <1500381332-17086-1-git-send-email-fabrice.gasnier@st.com>
 <1500381332-17086-3-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170723115337.1e34e173@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Jul 2017 14:35:31 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> STM32 ADC allows each channel to be sampled with a different sampling
> time. There's an application note that deals with this: 'How to get
> the best ADC accuracy in STM32...' It basically depends on analog input
> signal electrical properties (depends on board).
> 
> Add optional 'min-sample-time' property so this can be tuned in dt.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

This isn't yet very standard, so I think it needs a manufacturer
prefix, e.g. st,min-sample-time.  Also convention is I believe
to include the units as part of the naming where appropriate.

Hence st,min-sample-time-nsecs

Otherwise, seems good to me.

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> index 8310073..9cd964b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> @@ -74,6 +74,11 @@ Optional properties:
>    * can be 6, 8, 10 or 12 on stm32f4
>    * can be 8, 10, 12, 14 or 16 on stm32h7
>    Default is maximum resolution if unset.
> +- min-sample-time: Minimum sampling time in nanoseconds.
> +  Depending on hardware (board) e.g. high/low analog input source impedance,
> +  fine tune of ADC sampling time may be recommended.
> +  This can be either one value or an array that matches 'st,adc-channels' list,
> +  to set sample time resp. for all channels, or independently for each channel.
>  
>  Example:
>  	adc: adc at 40012000 {
