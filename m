From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Tue, 29 Mar 2016 12:22:57 +0800
Subject: [PATCH] ARM64: add SBSA Generic Watchdog device node in
 amd-seattle-soc.dtsi
Message-ID: <1459225377-16317-1-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This can be a example of adding SBSA Generic Watchdog device node
into some dts files for the Soc which contains SBSA Generic Watchdog.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changelog:
v1 :Re-upstream it, since this patch was missed when we upstreamed it with
    the driver patchset: https://lkml.org/lkml/2016/3/28/226

 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index bd3adea..9798fd0 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -106,6 +106,14 @@
 			clock-names = "uartclk", "apb_pclk";
 		};
 
+		watchdog0: watchdog at e0bb0000 {
+			compatible = "arm,sbsa-gwdt";
+			reg = <0x0 0xe0bc0000 0 0x1000>,
+				<0x0 0xe0bb0000 0 0x1000>;
+			interrupts = <0 337 4>;
+			timeout-sec = <15>;
+		};
+
 		spi0: ssp at e1020000 {
 			status = "disabled";
 			compatible = "arm,pl022", "arm,primecell";
-- 
2.5.0
