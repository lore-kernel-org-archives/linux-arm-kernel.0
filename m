From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 30 Apr 2013 16:41:34 +0100
Subject: [PATCH 2/5] ARM: ux500: Pass DMA memcpy channels though Device Tree
In-Reply-To: <1367336497-10650-1-git-send-email-lee.jones@linaro.org>
References: <1367336497-10650-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367336497-10650-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not possible to configure memcpy channels dynamically with DT.
We're providing them despite the fact that they're the same as the
hard-coded channels, as they will be removed once the u8500 platform
goes DT-only.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 838214c..8e80ef7 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -218,6 +218,8 @@
 			interrupts = <0 25 0x4>;
 
 			#dma-cells = <3>;
+			memcpy-channels = <56 57 58 59 60>;
+			memcpy-num-chans = <5>;
 		};
 
 		prcmu: prcmu at 80157000 {
-- 
1.7.10.4
