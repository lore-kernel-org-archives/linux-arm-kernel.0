From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 29 May 2018 15:18:45 +0200
Subject: [PATCH 07/15] arm: dts: exynos: Add missing cooling device
 properties for CPUs
In-Reply-To: <cfd8de4b2ad1cfd7b0f1a0706c0b6b918e1ebffc.1527244201.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <cfd8de4b2ad1cfd7b0f1a0706c0b6b918e1ebffc.1527244201.git.viresh.kumar@linaro.org>
Message-ID: <CAJKOXPcyV=fdRu7oLXHMimSFR9ktJ23uBriswTStkEkAMbTaNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 12:31 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order.

Thanks for the patch.

In case of Exynos, the booting CPU always has these information in DT
and the booting CPU cannot be changed (chosen by firmware/hardware
configuration). Therefore there is no real risk of falling although
for correctness of DT your change makes sense.

It is too late for this cycle for me so I'll pick it up after merge window.
Alternatively, arm-soc guys can pick it up directly with my tag:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


> For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
>
> Add such missing properties.
>
> Fix other missing properties (clocks, OPP, clock latency) as well to
> make it all work.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 16 ++++++++++++++++
>  arch/arm/boot/dts/exynos4210.dtsi | 13 +++++++++++++
>  arch/arm/boot/dts/exynos4412.dtsi |  9 +++++++++
>  arch/arm/boot/dts/exynos5250.dtsi | 23 +++++++++++++++++++++++
>  4 files changed, 61 insertions(+)
>
