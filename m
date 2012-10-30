From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 30 Oct 2012 08:28:12 +0530
Subject: [PATCH 0/4] pinctrl: samsung: Add support for Exynos4x12 SoCs
In-Reply-To: <1351089457-8205-1-git-send-email-t.figa@samsung.com>
References: <1351089457-8205-1-git-send-email-t.figa@samsung.com>
Message-ID: <CAJuYYwQ=RQt=9z2jSOYWEv4YJS8jsE0y3Y5bVhhbRPt-dsDMiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 October 2012 20:07, Tomasz Figa <t.figa@samsung.com> wrote:
> This patch series adds pinctrl support for SoCs from Exynos4x12 family.
>
> First two patches make necessary preperations to skip legacy GPIO and
> GPIO interrupt registration in case of Exynos4x12 SoCs which are not
> supported by legacy (non-DT) code.
>
> Third patch adds Exynos4x12-specific definitions to pinctrl-samsung driver.
>
> Fourth patch adds device nodes for pin controllers available on Exynos4x12
> SoCs to Exynos4x12 device tree sources.
>
> This series depends on:
>   - [PATCH] ARM: dts: exynos4: Add support for Exynos4x12 SoCs
>
> Tomasz Figa (4):
>   ARM: EXYNOS: Skip wakeup-int setup if pinctrl driver is used on
>     Exynos4x12
>   gpio: samsung: Skip registration if pinctrl driver is present on
>     Exynos4x12
>   pinctrl: samsung: Add support for Exynos4x12
>   ARM: dts: exynos4x12: Add nodes for pin controllers
>
>  .../bindings/pinctrl/samsung-pinctrl.txt           |   1 +
>  arch/arm/boot/dts/exynos4x12-pinctrl.dtsi          | 965 +++++++++++++++++++++
>  arch/arm/boot/dts/exynos4x12.dtsi                  |  38 +
>  arch/arm/mach-exynos/common.c                      |   7 +-
>  drivers/gpio/gpio-samsung.c                        |  43 +-
>  drivers/pinctrl/pinctrl-exynos.c                   | 110 +++
>  drivers/pinctrl/pinctrl-samsung.c                  |   2 +
>  drivers/pinctrl/pinctrl-samsung.h                  |   1 +
>  8 files changed, 1144 insertions(+), 23 deletions(-)
>  create mode 100644 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
>
> --
> 1.7.12
>

For this series:
Acked-by: Thomas Abraham <thomas.abraham@linaro.org>
