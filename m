From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Feb 2016 11:52:24 +0530
Subject: [PATCH v2 3/3] ARM: dts: Don't overheat the Odroid XU3-Lite on
 high load
In-Reply-To: <1455772383-20598-3-git-send-email-k.kozlowski@samsung.com>
References: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
 <1455772383-20598-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160218062224.GU2610@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-02-16, 14:13, Krzysztof Kozlowski wrote:
> After adding cpufreq-dt support to Exynos542x, the Odroid XU3-Lite can
> be easily overheated when launching eight CPU-intensive tasks:
> 	thermal thermal_zone3: critical temperature reached(121 C),shutting down
> 
> This seems to be specific to Odroid XU3-Lite board which officially
> supports lower frequencies than regular XU3 or XU4. When working at
> maximum CPU speed (1800 MHz big and 1300 MHz LITTLE) in warmer place for
> longer time, the fan fails to cool down the board and it reaches
> critical temperature.
> 
> Add CPU cooling to Exynos5422/5800 to fix this issue. When reaching last
> interrupt-driven trip-point (70 degrees of Celsius) start passive
> cooling in polling mode (slowing CPU by 2 steps). When reaching 85
> degrees of Celsius, start slowing even more, down to 600 MHz.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> 
> Changes since v1:
> 1. Use polling mode for passive cooling (number of configurable trip
>    points in TMU exceeded).
> 
> 2. Adjust the values (temperature and cooling levels).
> ---
>  arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi | 46 ++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
