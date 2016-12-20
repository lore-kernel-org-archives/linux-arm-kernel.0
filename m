From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 20 Dec 2016 11:27:07 +0100
Subject: [PATCH 5/7] ARM: dts: sun8i-a33-olinuxino: add cpu-supply
In-Reply-To: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
References: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
Message-ID: <20161220102709.9504-6-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the cpu-supply DT property to the cpu0 DT node needed by
the board to adapt the regulator voltage depending on the currently use
OPP.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

This hasn't been tested on the board but it is what I understand from the
schematics[1] of the board.

Stefan (or anyone owning this board), could you test this series of patch on the
Olinuxino A33, test CPUfreq on it and tell us if it works? Thanks!

[1] https://github.com/OLIMEX/OLINUXINO/raw/master/HARDWARE/A33/A33-OLinuXino_Rev_B1.pdf

 arch/arm/boot/dts/sun8i-a33-olinuxino.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index 9ea637e..df55f54 100644
--- a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -72,6 +72,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc3>;
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.9.3
