From: anilkumar.v@ti.com (Kumar, Anil)
Date: Thu, 24 Jan 2013 14:08:14 +0530
Subject: [PATCH 1/2] ARM: davinci: da850: add wdt DT node
In-Reply-To: <1359016695-10362-1-git-send-email-anilkumar.v@ti.com>
References: <1359016695-10362-1-git-send-email-anilkumar.v@ti.com>
Message-ID: <1359016695-10362-2-git-send-email-anilkumar.v@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add da850 wdt DT node.

Signed-off-by: Kumar, Anil <anilkumar.v@ti.com>
---
:100644 100644 37dc5a3... 4666ce9... M	arch/arm/boot/dts/da850-evm.dts
:100644 100644 640ab75... 08bf974... M	arch/arm/boot/dts/da850.dtsi
 arch/arm/boot/dts/da850-evm.dts |    3 +++
 arch/arm/boot/dts/da850.dtsi    |    5 +++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 37dc5a3..4666ce9 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -24,5 +24,8 @@
 		serial2: serial at 1d0d000 {
 			status = "okay";
 		};
+		wdt: wdt at 1c21000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 640ab75..08bf974 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -56,5 +56,10 @@
 			interrupt-parent = <&intc>;
 			status = "disabled";
 		};
+		wdt: wdt at 1c21000 {
+			compatible = "ti,davinci-wdt";
+			reg = <0x21000 0xfff>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.4.1
