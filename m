From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 18 Jan 2013 11:28:43 +0530
Subject: [PATCH] ARM: tegra: DTS: whistler: enable keyboard
Message-ID: <1358488723-23184-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable tegra based keyboard controller and populate the key mapping
for whistler.

With this patch, HOME, BACK, POWER and MENU keys will work.
Still other keys which are in ROW3 and ROW4 will not work as it
conflicts with KBC pins on SDIO2 pinmux.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Stephen,
Not tested the change but I reviewed all possible configuration like pinmux and
the parameter as per the downstream.
Request you to give a try.

 arch/arm/boot/dts/tegra20-whistler.dts |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index 5836ad6..b8e0ee1 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -520,6 +520,18 @@
 		bus-width = <8>;
 	};
 
+	kbc {
+		status = "okay";
+		nvidia,debounce-delay-ms = <20>;
+		nvidia,repeat-delay-ms = <160>;
+		nvidia,kbc-row-pins = <0 1 2>;
+		nvidia,kbc-col-pins = <16 17>;
+		linux,keymap = <0x00000074	/* KEY_POWER */
+				0x01000066	/* KEY_HOME */
+				0x0101009E	/* KEY_BACK */
+				0x0201008B>;	/* KEY_MENU */
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
1.7.1.1
