From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 5 May 2015 21:31:18 +0800
Subject: [PATCH v3 0/5] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <1430800212-6970-1-git-send-email-bintian.wang@huawei.com>
References: <1430800212-6970-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <CAD6h2NQ2OCJmQhBG+-zT-dL=YJtpAk5T_1_m8C8SKm0RCg_D0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 May 2015 at 12:30, Bintian Wang <bintian.wang@huawei.com> wrote:
> Hi6220 is one mobile solution of Hisilicon, this patchset contains
> initial support for Hi6220 SoC and HiKey development board, which
> supports octal ARM Cortex A53 cores. Initial support is minimal and
> includes just the arch configuration, clock driver, device tree
> configuration.
>
> PSCI is enabled in device tree and there is no problem to boot all the
> octal cores, and the CPU hotplug is also working now, you can download
> and compile the latest firmware based on the following link to run this
> patch set:
> https://github.com/96boards/documentation/wiki/UEFI
>
> Changes v3:
> * Verified the CPU hotplug based on the new released firmware
> * Redefined the compatible strings of four system controllers in dts
> * Setting COMMON_CLK_HI6220 to a bool symbol
> * Keep CONFGI_ARCH_HISI sorted alphabetically
>
> Changes v2:
> * Split the DT bindings documents into earlier patches
> * Change SMP enable method from spin-table to PSCI in device tree
> * Remove "clock-frequency" from armv8-timer device node in device tree
> * Add more description about Hisilicon designed system controllers
>   in DT bindings document
> * Enable high speed clock on UART1 mux
> * Other changes based on the discussion in the mailing list:
>   https://lkml.org/lkml/2015/2/5/147
>
> Bintian Wang (5):
>   arm64: Enable Hisilicon ARMv8 SoC family in Kconfig and defconfig
>   arm64: hi6220: Document devicetree bindings for Hisilicon hi6220 SoC
>   clk: hi6220: Document devicetree bindings for hi6220 clock
>   clk: hi6220: Clock driver support for Hisilicon hi6220 SoC
>   arm64: dts: Add dts files for Hisilicon Hi6220 SoC
>
>

Acked-by: Haojian Zhuang <haojian.zhuang@linaro.org>
