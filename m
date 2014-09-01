From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 1 Sep 2014 09:22:43 +0100
Subject: [PATCH] drivers: mfd: exynos-pmu: Add support for Exynos7
In-Reply-To: <1409544769-2695-1-git-send-email-a.kesavan@samsung.com>
References: <1409544769-2695-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <20140901082243.GC6226@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 01 Sep 2014, Abhilash Kesavan wrote:

> Add intial PMU settings for exynos7. This is required for
> future suspend-to-ram and cpuidle support.
> 
> Signed-off-by: Eunseok Choi <es10.choi@samsung.com>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
> This patch has been tested on an Exynos7 espresso board and is based
> on Kgene's tree (for-next branch).
> 
> Following are the dependencies:
> 1) Support 64bit Cortex A57 based Exynos7 SoC
> http://www.spinics.net/lists/arm-kernel/msg357380.html
> 2) mfd: syscon: Decouple syscon interface from syscon devices
> http://www.spinics.net/lists/linux-samsung-soc/msg35906.html
> 3) ARM: EXYNOS: Add platform driver support for Exynos PMU
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/275675.html
> 4) ARM: EXYNOS: Move PMU specific definitions from common.h
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/270655.html
> 5) ARM: EXYNOS: Move pmu specific header files under "linux/mfd/samsung"
> https://lkml.org/lkml/2014/4/28/217
> 6) drivers: mfd: Add support for Exynos PMU driver
> https://lkml.org/lkml/2014/4/28/332
> 
> NOTE: The above dependencies are not final yet, especially the
> movement of exynos pmu driver to the mfd directory. I will re-work
> this patch when the final location for exynos PMU driver is decided.

Let me know when this patch is ready to go in and I'll review.

>  .../devicetree/bindings/arm/samsung/pmu.txt        |    1 +
>  arch/arm64/boot/dts/exynos7.dtsi                   |    5 +
>  drivers/mfd/exynos-pmu.c                           |  285 ++++++++++++++++++++
>  include/linux/mfd/samsung/exynos-regs-pmu.h        |  212 +++++++++++++++
>  4 files changed, 503 insertions(+)

This all needs to be broken up into seperate patches.

Also, see: Documentation/devicetree/bindings/submitting-patches.txt.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
