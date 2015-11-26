From: vigneshr@ti.com (Vignesh R)
Date: Thu, 26 Nov 2015 14:01:26 +0530
Subject: [PATCH] ARM: dts: dra72-evm: Mark uart1 rxd as wakeup capable
Message-ID: <1448526686-3998-1-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uart1 rxd  is wakeup capable on DRA72 EVM. Hence, mark rxd line as
wakeup capable. This is similar to commit 66b0436977e2c ("ARM: dts:
dra7-evm: Mark uart1 rxd as wakeup capable") for DRA74 EVM.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index d6104d5f0c01..8bf36b0b3c33 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -478,6 +478,8 @@
 
 &uart1 {
 	status = "okay";
+	interrupts-extended = <&crossbar_mpu GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+			      <&dra7_pmx_core 0x3e0>;
 };
 
 &elm {
-- 
2.6.3
