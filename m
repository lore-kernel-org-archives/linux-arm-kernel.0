From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  5 Feb 2012 20:13:38 +0100
Subject: [PATCH 4/4] ARM: at91: usb_a9g20/dt: add gpio-keys support
In-Reply-To: <1328469218-3208-1-git-send-email-plagnioj@jcrosoft.com>
References: <1328469218-3208-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1328469218-3208-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/usb_a9g20.dts |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index 27ab9bb..11be3e9 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -107,6 +107,20 @@
 				};
 			};
 
+			gpio_keys {
+				compatible = "gpio-keys";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				user_pb {
+					label = "user_pb";
+					gpios = <&pioB 10 1>;
+					linux,code = <28>;
+					gpio-key,wakeup;
+				};
+
+			};
+
 		};
 	};
 };
-- 
1.7.7
