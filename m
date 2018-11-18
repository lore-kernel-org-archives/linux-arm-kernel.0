From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 18 Nov 2018 15:20:17 +0100
Subject: [PATCH 02/10] ARM64: dts: exynos: Add all CPUs in cooling maps
In-Reply-To: <74e23257aece9ceef48b1c1cf6c9bafcce3c6fbd.1542362530.git.viresh.kumar@linaro.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
 <74e23257aece9ceef48b1c1cf6c9bafcce3c6fbd.1542362530.git.viresh.kumar@linaro.org>
Message-ID: <20181118142017.GB11419@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 03:34:25PM +0530, Viresh Kumar wrote:
> Each CPU can (and does) participate in cooling down the system but the
> DT only captures a handful of them, normally CPU0, in the cooling maps.
> Things work by chance currently as under normal circumstances its the
> first CPU of each cluster which is used by the operating systems to
> probe the cooling devices. But as soon as this CPU ordering changes and
> any other CPU is used to bring up the cooling device, we will start
> seeing failures.
> 
> Also the DT is rather incomplete when we list only one CPU in the
> cooling maps, as the hardware doesn't have any such limitations.
> 
> Update cooling maps to include all devices affected by individual trip
> points.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 36 ++++++++++++-------

Thanks, applied.

Best regards,
Krzysztof
