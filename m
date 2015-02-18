From: fkan@apm.com (Feng Kan)
Date: Wed, 18 Feb 2015 11:34:03 -0800
Subject: [PATCH V2 3/3] arm64: dts: add proxy I2C device driver on APM X-Gene
 platform
In-Reply-To: <1424288043-2995-1-git-send-email-fkan@apm.com>
References: <1424288043-2995-1-git-send-email-fkan@apm.com>
Message-ID: <1424288043-2995-3-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add proxy I2C device driver on APM X-Gene platform.

Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Hieu Le <hnle@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 27d6c3d..f19bb6b 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -483,6 +483,11 @@
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
