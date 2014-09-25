From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 26 Sep 2014 02:02:40 +0900
Subject: [GIT PULL 2/2] Samsung DT changes for 3.18
In-Reply-To: <5418BC93.5070008@samsung.com>
References: <5418BC93.5070008@samsung.com>
Message-ID: <54244AB0.4090301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/14 07:41, Kukjin Kim wrote:

Hi Arnd, Olof, Kevin

Oops, I missed adding arm (at) kernel.org so adding it.

Please pull.

Thanks,
Kukjin

> The following changes since commit
> 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
>
> Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
>
> are available in the git repository at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-dt
>
> for you to fetch changes up to 9b02732643d9f4b92b14f5ec041c166bd36033fc:
>
> ARM: dts: remove old USB2 PHY node for exynos5250 (2014-09-14 10:11:20
> +0900)
>
> ----------------------------------------------------------------
> Samsung DT update for 3.18
>
> - un-use slot-node and deprecate the supports-highspped
> for dw-mmc
> - remove old USB2 PHY node for exynos5250
>
> - exynos4412-odroid-common
> enable PMIC interrupt and i2c improvements
>
> - exynos5250-snow
> fold exynos5250-cros-common
> update display related nodes
>
> - Peach Pit and Pi
> improve power scheme, add support max77802 PMIC,
> add hdmi regulators add thermistor, ISL29018 sensor,
> set i2c clock at 400kHz, add support Atmel touchpad,
> update display related nodes
>
> ----------------------------------------------------------------
> Ajay Kumar (3):
> ARM: dts: update display related nodes for exynos5250-snow
> ARM: dts: update display related nodes for exynos5420-peach-pit
> ARM: dts: update display related nodes for exynos5800-peach-pi
>
> Andreas Faerber (2):
> ARM: dts: Fix MMC pinctrl for exynos5250-snow
> ARM: dts: Fold exynos5250-cros-common into exynos5250-snow
>
> Bartlomiej Zolnierkiewicz (2):
> ARM: dts: remove old USB2 PHY node hook for exynos5250-arndale
> ARM: dts: remove old USB2 PHY node for exynos5250
>
> Daniel Drake (2):
> ARM: dts: Enable PMIC interrupts for exynos4412-odroid-common
> ARM: dts: ODROID i2c improvements for exynos4412-odroid-common
>
> Jaehoon Chung (1):
> ARM: dts: unuse the slot-node and deprecate the supports-highspeed for
> dw-mmc in exynos
>
> Javier Martinez Canillas (5):
> ARM: dts: Improve Peach Pit and Pi power scheme
> ARM: dts: Add support max77802 PMIC for exynos based Peach boards
> ARM: dts: Add ISL29018 sensor for exynos based Peach boards
> ARM: dts: Set i2c7 clock at 400kHz for exynos based Peach boards
> ARM: dts: Add support Atmel touchpad for exynos5800-peach-pi
>
> Naveen Krishna Chatradhi (1):
> ARM: dts: Add thermistor dts fragment used by exynos based Peach boards
>
> Rahul Sharma (2):
> ARM: dts: add hdmi regulators for exynos5800-peach-pi
> ARM: dts: add hdmi regulators for exynos5420-peach-pit
>
> Sjoerd Simons (1):
> ARM: dts: Add support Atmel touchpad for exynos5420-peach-pit
>
> arch/arm/boot/dts/cros-adc-thermistors.dtsi | 44 +++
> arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 21 +-
> arch/arm/boot/dts/exynos4412-origen.dts | 8 +-
> arch/arm/boot/dts/exynos4412-trats2.dts | 8 +-
> arch/arm/boot/dts/exynos5250-arndale.dts | 22 +-
> arch/arm/boot/dts/exynos5250-cros-common.dtsi | 164 --------
> arch/arm/boot/dts/exynos5250-smdk5250.dts | 18 +-
> arch/arm/boot/dts/exynos5250-snow.dts | 195 ++++++++--
> arch/arm/boot/dts/exynos5250.dtsi | 15 -
> arch/arm/boot/dts/exynos5260-xyref5260.dts | 18 +-
> arch/arm/boot/dts/exynos5410-smdk5410.dts | 18 +-
> arch/arm/boot/dts/exynos5420-arndale-octa.dts | 16 +-
> arch/arm/boot/dts/exynos5420-peach-pit.dts | 482 ++++++++++++++++++++++--
> arch/arm/boot/dts/exynos5420-smdk5420.dts | 16 +-
> arch/arm/boot/dts/exynos5800-peach-pi.dts | 472 +++++++++++++++++++++--
> 15 files changed, 1130 insertions(+), 387 deletions(-)
> create mode 100644 arch/arm/boot/dts/cros-adc-thermistors.dtsi
> delete mode 100644 arch/arm/boot/dts/exynos5250-cros-common.dtsi
