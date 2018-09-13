From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 13 Sep 2018 22:29:19 +0200
Subject: [PATCH 4/4] ARM: dts: meson8b: odroidc1: add stdout-path property
In-Reply-To: <20180913202919.20927-1-martin.blumenstingl@googlemail.com>
References: <20180913202919.20927-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180913202919.20927-5-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To use the "earlycon" kernel command line parameter (without arguments)
we need a stdout-path property under the /chosen node. Add this to make
it easier to spot errors early in the boot process when looking for
them.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 7c1225658567..58669abda259 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -57,6 +57,10 @@
 		mmc0 = &sd_card_slot;
 	};
 
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	memory {
 		reg = <0x40000000 0x40000000>;
 	};
-- 
2.19.0
