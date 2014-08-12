From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 12 Aug 2014 18:44:22 +0200
Subject: [PATCH 0/6] tps65090 DTS refactoring and improvements
Message-ID: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series does a refactoring by creating dtsi files for the
tps65090 PMU that can be included by DT board files that have
this component. This not only allow to remove duplicated code
but also makes it easier to maintain the tps65090 information.

So the series also improve the tps65090 description by adding
regulator constraints information and also the power scheme
for some boards that are using a simplistic model for the
connection between the regulators in the tps65090.

The refactoring was made after Doug Anderson suggestion on a
previous patch that just attempted to add the constraints to
the Peach machines DTS [0].

Patch 01/06 creates a .dtsi fragment for the tps65090 and patch
02/06 removes the duplicated definitions from the Exynos Snow
board. Patch 03/06 creates a fragment that is more specific for
the tps65090 usage in Chrome OS machines and patch 04/06 uses it
for Peach boards. Patch 05/06 model the real regulators relation
instead of the simplistic model that was used before and finally
patch 06/06 adds the tps65090 regulators constraints according to
the data manual.

NOTES: The NVIDIA Tegra114 Dalmore evaluation board also uses this
PMU and can be converted to use the .dtsi but I didn't include in
this series to avoid unnecessary cross subsystem churn. Once this
is included I can post as a follow-up patch.

Maybe the Snow can also use the cros-tps65090.dtsi instead of just
the tps65090.dtsi but someone with the schematics for this board
has to double check and can be done in a follow-up patch as well.

Javier Martinez Canillas (6):
  ARM: dts: Create fragment for tps65090 PMU
  ARM: dts: Use tps65090 fragment in exynos5250-snow
  ARM: dts: Create cros-tps65090 fragment
  ARM: dts: Use cros-tps65090 fragment in Peach boards
  ARM: dts: Improve cros-tps65090 power scheme
  ARM: dts: Add tps65090 FETs constraints

 arch/arm/boot/dts/cros-tps65090.dtsi       |  81 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250-snow.dts      | 108 ++++++++++++++---------------
 arch/arm/boot/dts/exynos5420-peach-pit.dts |  95 ++++++-------------------
 arch/arm/boot/dts/exynos5800-peach-pi.dts  |  94 ++++++-------------------
 arch/arm/boot/dts/tps65090.dtsi            |  75 ++++++++++++++++++++
 5 files changed, 251 insertions(+), 202 deletions(-)
 create mode 100644 arch/arm/boot/dts/cros-tps65090.dtsi
 create mode 100644 arch/arm/boot/dts/tps65090.dtsi

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/8/11/202
