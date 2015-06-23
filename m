From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 23 Jun 2015 07:46:22 +0530
Subject: [PATCH 4/8] ARM: STi: STiH407: Provide a node for CPUFreq
In-Reply-To: <1434987837-24212-5-git-send-email-lee.jones@linaro.org>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20150623021622.GA16776@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Ccing Rob]

On 22-06-15, 16:43, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index f48767e..f57fd83 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -98,6 +98,11 @@
>  		ranges;
>  		compatible = "simple-bus";
>  
> +		cpufreq {
> +			compatible = "st,stih407-cpufreq";
> +			st,syscfg = <&syscfg_core 0x8e0>;
> +		};

These virtual nodes aren't allowed in DT and you have added them
before the bindings patch :).

-- 
viresh
