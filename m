From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 1 Dec 2015 13:12:07 +0100
Subject: [PATCH v3 0/3] Remove ARCH_MSM* configs
In-Reply-To: <1448933123-9843-1-git-send-email-sboyd@codeaurora.org>
References: <1448933123-9843-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <565D8E97.4030505@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/2015 02:25 AM, Stephen Boyd wrote:
> This patch series allows us to remove the ARCH_MSM* configs that live
> in mach-qcom/Kconfig. They're mostly proxy configs for user selectable
> clocksource configurations anyway.
>
> Changes from v2:
>   * Renamed config in patch 1 to QCOM_ARCH_A_FAMILY to be less confusing
>
> Changes from v1:
>   * Patch 1 replaced with one that moves config to mach-qcom/Kconfig
>   * Applied Arnd's acks to patches 2 and 3
>
> Stephen Boyd (3):
>    ARM: qcom: Make an option for qcom 'a-family' platforms
>    ARM: qcom_defconfig: Enable HAVE_ARM_ARCH_TIMER
>    ARM: qcom: Drop ARCH_MSM* configs
>
>   arch/arm/Makefile               |  3 +--
>   arch/arm/configs/qcom_defconfig |  1 +
>   arch/arm/mach-qcom/Kconfig      | 17 +++++++++--------
>   3 files changed, 11 insertions(+), 10 deletions(-)

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Even it does not hurt, ARCH_MSM8X60, ARCH_MSM8960 and ARCH_MSM8974 could 
be also removed from the defconfig. Better to do it right now, so they 
won't be forgotten.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
