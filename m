From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 18 Oct 2015 00:35:54 +0300
Subject: [PATCH v2 5/8] arm: dts: ea3250/phy3250: specify phys memory offset
 for lpc32xx boards
In-Reply-To: <1445117757-8073-1-git-send-email-vz@mleia.com>
References: <1445117757-8073-1-git-send-email-vz@mleia.com>
Message-ID: <1445117757-8073-6-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case if SDRAM memory region is not populated by a bootloader,
provide this value in device trees for EA3250 and PHY3250 boards.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
- none, new change

 arch/arm/boot/dts/ea3250.dts  | 2 +-
 arch/arm/boot/dts/phy3250.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ea3250.dts b/arch/arm/boot/dts/ea3250.dts
index 121d032..392430b 100644
--- a/arch/arm/boot/dts/ea3250.dts
+++ b/arch/arm/boot/dts/ea3250.dts
@@ -22,7 +22,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0x4000000>;
+		reg = <0x80000000 0x4000000>;
 	};
 
 	ahb {
diff --git a/arch/arm/boot/dts/phy3250.dts b/arch/arm/boot/dts/phy3250.dts
index 2a2d2cf..79a20f7 100644
--- a/arch/arm/boot/dts/phy3250.dts
+++ b/arch/arm/boot/dts/phy3250.dts
@@ -22,7 +22,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0x4000000>;
+		reg = <0x80000000 0x4000000>;
 	};
 
 	ahb {
-- 
2.1.4
