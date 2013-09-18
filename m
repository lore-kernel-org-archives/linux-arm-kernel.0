From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 18 Sep 2013 18:52:32 +0530
Subject: [PATCH REPOST] ARM: tegra: use dt-binding header for key code
Message-ID: <1379510552-23401-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In place of hardcoding the key code in DTS file and comment the
key code as side notes, use the key code macro defines in the
dt-bindings/input/input.h directly.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Reposting this patch as it was sent earlier when merge window was closed.

 arch/arm/boot/dts/tegra114-dalmore.dts |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 6023028..05a3aae 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -1,5 +1,6 @@
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
 #include "tegra114.dtsi"
 
 / {
@@ -1081,26 +1082,26 @@
 		home {
 			label = "Home";
 			gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
-			linux,code = <102>; /* KEY_HOME */
+			linux,code = <KEY_HOME>;
 		};
 
 		power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
-			linux,code = <116>; /* KEY_POWER */
+			linux,code = <KEY_POWER>;
 			gpio-key,wakeup;
 		};
 
 		volume_down {
 			label = "Volume Down";
 			gpios = <&gpio TEGRA_GPIO(R, 1) GPIO_ACTIVE_LOW>;
-			linux,code = <114>; /* KEY_VOLUMEDOWN */
+			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
 		volume_up {
 			label = "Volume Up";
 			gpios = <&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_LOW>;
-			linux,code = <115>; /* KEY_VOLUMEUP */
+			linux,code = <KEY_VOLUMEUP>;
 		};
 	};
 
-- 
1.7.1.1
