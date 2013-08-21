From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 21 Aug 2013 18:04:21 +0530
Subject: [PATCH 2/2] ARM: tegra: add Palmas pincontrol to Dalmore device tree
In-Reply-To: <1377088461-9499-1-git-send-email-ldewangan@nvidia.com>
References: <1377088461-9499-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1377088461-9499-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Palmas pincontrol to Dalmore device tree and make following
configuration as default:
- Disable DVFS1 and DVFS2.
- Set GPIO6 to gpio mode.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 45056a2..44413dd 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -1009,6 +1009,19 @@
 				interrupt-parent = <&palmas>;
 				interrupts = <8 0>;
 			};
+
+			palmas_pinctrl {
+				compatible = "ti,tps65913-pinctrl";
+				pinctrl-names = "default";
+				pinctrl-0 = <&palmas_default>;
+
+				palmas_default: palams_pinctrl {
+					pin_gpio6 {
+						pins = "gpio6";
+						function = "gpio";
+					};
+				};
+			};
 		};
 	};
 
-- 
1.7.1.1
