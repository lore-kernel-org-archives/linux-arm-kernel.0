From: vbridgers2013@gmail.com (Vince Bridgers)
Date: Tue, 29 Jul 2014 17:06:45 -0500
Subject: [PATCH net v3 4/6] ARM: socfpga: Add socfpga Ethernet filter
 attributes entries
In-Reply-To: <1406671607-27368-1-git-send-email-vbridgers2013@gmail.com>
References: <1406671607-27368-1-git-send-email-vbridgers2013@gmail.com>
Message-ID: <1406671607-27368-5-git-send-email-vbridgers2013@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds socfpga Ethernet filter attributes for multicast
and unicast filters per Synopsys Ethernet IP configuration chosen
by Altera for the Cyclone 5 and Arria SOC FPGAs.

Signed-off-by: Vince Bridgers <vbridgers2013@gmail.com>
---
V3: No changes
V2: No changes
---
 arch/arm/boot/dts/socfpga.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 4676f25..70fdd20 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -486,6 +486,8 @@
 			clock-names = "stmmaceth";
 			resets = <&rst EMAC0_RESET>;
 			reset-names = "stmmaceth";
+			snps,multicast-filter-bins = <256>;
+			snps,perfect-filter-entries = <128>;
 			status = "disabled";
 		};
 
@@ -500,6 +502,8 @@
 			clock-names = "stmmaceth";
 			resets = <&rst EMAC1_RESET>;
 			reset-names = "stmmaceth";
+			snps,multicast-filter-bins = <256>;
+			snps,perfect-filter-entries = <128>;
 			status = "disabled";
 		};
 
-- 
1.7.9.5
