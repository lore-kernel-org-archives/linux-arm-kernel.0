From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri, 10 Mar 2017 11:39:14 +0100
Subject: [PATCH v2 04/11] ARM: dts: sun8i: olinuxino: add cpu-supply
In-Reply-To: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
Message-ID: <20170310103921.19469-5-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the cpu-supply DT property to the cpu0 DT node needed by
the board to adapt the regulator voltage depending on the currently use
OPP.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index be9a6b8..9d25e90 100644
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
