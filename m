From: carlo@caione.org (Carlo Caione)
Date: Tue, 17 Nov 2015 15:56:36 +0100
Subject: [PATCH 1/7] ARM: DTS: meson8b: Extend L2 cache controller node
In-Reply-To: <1447772202-12418-1-git-send-email-carlo@caione.org>
References: <1447772202-12418-1-git-send-email-carlo@caione.org>
Message-ID: <1447772202-12418-2-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

This patch extends the L2 cache controller node for Amlogic Meson8b
SoCs with some missing parameters.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 8bad557..745f0f9 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -93,6 +93,9 @@
 		L2: l2-cache-controller at c4200000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xc4200000 0x1000>;
+			arm,data-latency = <3 3 3>;
+			arm,tag-latency = <2 2 2>;
+			arm,filter-ranges = <0x100000 0xc0000000>;
 			cache-unified;
 			cache-level = <2>;
 		};
-- 
2.5.0
