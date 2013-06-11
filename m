From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 11 Jun 2013 15:01:40 +0200
Subject: [PATCH] ARM: Kirkwood: ts219: Enable second PCIe port in DT.
Message-ID: <1370955700-18111-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the second PCIe port on QNAP TS-11x/TS-21x devices as newer
revisions (rev 1.3) have a USB 3.0 chip from Etron on PCIe port 1.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-ts219-6282.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
index aba435d..6fdc5ff 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6282.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
@@ -30,6 +30,14 @@
 				marvell,function = "gpio";
 			};
 		};
+		pcie-controller {
+			status = "okay";
+
+			pcie at 2,0 {
+				status = "okay";
+			};
+		};
+
 	};
 
 	gpio_keys {
-- 
1.7.10.4
