From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Wed, 29 Oct 2014 16:26:04 +0800
Subject: [PATCH v4 09/10] ARM: dts: hix5hd2: add reboot node
In-Reply-To: <1414571165-23736-1-git-send-email-zhangfei.gao@linaro.org>
References: <1414571165-23736-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1414571165-23736-10-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reuse syscon-reboot, drivers/power/reset/syscon-reboot.c

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 arch/arm/boot/dts/hisi-x5hd2.dtsi |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index b8deb6c..c52722b 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -393,7 +393,13 @@
 		sysctrl: system-controller at 00000000 {
 			compatible = "hisilicon,sysctrl", "syscon";
 			reg = <0x00000000 0x1000>;
-			reboot-offset = <0x4>;
+		};
+
+		reboot {
+			compatible = "syscon-reboot";
+			regmap = <&sysctrl>;
+			offset = <0x4>;
+			mask = <0xdeadbeef>;
 		};
 
 		cpuctrl at 00a22000 {
-- 
1.7.9.5
