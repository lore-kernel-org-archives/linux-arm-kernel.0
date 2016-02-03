From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Thu,  4 Feb 2016 01:18:41 +0800
Subject: [PATCH v10 3/5] ARM64: add SBSA Generic Watchdog device node in
 amd-seattle-soc.dtsi
In-Reply-To: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1454519923-25230-4-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This can be a example of adding SBSA Generic Watchdog device node
into some dts files for the Soc which contains SBSA Generic Watchdog.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index 2874d92..057e9c0 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -84,6 +84,15 @@
 			clock-names = "uartclk", "apb_pclk";
 		};
 
+		watchdog0: watchdog at e0bb0000 {
+			compatible = "arm,sbsa-gwdt";
+			reg = <0x0 0xe0bc0000 0 0x1000>,
+				<0x0 0xe0bb0000 0 0x1000>;
+			interrupts = <0 337 4>;
+			timeout-sec = <30>;
+			status = "disabled";
+		};
+
 		spi0: ssp at e1020000 {
 			status = "disabled";
 			compatible = "arm,pl022", "arm,primecell";
-- 
2.5.0
