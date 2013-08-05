From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 Aug 2013 02:42:26 +0900
Subject: [PATCH v4 00/13] ARM: dts: Add camera and magnetometer support
 for TRATS(2) board
In-Reply-To: <1374671845-30373-1-git-send-email-s.nawrocki@samsung.com>
References: <1374671845-30373-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <51FFE402.5040902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/13 22:17, Sylwester Nawrocki wrote:
> This patch series includes some fixes and extensions to the Exynos dts
> files to add the camera and magnetometer sensor support for the TRATS
> and TRATS2 board. It depends on a patch from Tomasz adding initial
> TRATS2 board dts file [1].
>
> Changes since v3 include:
>   - removed patch adding MIPI PHY node (although it is unlikely the DT
>     binding will change the PHY driver is still in review phase),
>   - added one more patch for SPI and s5c73m3 camera.
>
> Detailed changes are listed in each patch.
>
> This series has been tested with the S5K6A3/FIMC-IS, S5C73M3 and
> S5K5BAFX cameras on top of v3.11-rc2.
>
> I have a couple more similar patches that actually enable remaining
> devices I intend to submit for v3.12, once corresponding driver
> patches are reviewed and queued.
>
> [1] http://www.spinics.net/lists/arm-kernel/msg253184.html
>
> Andrzej Hajda (3):
>    ARM: dts: Add SPI1 controller and s5c73m3 sensor node for TRATS2
>    ARM: dts: Add Exynos4210 SoC camera port pinctrl nodes
>    ARM: dts: Add S5K5BA sensor regulator definitions for Trats board
>
> Jacek Anaszewski (1):
>    ARM: dts: Add AK8975 device node for Exynos4412 TRATS2 board
>
> Sylwester Nawrocki (9):
>    ARM: dts: Correct camera pinctrl nodes for Exynos4x12 SoCs
>    ARM: dts: Add pinctrl entries for Exynos4x12 FIMC-IS peripherals
>    ARM: dts: Add ISP power domain node for Exynos4x12
>    ARM: dts: Use generic DMA bindings for Exynos4 SPI devices
>    ARM: dts: Add camera subsystem device nodes to exynos4.dtsi
>    ARM: dts: Add camera subsystem nodes to exynos4x12.dtsi
>    ARM: dts: Add camera device nodes for Exynos4412 TRATS2 board
>    ARM: dts: Add camera device nodes for Exynos4210 SoCs
>    ARM: dts: Add FIMC nodes for Exynos4210 Trats board
>
>   arch/arm/boot/dts/exynos4.dtsi            |  100 +++++++++++++++++++++--
>   arch/arm/boot/dts/exynos4210-pinctrl.dtsi |   23 ++++++
>   arch/arm/boot/dts/exynos4210-trats.dts    |  100 +++++++++++++++++++----
>   arch/arm/boot/dts/exynos4210.dtsi         |   30 +++++++
>   arch/arm/boot/dts/exynos4412-trats2.dts   |  123 +++++++++++++++++++++++++++++
>   arch/arm/boot/dts/exynos4x12-pinctrl.dtsi |   61 ++++++++++++--
>   arch/arm/boot/dts/exynos4x12.dtsi         |  103 ++++++++++++++++++++++++
>   7 files changed, 511 insertions(+), 29 deletions(-)
>
Applied this whole series, thanks.

- Kukjin
