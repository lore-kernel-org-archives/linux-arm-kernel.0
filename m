From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 20 Feb 2013 21:08:48 +0530
Subject: [PATCH 1/8] ARM: dts: omap5-evm: Update available memory to 2032 MB
In-Reply-To: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
References: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1361374735-22018-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On OMAP5 to detect invalid/bad memory accesses, 16MB of DDR is used as a trap.
Hence available memory for linux OS is 2032 MB on boards popullated with 2 GB
memory.

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5-evm.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index 8722c15..b0e218a 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -16,7 +16,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x80000000 0x80000000>; /* 2 GB */
+		reg = <0x80000000 0x7F000000>; /* 2032 MB */
 	};
 
 	vmmcsd_fixed: fixedregulator-mmcsd {
-- 
1.7.9.5
