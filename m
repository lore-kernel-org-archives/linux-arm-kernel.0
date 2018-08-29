From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 29 Aug 2018 11:39:12 +0200
Subject: [PATCH v1] arm64: dts: sdm845: enable tsens thermal zones
In-Reply-To: <b3c25cedfa3a9b8a4b481e714992afe62b84ca3b.1531899325.git.amit.kucheria@linaro.org>
References: <cover.1531899325.git.amit.kucheria@linaro.org>
 <b3c25cedfa3a9b8a4b481e714992afe62b84ca3b.1531899325.git.amit.kucheria@linaro.org>
Message-ID: <f416d38c-b91f-f58e-8cde-d4ad09a0a726@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/2018 09:49, Amit Kucheria wrote:
> One thermal zone per cpu is defined

The thermal zones are very close, especially when the CPUs belong to the
same 'cluster'. Very likely the temperature will propagate from one core
to another core, so when one core reaches the trip0, there is good
chance the other cores will be close and cross the trip0 threshold too.

Having multiple thermal zones, one per CPU, may trigger an interrupts
storm with the passive polling timer delay.

Does this board have a cooling device per CPU also ?



> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 170 +++++++++++++++++++++++++++++++++++
>  1 file changed, 170 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 01ff146..a75be7c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -340,4 +340,174 @@
>  			};
>  		};
>  	};
> +
> +	thermal-zones {
> +		cpu0-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 1>;
> +
> +			trips {
> +				cpu_alert0: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit0: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu1-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 2>;
> +
> +			trips {
> +				cpu_alert1: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit1: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu2-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 3>;
> +
> +			trips {
> +				cpu_alert2: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit2: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu3-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 4>;
> +
> +			trips {
> +				cpu_alert3: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit3: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu4-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 7>;
> +
> +			trips {
> +				cpu_alert4: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit4: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu5-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 8>;
> +
> +			trips {
> +				cpu_alert5: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit5: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu6-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 9>;
> +
> +			trips {
> +				cpu_alert6: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit6: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu7-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 10>;
> +
> +			trips {
> +				cpu_alert7: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit7: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
>  };
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
