From: romain.perier@gmail.com (Romain Perier)
Date: Wed, 17 Feb 2016 18:28:34 +0100
Subject: [PATCH 2/2] ARM: dts: meson: Adding hwrev syscon node
In-Reply-To: <1455730114-2547-1-git-send-email-romain.perier@gmail.com>
References: <1455730114-2547-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1455730114-2547-3-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are the CBUS registers used to retrieve the revision and the
identifier of the SoC on Meson8.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 0477a81..71009dc 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -99,6 +99,11 @@
 		};
 	};
 
+	hwrev at c1107d4c {
+		compatible = "amlogic,meson8b-hwrev", "syscon";
+		reg = <0xc1107d4c 0x460>;
+	};
+
 	sram: sram at d9000000 {
 		compatible = "mmio-sram";
 		reg = <0xd9000000 0x20000>;
-- 
2.5.0
