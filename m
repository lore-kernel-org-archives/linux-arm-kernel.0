From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Thu, 15 Dec 2011 12:52:03 -0600
Subject: [RFC V1 2/4] dts/imx6q: add cpufreq property
In-Reply-To: <1323947798-25251-2-git-send-email-richard.zhao@linaro.org>
References: <1323947798-25251-1-git-send-email-richard.zhao@linaro.org>
 <1323947798-25251-2-git-send-email-richard.zhao@linaro.org>
Message-ID: <4EEA41D3.9010600@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2011 05:16 AM, Richard Zhao wrote:
> Signed-off-by: Richard Zhao<richard.zhao@linaro.org>
> ---
>   arch/arm/boot/dts/imx6q.dtsi |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 263e8f3..9e9943b 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -29,6 +29,8 @@
>   			compatible = "arm,cortex-a9";
>   			reg =<0>;
>   			next-level-cache =<&L2>;
> +			cpu_freqs =<996000000 792000000 396000000 198000000>;
> +			cpu_volts =<1225000 1100000 950000 850000>;
+			trans_latency =<3000>;
>   		};
>
>   		cpu at 1 {

The trans_latency value definitely needs to be defined to avoid
strange behavior in the driver.

--Mark Langsdorf
Calxeda, Inc.
