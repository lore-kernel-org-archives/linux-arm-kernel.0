From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Jun 2014 12:06:55 +0530
Subject: [PATCH 0/4] cpufreq: Use cpufreq-cpu0 driver for Exynos3250
In-Reply-To: <1402639693-31108-1-git-send-email-cw00.choi@samsung.com>
References: <1402639693-31108-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <CAKohponQkBwDQWuOczotKn763Ne+_jSSG3B03r+xRh7-zwURvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpufreq at vger.kernel.org is dead now. Anyway you should be using linux-pm
instead.

On 13 June 2014 11:38, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patchset use cpufreq-cpu0 driver to support Exynos3250 cpufreq. So, this
> patchset is based on following patchset[1] by Thomas Abraham.
>  [1] http://www.spinics.net/lists/linux-samsung-soc/msg31593.html
>
> Chanwoo Choi (4):
>   clk: samsung: exynos3250: Use cpu-clock provider type to support cpufreq
>   clk: samsung: Add support for cpu clocks of Exynos3250
>   Documentation: devicetree: Add cpu clock configuration data binding for Exynos3250
>   ARM: dts: Exynos: Add cpu clock table and armclk divider table for Exynos3250
>
>  .../devicetree/bindings/clock/exynos3250-clock.txt | 32 ++++++++++++++++++++++
>  arch/arm/boot/dts/exynos3250.dtsi                  | 28 +++++++++++++++++++
>  drivers/clk/samsung/clk-cpu.c                      | 31 +++++++++++++++++----
>  drivers/clk/samsung/clk-exynos3250.c               | 14 +++++++---
>  4 files changed, 96 insertions(+), 9 deletions(-)

Nothing really cpufreq specific. Would *eagerly* wait for the patch that
removes existing driver files :)
