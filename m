From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 2 Mar 2012 17:50:22 +0100
Subject: [PATCH 10/12] arm/dts: twl4030: Add twl4030-gpio node
In-Reply-To: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Message-ID: <1330707024-23730-11-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the twl-gpio node inside twl4030 definition.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/twl4030.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index 8be5223..82a27f4 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -18,4 +18,12 @@
 		compatible = "ti,twl4030-rtc";
 		interrupts = <11>;
 	};
+
+	twl_gpio: gpio {
+		compatible = "ti,twl4030-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
 };
-- 
1.7.0.4
