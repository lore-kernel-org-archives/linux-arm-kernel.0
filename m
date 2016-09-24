From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Sat, 24 Sep 2016 17:14:21 +0800
Subject: [PATCH 1/5] arm64: dts: hip06: Correct hardware pin number of usb node
In-Reply-To: <1474708465-38958-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1474708465-38958-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1474708465-38958-2-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ohci/ehci hardware pin number should be 640/641, correct them.

Fixes: commit aa8d3e74f54d ("arm64: dts: Add initial dts for Hisilicon Hip06 D03 board")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip06.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index 66b1bbf..be76f7d 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -322,7 +322,7 @@
 			compatible = "generic-ohci";
 			reg = <0x0 0xa7030000 0x0 0x10000>;
 			interrupt-parent = <&mbigen_usb>;
-			interrupts = <64 4>;
+			interrupts = <640 4>;
 			dma-coherent;
 			status = "disabled";
 		};
@@ -331,7 +331,7 @@
 			compatible = "generic-ehci";
 			reg = <0x0 0xa7020000 0x0 0x10000>;
 			interrupt-parent = <&mbigen_usb>;
-			interrupts = <65 4>;
+			interrupts = <641 4>;
 			dma-coherent;
 			status = "disabled";
 		};
-- 
1.7.12.4
