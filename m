From: bintian.wang@huawei.com (Bintian)
Date: Wed, 13 May 2015 18:28:00 +0800
Subject: [PATCH v5 0/6] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <1431007225-8513-1-git-send-email-bintian.wang@huawei.com>
References: <1431007225-8513-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <55532730.4080503@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wei,

 >To be more specific here, I expect the patches to be picked up by Wei >Xu
 >and forwarded to arm at kernel.org when he's made sure that everybody
 >including himself is happy with the outcome.
 >
 >	Arnd

Could you help review and do those works based on Arnd's suggestion?

Thanks,

Also thanks to all engineers who help review/test this patch set.

Bintian


On 2015/5/7 22:00, Bintian Wang wrote:
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
> Changes v5:
> * Rebase to kernel 4.1-rc2
> * Add compatible string "hisilicon,hi6220-pl011" for Hisilicon designed
>    UART
> * clk-hi6220.c: use __initdata for non-const arrays based on the commit
>    692d8328e8c039f9497eb862c6cf835de922c061
>
> Changes v4:
> * Rebase to kernel 4.1-rc1
> * Delete "arm,cortex-a15-gic" from the gic node in dts
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
>    in DT bindings document
> * Enable high speed clock on UART1 mux
> * Other changes based on the discussion in the mailing list:
>    https://lkml.org/lkml/2015/2/5/147
>
> Bintian Wang (6):
>    arm64: Enable Hisilicon ARMv8 SoC family in Kconfig and defconfig
>    arm64: hi6220: Document devicetree bindings for Hisilicon hi6220 SoC
>    clk: hi6220: Document devicetree bindings for hi6220 clock
>    Documentation: DT: PL011: hi6220: add compatible string for Hisilicon
>          designed UART
>    clk: hi6220: Clock driver support for Hisilicon hi6220 SoC
>    arm64: dts: Add dts files for Hisilicon Hi6220 SoC
>
>   .../bindings/arm/hisilicon/hisilicon.txt           |   87 ++++++
>   .../devicetree/bindings/clock/hi6220-clock.txt     |   34 +++
>   Documentation/devicetree/bindings/serial/pl011.txt |    4 +-
>   arch/arm64/Kconfig                                 |    5 +
>   arch/arm64/boot/dts/Makefile                       |    1 +
>   arch/arm64/boot/dts/hisilicon/Makefile             |    5 +
>   arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   31 +++
>   arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  172 ++++++++++++
>   arch/arm64/configs/defconfig                       |    1 +
>   drivers/clk/Kconfig                                |    2 +
>   drivers/clk/Makefile                               |    4 +-
>   drivers/clk/hisilicon/Kconfig                      |    6 +
>   drivers/clk/hisilicon/Makefile                     |    3 +-
>   drivers/clk/hisilicon/clk-hi6220.c                 |  292 ++++++++++++++++++++
>   drivers/clk/hisilicon/clk.c                        |   29 ++
>   drivers/clk/hisilicon/clk.h                        |   17 ++
>   drivers/clk/hisilicon/clkdivider-hi6220.c          |  273 ++++++++++++++++++
>   include/dt-bindings/clock/hi6220-clock.h           |  173 ++++++++++++
>   18 files changed, 1134 insertions(+), 5 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/hi6220-clock.txt
>   create mode 100644 arch/arm64/boot/dts/hisilicon/Makefile
>   create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>   create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>   create mode 100644 drivers/clk/hisilicon/Kconfig
>   create mode 100644 drivers/clk/hisilicon/clk-hi6220.c
>   create mode 100644 drivers/clk/hisilicon/clkdivider-hi6220.c
>   create mode 100644 include/dt-bindings/clock/hi6220-clock.h
>
