From: guodong.xu@linaro.org (Guodong Xu)
Date: Thu, 25 Aug 2016 11:00:40 +0800
Subject: [PATCH v2 1/2] arm64: dts: hikey: extend default cma size to 128MB
Message-ID: <1472094041-5357-1-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support display in Debian on HiKey, cma heap is used to allocate
graphic buffers. The default size of CMA is 16 MB which is not enough.

Increase the default CMA size to 128 MB.

cc: Fathi Boudra <fathi.boudra@linaro.org>
cc: John Stultz <john.stultz@linaro.org>
cc: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 9e4e06a..dba3c13 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -57,8 +57,15 @@
 			console-size	= <0x00020000>;
 			ftrace-size	= <0x00020000>;
 		};
-	};
 
+		/* global autoconfigured region for contiguous allocations */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x00000000 0x08000000>;
+			linux,cma-default;
+		};
+	};
 
 	reboot-mode-syscon at 5f01000 {
 		compatible = "syscon", "simple-mfd";
-- 
1.9.1
