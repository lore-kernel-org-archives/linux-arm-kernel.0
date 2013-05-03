From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:31:52 +0100
Subject: [PATCH 06/63] ARM: ux500: Pass DMA memcpy channels though Device Tree
In-Reply-To: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367591569-32197-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's now possible to configure memcpy channels dynamically with DT.
We're providing them despite the fact that they're the same as the
hard-coded channels, as they will be removed once the u8500 platform
goes DT-only.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 838214c..c693428 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -218,6 +218,7 @@
 			interrupts = <0 25 0x4>;
 
 			#dma-cells = <3>;
+			memcpy-channels = <56 57 58 59 60>;
 		};
 
 		prcmu: prcmu at 80157000 {
-- 
1.7.10.4
