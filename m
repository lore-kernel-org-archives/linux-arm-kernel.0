From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Sat, 10 Feb 2018 02:36:37 +0100
Subject: [PATCH 2/3] ARM: dts: tegra: apalis/colibri: use correct compatible
 for rtc
In-Reply-To: <20180210013638.28164-1-marcel@ziswiler.com>
References: <20180210013638.28164-1-marcel@ziswiler.com>
Message-ID: <20180210013638.28164-3-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

All Toradex Carrier Boards use a st,m41t0 compatible RTC. Compared to a
st,m41t00 this RTC has also an oscillator fail bit which allows to
detect when the RTC lost track of time.

Similar to commit c53bec16b150 ("ARM: dts: colibri/apalis: use correct
compatible for RTC") covering our NXP i.MX and Vybrid based modules.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-eval.dts    | 2 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts     | 2 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index 66b6c45ee865..af6c566e8ac4 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -114,7 +114,7 @@
 
 		/* M41T0M6 real time clock on carrier board */
 		rtc at 68 {
-			compatible = "st,m41t00";
+			compatible = "st,m41t0";
 			reg = <0x68>;
 		};
 	};
diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index fdca527a2248..0dc85a20bd45 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -88,7 +88,7 @@
 
 		/* M41T0M6 real time clock on carrier board */
 		rtc at 68 {
-			compatible = "st,m41t00";
+			compatible = "st,m41t0";
 			reg = <0x68>;
 		};
 	};
diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 8c62833197e5..16e1f387aa6d 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -60,7 +60,7 @@
 
 		/* M41T0M6 real time clock on carrier board */
 		rtc at 68 {
-			compatible = "st,m41t00";
+			compatible = "st,m41t0";
 			reg = <0x68>;
 		};
 	};
-- 
2.14.3
