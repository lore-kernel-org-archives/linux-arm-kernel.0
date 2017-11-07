From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 7 Nov 2017 22:38:59 +0200
Subject: [PATCH 3/3] ARM: dts: Keystone: add ECC error handler support
In-Reply-To: <1510087139-21885-1-git-send-email-t-kristo@ti.com>
References: <1510087139-21885-1-git-send-email-t-kristo@ti.com>
Message-ID: <1510087139-21885-4-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

Add emif node for keystone2 devices, which is used for ECC support.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
[t-kristo at ti.com: made emif enabled by default for all keystone2 devices]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 6 ++++++
 arch/arm/boot/dts/keystone.dtsi     | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 826b286..33e12c1 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -343,5 +343,11 @@
 			clock-names = "fck", "mmchsdb_fck";
 			status = "disabled";
 		};
+
+		emif: emif at 21010000 {
+			compatible = "ti,emif-keystone";
+			reg = <0x21010000 0x200>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_EDGE_RISING>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 8dd74f4..5f4e38f 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -340,5 +340,11 @@
 					<GIC_SPI 29 IRQ_TYPE_EDGE_RISING>;
 			};
 		};
+
+		emif: emif at 21010000 {
+			compatible = "ti,emif-keystone";
+			reg = <0x21010000 0x200>;
+			interrupts = <GIC_SPI 448 IRQ_TYPE_EDGE_RISING>;
+		};
 	};
 };
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
