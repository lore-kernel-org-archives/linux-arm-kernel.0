From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 19 Oct 2018 07:57:54 +0300
Subject: [PATCH RESEND] arm64: dts: clearfog-gt-8k: enable mini-PCIe CON2 USB
Message-ID: <0336903e29be69d70a4dfc3b243d7134fba67ade.1539925074.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Deassert the reset and wireless disable signals on the CON2 mini-PCIe
socket. That allows the host to detect USB devices on the mini-PCIe
socket.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---

Resend: forgot to Cc the ARM kernel list on previous submission. Sorry
for the duplicate.
---
 .../boot/dts/marvell/armada-8040-clearfog-gt-8k.dts  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index 73df0ef5e0c4..c2e53b4edb0c 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -246,6 +246,18 @@
 		gpios = <1 GPIO_ACTIVE_HIGH>;
 		output-high;
 	};
+
+	lte_reset {
+		gpio-hog;
+		gpios = <2 GPIO_ACTIVE_LOW>;
+		output-low;
+	};
+
+	lte_disable {
+		gpio-hog;
+		gpios = <21 GPIO_ACTIVE_LOW>;
+		output-low;
+	};
 };
 
 &cp0_ethernet {
-- 
2.19.1
