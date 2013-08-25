From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 26 Aug 2013 02:31:11 +0900
Subject: [PATCH v7 0/7] Initial Device Tree support for S3C64xx
In-Reply-To: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
References: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <521A3F5F.8040809@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/13 06:21, Tomasz Figa wrote:
> This series adds Device Tree support for Samsung S3C64xx SoC series.
>
> It fixes several problems preventing from booting an S3C64xx-based system
> using Device Tree, adds all the infrastructure for Device Tree-based board
> support, including mach-s3c64xx-dt and dts include files for S3C64xx SoCs,
> and basic device tree source for FriendlyARM Mini6410 and SAMSUNG SMDK6410
> boards.
>
> Current support is somewhat limite, but should be fine as a start and
> will be extended in future, hopefully with help of S3C64xx board
> maintainers.
>
> Depends on:
>   - [PATCH v2 0/8] Common Clock Framework support for Samsung S3C64xx
>     http://thread.gmane.org/gmane.linux.usb.general/90493
>
> On Samsung S3C6410-based Mini6410 and SMDK6410 boards:
>
> Tested-by: Tomasz Figa<tomasz.figa@gmail.com>
>
> Changes since v6:
>   - Rebased onto current for-next branch of Kgene's tree,
>   - Dropped the idea of .init_platform() machine callback,
>   - Added support for i2c controllers,
>   - Replaced separate apb and ahb nodes with a single common soc node,
>   - Updated cpus node according to CPU bindings,
>   - Updated fixed rate clock nodes to use generic bindings,
>   - Added support for PWM buzzer and I2C EEPROM on Mini6410 board,
>   - Simplified the condition of skipping legacy GPIO initialization.
>
> Changes since v5:
>   - Rebased onto current for-next branch of Kgene's tree,
>   - Added support for new Common Clock Framework based clock driver,
>   - Introduced hierarchical structure of device nodes (representing
>     physical AHB and APB buses),
>   - Bypassed most of legacy initialization when booting with DT,
>   - Used preprocessor macros in dts files to improve readabilty,
>   - Added support for SMDK6410 board.
>
> Changes since v4:
>   - Rebased onto current for-next branch of Kgene's tree
>   - Added support for pinctrl (driver merged through pinctrl tree)
>   - Added labels to all nodes that can be overridden from board dts
>   - Modified board dts to use the&label syntax to reference device nodes
>
> Changes since v3:
>   - Rebased onto current for-next branch of Kgene's tree
>   - Updated timer node for next version of samsung-time patches
>   - Replaced local s3c64xx_dt_init_irq with irqchip_init
>
> Changes since v2:
>   - Updated timer node for next version of samsung-time patches
>
> Changes since v1:
>   - Dropped two VIC-related patches that are no longer necessary
>   - Added Device Tree-based instantation of system timers
>   - Corrected VIC interrupt specifiers
>   - Adjusted CPU compatible values and dropped @id
>
> Tomasz Figa (7):
>    ARM: common: vic: Parse interrupt and resume masks from device tree
>    ARM: s3c64xx: Bypass legacy initialization when booting with DT
>    gpio: samsung: Skip initialization if device tree is present
>    ARM: s3c64xx: Add board file for boot using Device Tree
>    ARM: dts: Add basic dts include files for Samsung S3C64xx SoCs
>    ARM: dts: Add dts file for S3C6410-based Mini6410 board
>    ARM: dts: Add dts file for S3C6410-based SMDK6410 board
>
>   Documentation/devicetree/bindings/arm/vic.txt |   6 +
>   arch/arm/boot/dts/Makefile                    |   2 +
>   arch/arm/boot/dts/s3c6400.dtsi                |  41 ++
>   arch/arm/boot/dts/s3c6410-mini6410.dts        | 228 +++++++++
>   arch/arm/boot/dts/s3c6410-smdk6410.dts        | 103 ++++
>   arch/arm/boot/dts/s3c6410.dtsi                |  57 +++
>   arch/arm/boot/dts/s3c64xx-pinctrl.dtsi        | 687 ++++++++++++++++++++++++++
>   arch/arm/boot/dts/s3c64xx.dtsi                | 199 ++++++++
>   arch/arm/mach-s3c64xx/Kconfig                 |  16 +
>   arch/arm/mach-s3c64xx/Makefile                |   1 +
>   arch/arm/mach-s3c64xx/common.c                |  12 +
>   arch/arm/mach-s3c64xx/dma.c                   |   9 +
>   arch/arm/mach-s3c64xx/irq-pm.c                |   9 +
>   arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c       |  85 ++++
>   arch/arm/mach-s3c64xx/s3c6400.c               |   9 +
>   arch/arm/mach-s3c64xx/s3c6410.c               |   9 +
>   arch/arm/plat-samsung/init.c                  |  12 +-
>   drivers/gpio/gpio-samsung.c                   |  34 +-
>   drivers/irqchip/irq-vic.c                     |   7 +-
>   19 files changed, 1497 insertions(+), 29 deletions(-)
>   create mode 100644 arch/arm/boot/dts/s3c6400.dtsi
>   create mode 100644 arch/arm/boot/dts/s3c6410-mini6410.dts
>   create mode 100644 arch/arm/boot/dts/s3c6410-smdk6410.dts
>   create mode 100644 arch/arm/boot/dts/s3c6410.dtsi
>   create mode 100644 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
>   create mode 100644 arch/arm/boot/dts/s3c64xx.dtsi
>   create mode 100644 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
>
Nice, applied this whole series.

Thanks,
Kukjin
