From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Fri,  8 Jul 2016 10:11:07 +0200
Subject: [PATCH 2/2] arm64: dts: set UART1 clock frequency to 150MHz
In-Reply-To: <1467965467-28180-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1467965467-28180-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <1467965467-28180-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for higher baud rates (up to 3Mbps) in UART1 - required
for bluetooth transfers.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Tested-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index e92a30c..27be812 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -55,6 +55,8 @@
 		};
 
 		uart1: uart at f7111000 {
+			assigned-clocks = <&sys_ctrl HI6220_UART1_SRC>;
+			assigned-clock-rates = <150000000>;
 			status = "ok";
 		};
 
-- 
2.7.4
