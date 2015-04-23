From: fkan@apm.com (Feng Kan)
Date: Thu, 23 Apr 2015 11:07:10 -0700
Subject: [PATCH V3 4/4] arm64: dts: add proxy I2C device driver on APM X-Gene
 platform
In-Reply-To: <1429812430-31631-1-git-send-email-fkan@apm.com>
References: <1429812430-31631-1-git-send-email-fkan@apm.com>
Message-ID: <1429812430-31631-5-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add proxy I2C device driver on APM X-Gene platform.

Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Hieu Le <hnle@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index a2b9657..d405dd0 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -522,6 +522,11 @@
 					<0x0 0x7 0x4>;
 		};
 
+		i2cslimpro {
+			compatible = "apm,xgene-slimpro-i2c";
+			mboxes = <&mailbox 0>;
+		};
+
 		serial0: serial at 1c020000 {
 			status = "disabled";
 			device_type = "serial";
-- 
1.9.1
