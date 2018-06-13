From: ryan@edited.us (Ryan Grachek)
Date: Wed, 13 Jun 2018 13:03:21 -0500
Subject: [PATCH] arm64: dts: hikey960: Define wl1837 power capabilities
Message-ID: <20180613180321.16745-1-ryan@edited.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These properties are required for compatibility with runtime PM.
Without these properties, MMC host controller will not be aware
of power capabilities. When the wlcore driver attempts to power
on the device, it will erroneously fail with -EACCES. This fixes
a regression found here: https://lkml.org/lkml/2018/6/12/930

Signed-off-by: Ryan Grachek <ryan@edited.us>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index c6999624ed8a..68c5a6c819ae 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -585,6 +585,8 @@
 	vmmc-supply = <&wlan_en>;
 	ti,non-removable;
 	non-removable;
+	cap-power-off-card;
+	keep-power-in-suspend;
 	#address-cells = <0x1>;
 	#size-cells = <0x0>;
 	status = "ok";
-- 
2.11.0
