From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 28 Aug 2015 08:01:24 +0100
Subject: [PATCH v2 1/5] ARM: DT: STi: stihxxx-b2120: Add pulse-width
 properties to ssc2 & ssc3
In-Reply-To: <1440678575-21646-2-git-send-email-peter.griffin@linaro.org>
References: <1440678575-21646-1-git-send-email-peter.griffin@linaro.org>
 <1440678575-21646-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150828070124.GG4796@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Aug 2015, Peter Griffin wrote:

> Adding these properties makes the I2C bus to the demodulators much
> more reliable, and we no longer suffer from I2C errors when tuning.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stihxxx-b2120.dtsi | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> index f589fe4..62994ae 100644
> --- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
> +++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> @@ -27,12 +27,18 @@
>  			};
>  		};
>  
> -		i2c at 9842000 {
> +		ssc2: i2c at 9842000 {
>  			status = "okay";
> +			clock-frequency = <100000>;
> +			st,i2c-min-scl-pulse-width-us = <0>;
> +			st,i2c-min-sda-pulse-width-us = <5>;
>  		};
>  
> -		i2c at 9843000 {
> +		ssc3: i2c at 9843000 {
>  			status = "okay";
> +			clock-frequency = <100000>;
> +			st,i2c-min-scl-pulse-width-us = <0>;
> +			st,i2c-min-sda-pulse-width-us = <5>;
>  		};
>  
>  		i2c at 9844000 {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
