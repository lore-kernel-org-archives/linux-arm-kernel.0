From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  9 Aug 2012 16:53:50 +0100
Subject: [PATCH 3/8] ARM: ux500: Identify the PRCMU as an interrupt controller
In-Reply-To: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1344527635-6163-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're just about to provide the DB8500-PRCMU with its own IRQ domain,
so that its subordinate drivers can use it as an interrupt controller.
It's obligatory for all IRQ controllers to reference themselves as
such from its own node in Device Tree. This patch does just that.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 32e063d..6da7ccb 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -194,6 +194,8 @@
 			interrupts = <0 47 0x4>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			ranges;
 
 			prcmu-timer-4 at 80157450 {
-- 
1.7.9.5
