From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 10 Apr 2013 17:17:34 +0530
Subject: [PATCH 2/2] ARM: tegra: pluto: populate key mapping
In-Reply-To: <1365594454-20614-1-git-send-email-ldewangan@nvidia.com>
References: <1365594454-20614-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1365594454-20614-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keys on Pluto interfaced through Tegra KBC controller
in key matrix topology.

Add the key mapping for the keys

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
The system is booted on Pluto with the fastboot.

 arch/arm/boot/dts/tegra114-pluto.dts |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-pluto.dts b/arch/arm/boot/dts/tegra114-pluto.dts
index 6bbc8ef..290c9ce 100644
--- a/arch/arm/boot/dts/tegra114-pluto.dts
+++ b/arch/arm/boot/dts/tegra114-pluto.dts
@@ -14,6 +14,23 @@
 		status = "okay";
 	};
 
+	kbc {
+		status = "okay";
+		nvidia,debounce-delay-ms = <640>;
+		nvidia,repeat-delay-ms = <1>;
+		nvidia,kbc-row-pins = <0 1 2>;
+		nvidia,kbc-col-pins = <11 12 13>;
+		linux,keymap = < 0x00000074	/* KEY_POWER */
+				 0x00010073	/* KEY_VOLUMEUP */
+				 0x00020072	/* KEY_VOLUMEDOWN */
+				 0x010000D9	/* KEY_SEARCH */
+				 0x010100D4	/* KEY_CAMERA */
+				 0x010200D2	/* KEY_CAMERA_FOCUS */
+				 0x02000066	/* KEY_HOME */
+				 0x0201009E	/* KEY_BACK */
+				 0x0202008B>;	/* KEY_MENU */
+	};
+
 	pmc {
 		nvidia,invert-interrupt;
 	};
-- 
1.7.1.1
