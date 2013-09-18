From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 18 Sep 2013 18:37:22 +0530
Subject: [PATCH V2 2/2] ARM: tegra: add palmas pincontrol to Dalmore device
 tree
In-Reply-To: <1379509642-19227-1-git-send-email-ldewangan@nvidia.com>
References: <1379509642-19227-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1379509642-19227-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Palmas pincontrol to Dalmore device tree and make following
configuration as default:
- Disable DVFS1 and DVFS2.
- Set GPIO6 to gpio mode.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
changes from V1:
- Renames the node name to pinmux as suggested on patch V1.
- Not sure that this will create the issue with other node having same
  name as pinmux in top of the dts file.

 arch/arm/boot/dts/tegra114-dalmore.dts |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 6023028..dc5cdd7 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -1011,6 +1011,19 @@
 				interrupt-parent = <&palmas>;
 				interrupts = <8 0>;
 			};
+
+			pinmux {
+				compatible = "ti,tps65913-pinctrl";
+				pinctrl-names = "default";
+				pinctrl-0 = <&palmas_default>;
+
+				palmas_default: pinmux {
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
