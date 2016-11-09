From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 09 Nov 2016 17:40:09 +0900
Subject: [PATCH v4 0/2] pinctrl: samsung: Add the support the multiple
 IORESOURCE_MEM
Message-ID: <1478680811-24835-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches support the multiple IORESOURCE_MEM resources for one pin-bank
to support tye GPF of Samsung 64-bit Exynos5433 SoC. The exynos5433 device-tree
patches were already merged.

Changes from v3:
- Merged the Exynos5433, TM2/TM2E Device-tree patch.
- Fix the build error of pinctrl-s3c64xx/s3c24xx.c driver.
- Move the exynos5433 pinctrl compatible to patch2.
- Add the reviewed-by tag of Krzysztof Kozlowski on patch1.

Changes from v2:
(https://lkml.org/lkml/2016/8/24/426)
- Add new pctl_base and eint_base instead of virt_base on patch1.
- Modify the documentation of pinctrl-samsung.txt on patch1.
- Modify the cooling level for big.LITTLE cores.
- Use the GIC_SPI definition on dtsi file.
- Removes the unneeded 'regulator-always-on' property.
- Fix the kbuild report of the compatible string for TM2/TM2E patches.
- Two patches(exynos-mct, exynos5433-pmu) were merged.
- Add the reviewed-by tag of Javier Martinez Canillas on patch3/4/5
- Add the reviewed-by tag of Krzysztof Kozlowski on patch4/5
- Add the acked-by tag of Rob Herring on patch5
- Fix the minor issues.

Changes from v1:
(https://lkml.org/lkml/2016/8/16/61)
- Merge the cpufreq patch for exynos5433[3] on PM/cpufreq tree.
- Add new patch to support the multiple IORESOURCE_MAP for samsung pinctrl driver.
- Drop the SYSMMU Device-Tree node which will be posted by Marek Szyprowski.
- Fix the code clean issue by Krzysztof Kozlowski and Rob Herring's comment.
- Delete the unnecessary alias from exynos5433-tm2.dts.
- Expand the range of cooling level of CPU device.
- Update the binding method of 'Exynos5433 audio subsystem'

Chanwoo Choi (2):
  pinctrl: samsung: Add the support the multiple IORESOURCE_MEM for one pin-bank
  pinctrl: samsung: Add GPF support for Exynos5433

 .../bindings/pinctrl/samsung-pinctrl.txt           | 19 +++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 45 +++++++++++-----------
 drivers/pinctrl/samsung/pinctrl-exynos.h           | 11 ++++++
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c          | 37 ++++++++----------
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c          | 40 ++++++++++---------
 drivers/pinctrl/samsung/pinctrl-samsung.c          | 40 ++++++++++++-------
 drivers/pinctrl/samsung/pinctrl-samsung.h          | 10 ++++-
 7 files changed, 124 insertions(+), 78 deletions(-)

-- 
1.9.1
