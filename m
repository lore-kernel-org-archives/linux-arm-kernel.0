From: kgene@kernel.org (kgene at kernel.org)
Date: Fri, 12 Sep 2014 21:26:13 +0900
Subject: [PATCH v3 0/7] Add max77802 support for Peach boards
In-Reply-To: <1410344391-5675-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1410344391-5675-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <0ae801cfce84$be443620$3acca260$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas wrote:
> 
> Hello Kukjin,
> 
Hi Javier,

> This is a third version of th series that adds max77802 support for
> the Peach Pit and Pi boards. The series also have all the pending
> patches that were posted but depended on this support. I've picked
> all the patches I found and rebased them to be sure that they apply
> cleanly on top of linux-next. Also I've taken some DT snippets from
> the downstream Chrome OS 3.8 kernel DTS for devices that use one of
> these regulators as their input supply.
> 
Thanks a lot and looks good to me. I'll take this whole series.

- Kukjin

> Changes since v2 [0]:
>  - Remove left over supply on ldo35 regulator, suggested by Doug Anderson.
>  - Add a patch to change the i2c7 clock at 400kHz, suggested by Doug Anderson.
>  - Add a patch from Vivek Gautam to enable max77802 regulator driver support.
> 
> Changes sinve v1 [1]:
>  - Dropped patch that added vmmc and vqmmc supplies as suggested
>    by Doug Anderson.
>  - Use IRQ flags define instead of a magic number as suggested by
>    Andreas Faerber.
> 
> The series is composed of the following patches:
> 
> Javier Martinez Canillas (3):
>   ARM: dts: Add Peach Pit and Pi dts entry for max77802 PMIC
>   ARM: dts: Add Peach Pit and Pi dts entry for ISL29018 sensor
>   ARM: dts: Set i2c7 clock at 400kHz for Peach boards
> 
> Naveen Krishna Chatradhi (1):
>   ARM: dts: Add thermistor dts fragment used by exynos based Peach
>     boards
> 
> Rahul Sharma (2):
>   ARM: dts: add hdmi regulators for exynos5800 based peach-pi board
>   ARM: dts: add hdmi regulators for exynos5420 based peach-pit board
> 
> Vivek Gautam (1):
>   ARM: exynos_defconfig: Enable MAX77802
> 
>  arch/arm/boot/dts/cros-adc-thermistors.dtsi |  44 ++++
>  arch/arm/boot/dts/exynos5420-peach-pit.dts  | 389 ++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5800-peach-pi.dts   | 389 ++++++++++++++++++++++++++++
>  arch/arm/configs/exynos_defconfig           |   3 +
>  4 files changed, 825 insertions(+)
>  create mode 100644 arch/arm/boot/dts/cros-adc-thermistors.dtsi
> 
> 
> Best regards,
> Javier
> 
> [0]: https://lkml.org/lkml/2014/8/20/225
> [1]: https://lkml.org/lkml/2014/8/19/372
